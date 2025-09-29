-- --- Inserindo alguns dados de exemplo ---

-- Customers
INSERT INTO `Customers` (`first_name`, `last_name`, `phone_number`, `email`) VALUES
('John', 'Smith', '555-0101', 'john.smith@email.com'),
('Jane', 'Doe', '555-0102', 'jane.doe@email.com');

-- Vehicles
INSERT INTO `Vehicles` (`customer_id`, `make`, `model`, `year`, `vin`, `license_plate`) VALUES
(1, 'Honda', 'Civic', 2018, '1HGFB2F53JA000001', 'ABC-1234'),
(2, 'Ford', 'Focus', 2020, '3FA6P0HD7LR000002', 'XYZ-5678');

-- Mechanics
INSERT INTO `Mechanics` (`first_name`, `last_name`, `specialization`) VALUES
('Mike', 'Miller', 'Engine & Transmission'),
('Paul', 'Williams', 'Brakes & Suspension');

-- Services
INSERT INTO `Services` (`service_name`, `base_price`) VALUES
('Standard Oil Change', 50.00),
('Brake Pad Replacement (Front)', 150.00),
('Tire Rotation', 25.00);

-- Parts
INSERT INTO `Parts` (`part_name`, `manufacturer`, `price`, `stock_quantity`) VALUES
('Synthetic Oil 5L', 'BrandX', 35.00, 100),
('Oil Filter', 'BrandX', 10.00, 200),
('Front Brake Pads Set', 'BrakeCo', 75.00, 50);

-- Example Work Order
INSERT INTO `WorkOrders` (`vehicle_id`, `mechanic_id`, `date_received`, `status`) VALUES
(1, 1, NOW(), 'In Progress');

-- Services for the Work Order
INSERT INTO `WorkOrder_Services` (`work_order_id`, `service_id`, `service_price`) VALUES
(1, 1, 50.00); -- Oil Change

-- Parts used in the Work Order
INSERT INTO `WorkOrder_Parts` (`work_order_id`, `part_id`, `quantity`, `unit_price`) VALUES
(1, 1, 1, 35.00), -- Synthetic Oil
(1, 2, 1, 10.00); -- Oil Filter