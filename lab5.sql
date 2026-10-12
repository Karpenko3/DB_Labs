DROP DATABASE IF EXISTS mining_flotilla;
CREATE DATABASE mining_flotilla CHARACTER SET utf8mb4;
USE mining_flotilla;
 
CREATE TABLE ore_delivery (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    ship_name   VARCHAR(30)  NOT NULL,
    asteroid    VARCHAR(20)  NOT NULL,
    ore_type    VARCHAR(15)  NOT NULL,
    mass_t      DECIMAL(6,2) NOT NULL,
    purity      DECIMAL(5,2) NOT NULL
) ENGINE = InnoDB;
 
INSERT INTO ore_delivery (ship_name, asteroid, ore_type, mass_t, purity)
VALUES ('Aurora', 'Vesta', 'Iron', 120.50, 62.30),
       ('Kraken', 'Vesta', 'Iron', 98.75, 58.40),
       ('Nomad', 'Pallas', 'Iron', 145.20, 65.10),
       ('Aurora', 'Juno', 'Iron', 88.40, 55.75),
       ('Vega', 'Pallas', 'Iron', 132.60, 61.20),
       ('Kraken', 'Vesta', 'Nickel', 76.30, 48.90),
       ('Nomad', 'Juno', 'Nickel', 92.15, 51.40),
       ('Vega', 'Pallas', 'Nickel', 64.80, 46.25),
       ('Aurora', 'Vesta', 'Nickel', 81.05, 49.60),
       ('Nomad', 'Juno', 'Platinum', 12.40, 88.70),
       ('Vega', 'Vesta', 'Platinum', 9.85, 91.20),
       ('Kraken', 'Pallas', 'Platinum', 15.60, 85.35),
       ('Aurora', 'Juno', 'Water ice', 210.00, 97.50),
       ('Vega', 'Juno', 'Water ice', 185.30, 96.80);

SELECT * FROM ore_delivery;



-- 1.1 Рахуємо кількість поставок для кожного типу руди
SELECT ore_type, COUNT(*) AS deliveries
FROM ore_delivery
GROUP BY ore_type;
 
-- 1.2 Одразу кілька статистичних зведень (кількість, сума, середнє, максимум) для кожної групи руди
SELECT ore_type,
       COUNT(*) AS deliveries,
       SUM(mass_t) AS total_mass,
       AVG(purity) AS mean_purity,
       MAX(mass_t) AS largest_load
FROM ore_delivery
GROUP BY ore_type;
 
-- 1.3 Групування за двома стовпцями (комбінація Астероїд + Тип руди)
SELECT asteroid, ore_type, COUNT(*) AS deliveries
FROM ore_delivery
GROUP BY asteroid, ore_type;



-- 2.1 Залишаємо лише ті типи руди, які доставляли 3 або більше разів
SELECT ore_type, COUNT(*) AS deliveries
FROM ore_delivery
GROUP BY ore_type
HAVING COUNT(*) >= 3;
 
-- 2.2 Відбираємо групи, де сумарна маса вантажу перевищує 300 тонн
SELECT ore_type, SUM(mass_t) AS total_mass
FROM ore_delivery
GROUP BY ore_type
HAVING SUM(mass_t) > 300;
 
-- 2.3 Комбінація: спочатку WHERE відкидає брудну руду (<50%), потім утворюються групи, а HAVING відкидає малі групи (<2 поставок)
SELECT ore_type, COUNT(*) AS deliveries, AVG(purity) AS mean_purity
FROM ore_delivery
WHERE purity >= 50
GROUP BY ore_type
HAVING COUNT(*) >= 2;



