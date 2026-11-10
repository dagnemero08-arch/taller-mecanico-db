-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS taller_mecanico;
USE taller_mecanico;

-- 1. Tabla de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100),
    direccion TEXT
);

-- 2. Tabla de Vehículos 
CREATE TABLE vehiculos (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT,
    placa VARCHAR(20) UNIQUE NOT NULL,
    vin VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
);

-- 3. Tabla de Mecánicos / Empleados
CREATE TABLE mecanicos (
    id_mecano INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    telefono VARCHAR(20)
);

-- 4. Tabla de Repuestos / Inventario
CREATE TABLE repuestos (
    id_repuesto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_pieza VARCHAR(100) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    precio_unitario DECIMAL(10,2) NOT NULL
);

-- 5. Tabla de Órdenes de Trabajo 
CREATE TABLE ordenes_trabajo (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT,
    id_mecano INT,
    fecha_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('Pendiente', 'En Proceso', 'Finalizado', 'Entregado') DEFAULT 'Pendiente',
    observaciones TEXT,
    total_pagar DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
    FOREIGN KEY (id_mecano) REFERENCES mecanicos(id_mecano)
);

-- 6. Tabla de Detalles de Repuestos usados por Orden 
CREATE TABLE detalle_orden_repuestos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT,
    id_repuesto INT,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES ordenes_trabajo(id_orden) ON DELETE CASCADE,
    FOREIGN KEY (id_repuesto) REFERENCES repuestos(id_repuesto)
);