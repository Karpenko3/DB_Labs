DROP DATABASE IF EXISTS supply_run;
CREATE DATABASE supply_run CHARACTER SET utf8mb4;
USE supply_run;
 
CREATE TABLE cargo_item (
    item_id     INT AUTO_INCREMENT PRIMARY KEY,
    item_code   VARCHAR(10)  NOT NULL,
    item_name   VARCHAR(40)  NOT NULL,
    destination VARCHAR(20)  NOT NULL,
    mass_kg     DECIMAL(7,2) NOT NULL,
    priority    VARCHAR(10)  NOT NULL DEFAULT 'Normal',
    status      VARCHAR(12)  NOT NULL DEFAULT 'Loaded'
) ENGINE = InnoDB;
 
SELECT * FROM cargo_item;


-- 1.1 Додавання одного рядка з усіма вказаними стовпцями
INSERT INTO cargo_item (item_code, item_name, destination, mass_kg, priority, status)
VALUES ('CR-001', 'Oxygen tanks', 'Luna Base', 240.00, 'High', 'Loaded');
 
-- 1.2 Додавання трьох рядків одним оператором
INSERT INTO cargo_item (item_code, item_name, destination, mass_kg, priority)
VALUES ('CR-002', 'Water tanks', 'Mars Base', 500.00, 'High'),
       ('CR-003', 'Hull panels', 'Luna Base', 180.50, 'Normal'),
       ('CR-004', 'Soil samples', 'Orbital Lab', 45.25, 'Low');
 
-- 1.3 Пропущені стовпці автоматично отримують значення DEFAULT
INSERT INTO cargo_item (item_code, item_name, destination, mass_kg)
VALUES ('CR-005', 'Medical kit', 'Mars Base', 32.75),
       ('CR-006', 'Antenna mast', 'Orbital Lab', 120.00);

-- Виведення таблиці для перевірки змін
SELECT * FROM cargo_item;


-- 2.1 Новий стан для однієї одиниці вантажу (звуження дії через WHERE)
UPDATE cargo_item
SET status = 'Sealed'
WHERE item_code = 'CR-004';
 
-- 2.2 Зміна двох стовпців одночасно для групи рядків
UPDATE cargo_item
SET priority = 'High', status = 'Sealed'
WHERE destination = 'Mars Base';
 
-- 2.3 Обчислення значення з нього самого (додавання 15 кг до поточної маси)
UPDATE cargo_item
SET mass_kg = mass_kg + 15.00
WHERE item_code = 'CR-003';

-- Виведення таблиці для перевірки змін
SELECT * FROM cargo_item;



-- 3.1 Вилучення однієї одиниці за її точним кодом
DELETE FROM cargo_item
WHERE item_code = 'CR-006';
 
-- 3.2 Вилучення групи рядків за комбінованою умовою
DELETE FROM cargo_item
WHERE destination = 'Orbital Lab' AND mass_kg < 100;

-- Виведення таблиці для перевірки перших вилучень
SELECT * FROM cargo_item;


-- 3.3 Оператор без WHERE (повністю спорожняє таблицю, але зберігає її структуру)
DELETE FROM cargo_item;

-- Виведення порожньої таблиці
SELECT * FROM cargo_item;