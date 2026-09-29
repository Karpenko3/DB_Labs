DROP DATABASE IF EXISTS orbital_survey;
CREATE DATABASE orbital_survey CHARACTER SET utf8mb4;
USE orbital_survey;
 
CREATE TABLE survey_probe (
    probe_id       INT AUTO_INCREMENT PRIMARY KEY,
    probe_code     VARCHAR(12)  NOT NULL,
    probe_name     VARCHAR(40)  NOT NULL,
    target_body    VARCHAR(20)  NOT NULL,
    mission_status VARCHAR(15)  NOT NULL,
    power_output   DECIMAL(5,1) NOT NULL,
    launch_year    INT          NOT NULL,
    orbit_km       INT          NULL,
    last_contact   DATE         NULL
) ENGINE = InnoDB;
 
INSERT INTO survey_probe (probe_code, probe_name, target_body,
       mission_status, power_output, launch_year, orbit_km, last_contact)
VALUES ('PX-101-A', 'Aurora Scout', 'Mars', 'Active', 240.5, 2231, 420, '2247-03-14'),
       ('PX-102-B', 'Kraken Eye', 'Europa', 'Active', 180.0, 2233, 310, '2247-03-02'),
       ('SR-210-A', 'Pathfinder II', 'Titan', 'Standby', 95.5, 2236, NULL, '2246-11-27'),
       ('PX-103-C', 'Iron Sentinel', 'Mars', 'Lost', 310.0, 2228, 500, NULL),
       ('SR-211-B', 'Nova Probe', 'Ceres', 'Active', 145.0, 2240, 260, '2247-03-18'),
       ('TL-330-A', 'Silent Drift', 'Io', 'Lost', 88.0, 2229, NULL, NULL),
       ('PX-104-D', 'Helios Scout', 'Europa', 'Standby', 205.5, 2238, 350, '2247-01-09'),
       ('SR-212-C', 'Vega Relay', 'Titan', 'Active', 275.0, 2242, 610, '2247-03-21'),
       ('TL-331-B', 'Ghost Signal', 'Io', 'Retired', 60.0, 2225, NULL, '2244-07-30'),
       ('PX-105-E', 'Ember Sail', 'Ceres', 'Active', 190.5, 2244, 275, '2247-03-11'),
       ('SR-213-D', 'Titan Wake', 'Titan', 'Retired', 120.0, 2226, 480, '2243-05-16'),
       ('TL-332-C', 'Solar Anvil', 'Mars', 'Standby', 330.0, 2239, 540, '2247-02-25');

-- Витягує інформацію лише про ті зонди, статус місії яких точно дорівнює 'Active'.
SELECT probe_code, probe_name, target_body
FROM survey_probe
WHERE mission_status = 'Active';
 
-- Виводить зонди, у яких потужність реактора строго більша за 200.
SELECT probe_name, power_output
FROM survey_probe
WHERE power_output > 200;

-- Витягує зонди, які одночасно відповідають двом умовам: досліджують Марс та є активними.
SELECT probe_name, power_output
FROM survey_probe
WHERE target_body = 'Mars' AND mission_status = 'Active';
 
-- Виводить зонди, які є активними АБО в режимі очікування, і при цьому мають потужність реактора 200 або більше.
SELECT probe_name, mission_status, power_output
FROM survey_probe
WHERE (mission_status = 'Active' OR mission_status = 'Standby')
      AND power_output >= 200;
 
-- Виводить усі зонди, статус місії яких НЕ є втраченим ('Lost').
SELECT probe_name, mission_status
FROM survey_probe
WHERE NOT mission_status = 'Lost';

-- Знаходить усі зонди, код яких починається з 'PX-' (символ % замінює будь-яку кількість символів після).
SELECT probe_code, probe_name
FROM survey_probe
WHERE probe_code LIKE 'PX-%';
 
-- Шукає зонди, назва яких закінчується на слово 'Scout' (символ % на початку замінює весь попередній текст).
SELECT probe_code, probe_name
FROM survey_probe
WHERE probe_name LIKE '%Scout';
 
-- Відбирає зонди, цільовим тілом яких є одне зі списку: Європа, Титан або Церера (замінює кілька умов OR).
SELECT probe_name, target_body
FROM survey_probe
WHERE target_body IN ('Europa', 'Titan', 'Ceres');
 
-- Знаходить зонди, які були запущені в діапазоні між 2230 та 2238 роками (включно з обома межами).
SELECT probe_name, launch_year
FROM survey_probe
WHERE launch_year BETWEEN 2230 AND 2238;

-- Демонструє помилковий спосіб пошуку відсутніх значень (поверне порожній результат, оскільки з NULL не можна використовувати знак =).
SELECT probe_name FROM survey_probe WHERE orbit_km = 12;
 
-- Правильний спосіб знаходження відсутніх значень: виводить зонди, з якими жодного разу не було зв'язку (дата NULL).
SELECT probe_name, target_body
FROM survey_probe
WHERE last_contact IS NULL;
 
-- Виводить лише ті зонди, для яких відома висота орбіти (тобто значення комірки НЕ є порожнім).
SELECT probe_name, orbit_km
FROM survey_probe
WHERE orbit_km IS NOT NULL;
 
-- Тимчасово замінює відсутні значення (NULL) на 0 для орбіти та на фіктивну дату '2200-01-01' для останнього контакту під час виведення таблиці на екран.
SELECT probe_name,
       IFNULL(orbit_km, 0) AS orbit_km,
       COALESCE(last_contact, '2200-01-01') AS last_contact
FROM survey_probe;