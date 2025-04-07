-- Estados PENDIENTE, CONFIRMADO, CANCELADO
INSERT INTO estados (nombre) VALUES ('pendiente');
INSERT INTO estados (nombre) VALUES ('confirmado');
INSERT INTO estados (nombre) VALUES ('cancelado');

-- Usuarios 
INSERT INTO usuarios (username, contrasenia, nombre, edad, telefono, nit, dpi, correo, nacionalidad) VALUES
  ('juanperez', 'pass123', 'Juan Pérez', 28, '809-123-4567', '123456789', '1234567890123', 'juan.perez@mail.com', 'Dominicano'),
  ('mariagarcia', 'pass234', 'María García', 32, '809-234-5678', '987654321', '9876543210987', 'maria.garcia@mail.com', 'Mexicana'),
  ('carlosrodriguez', 'pass345', 'Carlos Rodríguez', 26, '809-345-6789', '234567891', '2345678910123', 'carlos.rodriguez@mail.com', 'Colombiano'),
  ('lauragonzalez', 'pass456', 'Laura González', 30, '809-456-7890', '345678912', '3456789120123', 'laura.gonzalez@mail.com', 'Española'),
  ('andresmartinez', 'pass567', 'Andrés Martínez', 35, '809-567-8901', '456789123', '4567891230123', 'andres.martinez@mail.com', 'Argentino'),
  ('sofiaramos', 'pass678', 'Sofía Ramos', 27, '809-678-9012', '567891234', '5678912340123', 'sofia.ramos@mail.com', 'Chilena'),
  ('diegosanchez', 'pass789', 'Diego Sánchez', 29, '809-789-0123', '678912345', '6789123450123', 'diego.sanchez@mail.com', 'Peruano'),
  ('anaperez', 'pass890', 'Ana Pérez', 31, '809-890-1234', '789123456', '7891234560123', 'ana.perez@mail.com', 'Costarricense'),
  ('joselopez', 'pass901', 'José López', 24, '809-901-2345', '891234567', '8912345670123', 'jose.lopez@mail.com', 'Uruguayo'),
  ('patriciamorales', 'pass012', 'Patricia Morales', 28, '809-012-3456', '912345678', '9123456780123', 'patricia.morales@mail.com', 'Boliviana'),
  ('fernandojimenez', 'pass112', 'Fernando Jiménez', 33, '809-111-2222', '112345679', '1123456790123', 'fernando.jimenez@mail.com', 'Ecuatoriano'),
  ('silviaruiz', 'pass223', 'Silvia Ruiz', 25, '809-222-3333', '212345678', '2123456780123', 'silvia.ruiz@mail.com', 'Dominicana'),
  ('marcosdiaz', 'pass334', 'Marcos Díaz', 27, '809-333-4444', '312345678', '3123456780123', 'marcos.diaz@mail.com', 'Costarricense'),
  ('lauramendoza', 'pass445', 'Laura Mendoza', 29, '809-444-5555', '412345678', '4123456780123', 'laura.mendoza@mail.com', 'Chilena'),
  ('alejandrocortes', 'pass556', 'Alejandro Cortés', 30, '809-555-6666', '512345678', '5123456780123', 'alejandro.cortes@mail.com', 'Mexicano'),
  ('victoriafernandez', 'pass667', 'Victoria Fernández', 32, '809-666-7777', '612345678', '6123456780123', 'victoria.fernandez@mail.com', 'Española'),
  ('robertoperez', 'pass778', 'Roberto Pérez', 34, '809-777-8888', '712345678', '7123456780123', 'roberto.perez@mail.com', 'Argentino'),
  ('danielgarcia', 'pass889', 'Daniel García', 26, '809-888-9999', '812345678', '8123456780123', 'daniel.garcia@mail.com', 'Colombiano'),
  ('estefanagarcia', 'pass990', 'Estefana García', 28, '809-999-0000', '912345679', '9123456790123', 'estefana.garcia@mail.com', 'Ecuatoriana'),
  ('ricardorodriguez', 'pass101', 'Ricardo Rodríguez', 35, '809-101-0101', '102345678', '1023456780123', 'ricardo.rodriguez@mail.com', 'Peruano'),
  ('claudiasanchez', 'pass202', 'Claudia Sánchez', 31, '809-202-0202', '112345680', '1123456800123', 'claudia.sanchez@mail.com', 'Boliviana'),
  ('martinlopez', 'pass303', 'Martín López', 27, '809-303-0303', '122345678', '1223456780123', 'martin.lopez@mail.com', 'Dominicano'),
  ('angelamoreno', 'pass404', 'Ángela Moreno', 29, '809-404-0404', '132345678', '1323456780123', 'angela.moreno@mail.com', 'Chilena'),
  ('ricardocastro', 'pass505', 'Ricardo Castro', 33, '809-505-0505', '142345678', '1423456780123', 'ricardo.castro@mail.com', 'Español'),
  ('marcelarodriguez', 'pass606', 'Marcela Rodríguez', 26, '809-606-0606', '152345678', '1523456780123', 'marcela.rodriguez@mail.com', 'Mexicana'),
  ('jorgelopez', 'pass707', 'Jorge López', 30, '809-707-0707', '162345678', '1623456780123', 'jorge.lopez@mail.com', 'Colombiano'),
  ('veronicaramirez', 'pass808', 'Verónica Ramírez', 28, '809-808-0808', '172345678', '1723456780123', 'veronica.ramirez@mail.com', 'Uruguaya'),
  ('gustavomartinez', 'pass909', 'Gustavo Martínez', 34, '809-909-0909', '182345678', '1823456780123', 'gustavo.martinez@mail.com', 'Dominicano'),
  ('monicalopez', 'pass010', 'Mónica López', 27, '809-010-1010', '192345678', '1923456780123', 'monica.lopez@mail.com', 'Costarricense'),
  ('estebanruiz', 'pass111', 'Esteban Ruiz', 31, '809-111-1212', '202345678', '2023456780123', 'esteban.ruiz@mail.com', 'Ecuatoriano');

-- Evento
INSERT INTO eventos (nombre, descripcion, fecha_evento, hora_inicio, hora_fin, ubicacion, capacidad)
VALUES ('Festival Internacional de Música', 'Concierto con Morat, Danny Ocean, Mau y Ricky, y Quevedo', '2025-12-20', '18:00:00', '23:00:00', 'Estadio Nacional', 40);

-- Asientos
-- Fila A
INSERT INTO asientos (num_asiento, id_evento) VALUES
  ('A1', 1), ('A2', 1), ('A3', 1), ('A4', 1), ('A5', 1),
  ('A6', 1), ('A7', 1), ('A8', 1), ('A9', 1), ('A10', 1),
  ('A11', 1), ('A12', 1), ('A13', 1), ('A14', 1), ('A15', 1),
  ('A16', 1), ('A17', 1), ('A18', 1), ('A19', 1), ('A20', 1);

-- Fila B
INSERT INTO asientos (num_asiento, id_evento) VALUES
  ('B1', 1), ('B2', 1), ('B3', 1), ('B4', 1), ('B5', 1),
  ('B6', 1), ('B7', 1), ('B8', 1), ('B9', 1), ('B10', 1),
  ('B11', 1), ('B12', 1), ('B13', 1), ('B14', 1), ('B15', 1),
  ('B16', 1), ('B17', 1), ('B18', 1), ('B19', 1), ('B20', 1);

-- Reservas
INSERT INTO reservas (id_usuario, id_evento, num_asiento, fecha_reserva, estado) VALUES
  (1, 1, 'A1', '2025-11-10 10:00:00', 2),
  (2, 1, 'A2', '2025-11-10 10:05:00', 1),
  (3, 1, 'A3', '2025-11-10 10:10:00', 2),
  (4, 1, 'A4', '2025-11-10 10:15:00', 1),
  (5, 1, 'A5', '2025-11-10 10:20:00', 3),
  (6, 1, 'B1', '2025-11-10 10:25:00', 2),
  (7, 1, 'B2', '2025-11-10 10:30:00', 1),
  (8, 1, 'B3', '2025-11-10 10:35:00', 2),
  (9, 1, 'B4', '2025-11-10 10:40:00', 1),
  (10, 1, 'B5', '2025-11-10 10:45:00', 2),
  (11, 1, 'A6', '2025-11-10 10:50:00', 2),
  (12, 1, 'A7', '2025-11-10 10:55:00', 1),
  (13, 1, 'B6', '2025-11-10 11:00:00', 2),
  (14, 1, 'B7', '2025-11-10 11:05:00', 1),
  (15, 1, 'B8', '2025-11-10 11:10:00', 2);