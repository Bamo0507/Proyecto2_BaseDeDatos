# Simulación de Niveles de Aislamiento en PostgreSQL

Este proyecto es una aplicación en Python diseñada para simular y comparar el comportamiento de diferentes niveles de aislamiento en una base de datos PostgreSQL. Se utiliza Docker para levantar tanto la base de datos como la aplicación de simulación, permitiendo evaluar cómo se comportan los niveles de aislamiento READ COMMITTED, REPEATABLE READ y SERIALIZABLE en escenarios de alta concurrencia.

## Características

- **Simulación de Reservas**: Múltiples usuarios intentan reservar simultáneamente el mismo asiento en un evento.
- **Manejo de Concurrencia**: Usa transacciones, y bloqueos FOR UPDATE.
- **Inicialización Controlada**: Un shell script asegura que primero se ejecute el ddl.sql, y luego el data.sql

## Requisitos Previos

- Docker
- Docker Compose

## Estructura del Proyecto

```
|__ app.py                     # donde se encuentra la aplicacion
├── .env.example               # Ejemplo de variables de entorno
├── docker-compose.yml.example # Ejemplo para Docker Compose
├── .gitignore                 # Ignora archivos sensibles
├── Dockerfile                 # Imagen Docker para la aplicación
├── requirements.txt           # Dependencias Python
└── Scripts
    ├── ddl.sql                # Creación de la base de datos
    ├── data.sql               # Datos iniciales
    └── init.sh                # Script que ejecuta ddl.sql y data.sql
```

## Instalación y Configuración

### 1. Configuración Inicial

Copia los archivos de ejemplo y configúralos:

```bash
cp .env.example .env
cp docker-compose.yml.example docker-compose.yml
```

### 2. Configuración del Entorno (`.env`)

Define variables como usuario, contraseña y puerto:

```dotenv
POSTGRES_USER=usuario
POSTGRES_PASSWORD=contrasena
POSTGRES_DB=eventos_db
POSTGRES_PORT=5439

DB_HOST=postgres
DB_PORT=5432
```

### 3. Permisos del Shell Script

Dale permisos de ejecución al script `init.sh`:

```bash
chmod +x ./Scripts/init.sh
```

## Ejecución del Proyecto

Inicia los contenedores:

```bash
docker-compose run --rm app
```

- El script `init.sh` inicializará la base de datos.
- La aplicación mostrará un menú interactivo para iniciar la simulación.

## Uso del Simulador

- Selecciona la opción para comparar niveles de aislamiento.
- Escoge la cantidad de usuarios concurrentes (5, 10, 20, 30).

