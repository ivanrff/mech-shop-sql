-- CREATE DATABASE `mechanic_shop`;
USE `mechanic_shop`;

-- Criar tabela `Customers`
CREATE TABLE `Customers` (
  `customer_id` INT AUTO_INCREMENT PRIMARY KEY,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(20) UNIQUE,
  `email` VARCHAR(100) UNIQUE,
  `address` VARCHAR(255)
);

-- Criar tabela `Vehicles`
CREATE TABLE `Vehicles` (
  `vehicle_id` INT AUTO_INCREMENT PRIMARY KEY,
  `customer_id` INT NOT NULL,
  `make` VARCHAR(50) NOT NULL,
  `model` VARCHAR(50) NOT NULL,
  `year` SMALLINT NOT NULL,
  `vin` VARCHAR(17) UNIQUE NOT NULL, -- identificacao do veiculo
  `license_plate` VARCHAR(10) UNIQUE NOT NULL,
  FOREIGN KEY (`customer_id`) REFERENCES `Customers`(`customer_id`) ON DELETE CASCADE
);

-- Criar tabela `Mechanics`
CREATE TABLE `Mechanics` (
  `mechanic_id` INT AUTO_INCREMENT PRIMARY KEY,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `specialization` VARCHAR(100)
);

-- Criar tabela `Services`
CREATE TABLE `Services` (
  `service_id` INT AUTO_INCREMENT PRIMARY KEY,
  `service_name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `base_price` DECIMAL(10, 2) NOT NULL
);

-- Criar tabela `Parts`
CREATE TABLE `Parts` (
  `part_id` INT AUTO_INCREMENT PRIMARY KEY,
  `part_name` VARCHAR(100) NOT NULL,
  `manufacturer` VARCHAR(100),
  `price` DECIMAL(10, 2) NOT NULL,
  `stock_quantity` INT NOT NULL DEFAULT 0
);

-- Criar tabela `WorkOrders`
-- tabela central que une os mecânicos, veículos, etc.
CREATE TABLE `WorkOrders` (
  `work_order_id` INT AUTO_INCREMENT PRIMARY KEY,
  `vehicle_id` INT NOT NULL,
  `mechanic_id` INT,
  `date_received` DATETIME NOT NULL,
  `date_completed` DATETIME,
  `status` ENUM('Pending', 'In Progress', 'Completed', 'Canceled') NOT NULL,
  `notes` TEXT,
  FOREIGN KEY (`vehicle_id`) REFERENCES `Vehicles`(`vehicle_id`),
  FOREIGN KEY (`mechanic_id`) REFERENCES `Mechanics`(`mechanic_id`) ON DELETE SET NULL
);

-- Criar tabela `WorkOrder_Services` (Junction Table)
-- une uma ordem de serviço com os vários serviços pertencentes a ela
CREATE TABLE `WorkOrder_Services` (
  `work_order_service_id` INT AUTO_INCREMENT PRIMARY KEY,
  `work_order_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  `service_price` DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (`work_order_id`) REFERENCES `WorkOrders`(`work_order_id`) ON DELETE CASCADE,
  FOREIGN KEY (`service_id`) REFERENCES `Services`(`service_id`)
);

-- Criar tabela `WorkOrder_Parts` (Junction Table)
-- une uma ordem de serviço às várias partes relacionadas a ela
CREATE TABLE `WorkOrder_Parts` (
  `work_order_part_id` INT AUTO_INCREMENT PRIMARY KEY,
  `work_order_id` INT NOT NULL,
  `part_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(10, 2) NOT NULL, -- Price per unit at the time of service
  FOREIGN KEY (`work_order_id`) REFERENCES `WorkOrders`(`work_order_id`) ON DELETE CASCADE,
  FOREIGN KEY (`part_id`) REFERENCES `Parts`(`part_id`)
);