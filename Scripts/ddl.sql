CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  username VARCHAR(70) UNIQUE NOT NULL,
  contrasenia VARCHAR(70) NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  edad INT NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  nit VARCHAR(9) NOT NULL,
  dpi VARCHAR(13) NOT NULL,
  correo VARCHAR(200) NOT NULL,
  nacionalidad VARCHAR(50)
);

CREATE TABLE eventos (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  descripcion VARCHAR(255) NOT NULL,
  fecha_evento DATE NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  ubicacion VARCHAR(255) NOT NULL,
  capacidad INT NOT NULL
);

CREATE TABLE asientos (
  num_asiento VARCHAR(10) NOT NULL,
  id_evento INT NOT NULL REFERENCES eventos(id),
  PRIMARY KEY (num_asiento, id_evento)
);

CREATE TABLE estados (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE reservas (
  id SERIAL PRIMARY KEY,
  id_usuario INT NOT NULL REFERENCES usuarios(id),
  id_evento INT NOT NULL REFERENCES eventos(id),
  num_asiento VARCHAR(10) NOT NULL,
  fecha_reserva TIMESTAMP NOT NULL,
  estado INT NOT NULL DEFAULT 1 REFERENCES estados(id),
  CONSTRAINT fk_asientos_reservas FOREIGN KEY (num_asiento, id_evento)
    REFERENCES asientos(num_asiento, id_evento)
);