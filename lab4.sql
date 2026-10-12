DROP DATABASE IF EXISTS station_telemetry;
CREATE DATABASE station_telemetry CHARACTER SET utf8mb4;
USE station_telemetry;
 
CREATE TABLE sensor_log (
    reading_id   INT AUTO_INCREMENT PRIMARY KEY,
    sensor_code  VARCHAR(10)  NOT NULL,
    module       VARCHAR(20)  NOT NULL,
    temperature  DECIMAL(5,2) NOT NULL,
    pressure_kpa DECIMAL(6,2) NOT NULL,
    power_draw   DECIMAL(6,2) NULL,
    reading_date DATE         NOT NULL
) ENGINE = InnoDB;
 
INSERT INTO sensor_log (sensor_code, module, temperature,
       pressure_kpa, power_draw, reading_date)
VALUES ('S-01', 'Habitat', 21.40, 101.30, 3.75, '2247-03-01'),
       ('S-02', 'Habitat', 22.10, 101.10, 4.20, '2247-03-01'),
       ('S-03', 'Laboratory', 19.85, 100.90, NULL, '2247-03-02'),
       ('S-04', 'Laboratory', 18.60, 99.75, 5.40, '2247-03-02'),
       ('S-05', 'Airlock', 4.20, 98.40, 2.15, '2247-03-03'),
       ('S-06', 'Airlock', -3.55, 97.80, NULL, '2247-03-03'),
       ('S-07', 'Reactor', 46.90, 103.60, 12.80, '2247-03-04'),
       ('S-08', 'Reactor', 48.25, 104.10, 13.45, '2247-03-04'),
       ('S-09', 'Habitat', 20.75, 100.55, 3.90, '2247-03-05'),
       ('S-10', 'Laboratory', 17.30, 99.20, 4.85, '2247-03-05'),
       ('S-11', 'Airlock', -1.10, 98.05, NULL, '2247-03-06'),
       ('S-12', 'Reactor', 45.60, 102.95, 12.10, '2247-03-06');

SELECT * FROM sensor_log;


-- 1.1 Знаходить найнижчу температуру серед усіх записів
SELECT MIN(temperature) AS lowest_temperature FROM sensor_log;
 
-- 1.2 Знаходить найранішу дату (хронологічний мінімум)
SELECT MIN(reading_date) AS first_reading FROM sensor_log;

-- 2.1 Знаходить найвищий тиск
SELECT MAX(pressure_kpa) AS highest_pressure FROM sensor_log;
 
-- 2.2 Демонструє роботу кількох функцій одразу та обчислення різниці (розмаху) між ними
SELECT MIN(temperature) AS lowest, MAX(temperature) AS highest,
       MAX(temperature) - MIN(temperature) AS span
FROM sensor_log;


-- 3.1 Рахує загальну кількість записів (рядків) у журналі
SELECT COUNT(*) AS readings FROM sensor_log;
 
-- 3.2 Показує загальну кількість, кількість заповнених значень power_draw та обчислює кількість пропусків
SELECT COUNT(*) AS readings,
       COUNT(power_draw) AS measured,
       COUNT(*) - COUNT(power_draw) AS gaps
FROM sensor_log;


-- 4.1 Рахує середню температуру по всій станції
SELECT AVG(temperature) AS mean_temperature FROM sensor_log;
 
-- 4.2 Рахує середню споживану потужність (лише для тих датчиків, де вона вказана)
SELECT AVG(power_draw) AS mean_power FROM sensor_log;

-- 5.1 Рахує сумарну споживану потужність
SELECT SUM(power_draw) AS total_power FROM sensor_log;
 
-- 5.2 Демонструє математичний зв'язок: Сума, кількість виміряних значень і їхнє Середнє
SELECT SUM(power_draw) AS total_power,
       COUNT(power_draw) AS measured,
       AVG(power_draw) AS mean_power
FROM sensor_log;