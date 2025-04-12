import os
import psycopg2
from psycopg2 import extensions
import threading
import time
import random
import concurrent.futures

# Conexión a la base de datos
def get_connection():
    return psycopg2.connect(
        user=os.environ.get("POSTGRES_USER"),
        password=os.environ.get("POSTGRES_PASSWORD"),
        database=os.environ.get("POSTGRES_DB"),
        host=os.environ.get("DB_HOST"),
        port=os.environ.get("DB_PORT")
    )

# Función para resetear el estado de la base de datos
# Asi cada vez que se corra una simulacion, se tiene disponible el asiento
# En el ddl se puso la restriccion que en una reserva el num_asiento con el id_usuario no puede estar repetido
def reset_database(seat="A8", event_id=1):
    conn = get_connection()
    try:
        cur = conn.cursor()
        # Eliminar todas las reservas para el asiento específico
        cur.execute("DELETE FROM reservas WHERE num_asiento = %s AND id_evento = %s", (seat, event_id))
        conn.commit()
        print(f"Asiento {seat} disponible nuevamente.")
        
    except Exception as e:
        print("Error al resetear la base de datos:", e)
        conn.rollback()
    finally:
        conn.close()

# Función para reservar
def reserve_seat(user_id, isolation_level, thread_index, max_retries, results, seat="A8", event_id=1):
    start_time = time.time()
    retry_count = 0
    success = False
    error_type = None
    
    while retry_count <= max_retries and not success:
        conn = None
        try:
            # Conectar y configurar el cursor
            conn = get_connection()
            conn.set_isolation_level(isolation_level)
            cur = conn.cursor()
            
            # Iniciar transacción
            cur.execute("BEGIN")
            
            # Validar si el asiento esta reservado
            cur.execute("""
                SELECT COUNT(*) FROM reservas 
                WHERE num_asiento = %s AND id_evento = %s
            """, (seat, event_id))
            
            initial_count = cur.fetchone()[0]
            
            # Si el asiento ya esta reservado, se cancela la transacción
            if initial_count > 0:
                conn.rollback()
                error_type = "ya se reservó"
                break
            
            # Simulacion de procesamiento 
            time.sleep(random.uniform(0.05, 0.15))
            
            # Se trata de bloquear el asiento
            try:
                # El NOWAIT hace que si ya se bloqueo el asiento tire error, lo que manda al excpet
                cur.execute("""
                    SELECT * FROM asientos 
                    WHERE num_asiento = %s AND id_evento = %s 
                    FOR UPDATE NOWAIT
                """, (seat, event_id))

            except psycopg2.errors.LockNotAvailable:
                # Cancelamos la transaccion
                conn.rollback()
                error_type = "no se pudo bloquear el asiento"
                
                # si no nos hemos pasado de los 3 intentos de bloqueos
                # aumenta el contador de reintento y se espera un momento 
                # pequeño antes de volver a intentar y asi evitar mas colisiones
                if retry_count < max_retries:
                    retry_count += 1
                    time.sleep(random.uniform(0.1, 0.2) * retry_count)
                    continue
                break
            
            # Simular procesamiento
            time.sleep(random.uniform(0.05, 0.1))
            
            # Se vuelve a consultar si no fue reservado
            # esto se vuelve a hacer en este punto por si a caso
            # el asiento fue reservado por otro hilo mientras se bloqueaba
            cur.execute("""
                SELECT COUNT(*) FROM reservas 
                WHERE num_asiento = %s AND id_evento = %s
            """, (seat, event_id))
            final_count = cur.fetchone()[0]
            
            # Si el asiento fue reservado, cancelamos la transacción
            if final_count > 0:
                conn.rollback()
                error_type = "asiento reservado mientras se bloqueaba"
                
                if retry_count < max_retries:
                    retry_count += 1
                    time.sleep(random.uniform(0.1, 0.2) * retry_count)
                    continue
                break
            
            # Insertar reserva
            try:
                cur.execute("""
                    INSERT INTO reservas (id_usuario, id_evento, num_asiento, fecha_reserva, estado)
                    VALUES (%s, %s, %s, NOW(), 1)
                """, (user_id, event_id, seat))
                
                # Intentar hacer el commit
                conn.commit()
                success = True
                
            except psycopg2.Error as e:
                conn.rollback()
                error_type = "Ya habia un dato insertado"
                
                if retry_count < max_retries:
                    retry_count += 1
                    time.sleep(random.uniform(0.1, 0.2) * retry_count)
                    continue
                break
                
        except psycopg2.errors.SerializationFailure as e:
            if conn:
                conn.rollback()
            error_type = "se bloqueo la consulta por serializacion"
            
            if retry_count < max_retries:
                retry_count += 1
                time.sleep(random.uniform(0.1, 0.3) * retry_count)
                continue
            break
            
        except Exception as e:
            if conn:
                conn.rollback()
            error_type = "otro error"
            break
            
        # cerrar conexion para evitar memory leaks
        finally:
            if conn:
                conn.close()
    
    elapsed_time = time.time() - start_time
    
    # Almacenar resultados
    results[thread_index] = {
        "success": success,
        "time": elapsed_time
    }

# Ejecutar la simulación
def run_simulation(num_users, isolation_str, retries = 0):
    iso_levels = {
        "READ COMMITTED": extensions.ISOLATION_LEVEL_READ_COMMITTED,
        "REPEATABLE READ": extensions.ISOLATION_LEVEL_REPEATABLE_READ,
        "SERIALIZABLE": extensions.ISOLATION_LEVEL_SERIALIZABLE
    }
    isolation_level = iso_levels.get(isolation_str)

    # Resetear la base de datos para poder "liberar" el asiento
    reset_database(seat="A8", event_id=1)
    
    # Preparar para almacenar resultados
    results = [None] * num_users
    
    print(f"\n=== Simulación con {num_users} usuarios en {isolation_str} ===")
    
    start_time = time.time()
    
    # Ejecutar hilos
    with concurrent.futures.ThreadPoolExecutor(max_workers=num_users) as executor:
        futures = []

        max_retries = retries
        if isolation_str == "SERIALIZABLE":
            max_retries = 3     
        
        for i in range(num_users):
            user_id = i + 1
            futures.append(
                executor.submit(
                    reserve_seat, 
                    user_id, 
                    isolation_level, 
                    i, 
                    max_retries,
                    results,
                    "A8",  
                    1
                )
            )
        
        # Esperar a que todos los hilos terminen
        concurrent.futures.wait(futures)
    
    total_time = time.time() - start_time
    
    # Analizar resultados
    success_count = sum(1 for r in results if r["success"])
    failed_count = num_users - success_count
    
    # Calcular tiempo promedio
    avg_time = (sum(r["time"] for r in results)) / num_users
    
    # Mostrar resultados simplificados
    print("\n=== Resultados ===")
    print(f"Nivel de Aislamiento: {isolation_str}")
    print(f"Usuarios Concurrentes: {num_users}")
    print(f"Reservas Exitosas: {success_count}")
    print(f"Reservas Fallidas: {failed_count}")
    print(f"Tiempo Promedio por Transacción: {avg_time*1000:.2f} ms")
    print(f"Tiempo Total de Simulación: {total_time:.3f} segundos")
    
    return {
        "success_count": success_count,
        "failed_count": failed_count,
        "avg_time": avg_time,
        "total_time": total_time
    }

# Función para seleccionar número de usuarios del menú
def select_num_users():
    while True:
        print("\nSeleccione el número de usuarios para la simulación:")
        print("1. 5 usuarios")
        print("2. 10 usuarios")
        print("3. 20 usuarios")
        print("4. 30 usuarios")
        
        try:
            choice = int(input("Ingrese su opción (1-4): "))
            
            if choice == 1:
                return 5
            elif choice == 2:
                return 10
            elif choice == 3:
                return 20
            elif choice == 4:
                return 30
            else:
                print("Opción no válida. Por favor, seleccione una opción entre 1 y 4.")
        except ValueError:
            print("Por favor, ingresa un número válido.")

def main_menu():
    while True:
        print("\n=== Sistema de Simulación de Niveles de Aislamiento ===")
        print("1. Comparar niveles de aislamiento")
        print("2. Salir")
        
        try:
            choice = int(input("Seleccione una opción: "))
            
            if choice == 1:
                # Seleccionar número de usuarios desde el menú
                num_users = select_num_users()
                
                isolation_levels = ["READ COMMITTED", "REPEATABLE READ", "SERIALIZABLE"]
                all_results = {}
                
                for level in isolation_levels:
                    print(f"\nEjecutando simulación con nivel {level}...")
                    all_results[level] = run_simulation(num_users, level)
                    time.sleep(1)  # Pausa entre simulaciones
                    
                print("\n=== Comparación de Niveles de Aislamiento ===")
                print(f"Usuarios Concurrentes: {num_users}")
                
                for level in isolation_levels:
                    results = all_results[level]
                    print(f"{level}: {results['success_count']} exitosas, {results['failed_count']} fallidas, "
                        f"Tiempo Promedio por Transacción: {results['avg_time']:.4f} s, "
                        f"Tiempo Total de Simulación: {results['total_time']:.4f} s")
                
            elif choice == 2:
                print("Saliendo del programa...")
                break
                
            else:
                print("Opción no válida. Por favor, seleccione 1 o 2.")
                
        except ValueError:
            print("Por favor, ingrese un número válido.")

if __name__ == "__main__":
    main_menu()