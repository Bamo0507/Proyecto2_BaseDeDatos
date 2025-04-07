-- Estados PENDIENTE CONFIRMADO y CANCELADO
INSERT INTO estados (nombre) VALUES ('pendiente');
INSERT INTO estados (nombre) VALUES ('confirmado');
INSERT INTO estados (nombre) VALUES ('cancelado');

-- Usuarios
INSERT INTO usuarios (username, contrasenia, nombre, edad, telefono, nit, dpi, correo, nacionalidad) VALUES
  ('user1', 'pass1', 'Alice Brown', 25, '111-1111', '111111111', '1111111111111', 'alice@example.com', 'USA'),
  ('user2', 'pass2', 'Bob Smith', 30, '222-2222', '222222222', '2222222222222', 'bob@example.com', 'Canada'),
  ('user3', 'pass3', 'Carol White', 22, '333-3333', '333333333', '3333333333333', 'carol@example.com', 'UK'),
  ('user4', 'pass4', 'Dave Johnson', 28, '444-4444', '444444444', '4444444444444', 'dave@example.com', 'Australia'),
  ('user5', 'pass5', 'Eve Black', 35, '555-5555', '555555555', '5555555555555', 'eve@example.com', 'New Zealand'),
  ('user6', 'pass6', 'Frank Green', 27, '666-6666', '666666666', '6666666666666', 'frank@example.com', 'USA'),
  ('user7', 'pass7', 'Grace Lee', 31, '777-7777', '777777777', '7777777777777', 'grace@example.com', 'Canada'),
  ('user8', 'pass8', 'Hank Miller', 29, '888-8888', '888888888', '8888888888888', 'hank@example.com', 'UK'),
  ('user9', 'pass9', 'Ivy Wilson', 24, '999-9999', '999999999', '9999999999999', 'ivy@example.com', 'Australia'),
  ('user10', 'pass10', 'Jack Davis', 33, '101-0101', '101010101', '1010101010101', 'jack@example.com', 'New Zealand');

-- Evento
INSERT INTO eventos (nombre, descripcion, fecha_evento, hora_inicio, hora_fin, ubicacion, capacidad) VALUES
  ('Concierto de Verano', 'Evento de música con Morat y Danny Ocean', '2025-08-15', '19:00:00', '23:00:00', 'Estadio Cementos Progreso', 20);

-- Asientos para el evento
-- Fila A - 10 asientos
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A1', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A2', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A3', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A4', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A5', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A6', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A7', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A8', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A9', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('A10', 1);
-- Fila B - 10 asientos
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B1', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B2', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B3', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B4', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B5', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B6', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B7', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B8', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B9', 1);
INSERT INTO asientos (num_asiento, id_evento) VALUES ('B10', 1);

-- Reservas
INSERT INTO reservas (id_usuario, id_evento, num_asiento, fecha_reserva, estado) VALUES
  (1, 1, 'A1', '2025-07-01 10:00:00', 2),  
  (2, 1, 'A2', '2025-07-01 10:05:00', 1), 
  (3, 1, 'A3', '2025-07-01 10:10:00', 2),  
  (4, 1, 'A4', '2025-07-01 10:15:00', 1), 
  (5, 1, 'A5', '2025-07-01 10:20:00', 3), 
  (6, 1, 'B1', '2025-07-01 10:25:00', 2),  
  (7, 1, 'B2', '2025-07-01 10:30:00', 1), 
  (8, 1, 'B3', '2025-07-01 10:35:00', 2),  
  (9, 1, 'B4', '2025-07-01 10:40:00', 1),
  (10, 1, 'B5', '2025-07-01 10:45:00', 2); 