/* 
Pergunta 1: Resumo completo da ordem de serviço nº 1.
*/

SELECT
    wo.work_order_id,
    wo.date_received,
    wo.status,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    v.make,
    v.model,
    v.license_plate,
    m.first_name AS mechanic_first_name
FROM
    WorkOrders wo
JOIN
    Vehicles v ON wo.vehicle_id = v.vehicle_id
JOIN
    Customers c ON v.customer_id = c.customer_id
JOIN
    Mechanics m ON wo.mechanic_id = m.mechanic_id
WHERE
    wo.work_order_id = 1;

/* 
Pergunta 2: Qual é o custo total de cada ordem de serviço?
*/

SELECT
    wo.work_order_id,
    wo.status,
    (COALESCE(SUM(DISTINCT s.service_price), 0) + COALESCE(SUM(p.quantity * p.unit_price), 0)) AS total_order_cost
FROM
    WorkOrders wo
LEFT JOIN
    WorkOrder_Services s ON wo.work_order_id = s.work_order_id
LEFT JOIN
    WorkOrder_Parts p ON wo.work_order_id = p.work_order_id
GROUP BY
    wo.work_order_id, wo.status
ORDER BY
    wo.status DESC, total_order_cost DESC;

/* 
Pergunta 3: Quais mecânicos completaram mais de 2 ordens de serviço? Quero listá-los do mais produtivo para o menos produtivo.
*/

SELECT
    m.first_name,
    m.last_name,
    COUNT(wo.work_order_id) AS completed_jobs_count
FROM
    Mechanics m
JOIN
    WorkOrders wo ON m.mechanic_id = wo.mechanic_id
WHERE
    wo.status = 'Completed'
GROUP BY
    m.mechanic_id, m.first_name, m.last_name
HAVING
    COUNT(wo.work_order_id) >= 1
ORDER BY
    completed_jobs_count DESC;


/* 
Pergunta 4: Quais são as nossas 5 peças mais utilizadas em reparos?
*/

SELECT
    p.part_name,
    p.manufacturer,
    SUM(wop.quantity) AS total_quantity_sold,
    SUM(wop.quantity * wop.unit_price) AS total_revenue
FROM
    Parts p
JOIN
    WorkOrder_Parts wop ON p.part_id = wop.part_id
GROUP BY
    p.part_id, p.part_name, p.manufacturer
ORDER BY
    total_revenue DESC
LIMIT 5;

/* 
Pergunta 5: Quais ordens de serviço estão com status 'In Progress' há mais de 7 dias?
*/

SELECT
    work_order_id,
    vehicle_id,
    mechanic_id,
    date_received,
    DATEDIFF(NOW(), date_received) AS days_open
FROM
    WorkOrders
WHERE
    status = 'In Progress'
    AND date_received < DATE_SUB(NOW(), INTERVAL 7 DAY)
ORDER BY
    date_received ASC;