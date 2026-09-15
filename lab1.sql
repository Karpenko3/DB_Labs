
DROP DATABASE IF EXISTS deep_space;
CREATE DATABASE deep_space CHARACTER SET utf8mb4;
USE deep_space;
 
CREATE TABLE starship (
    ship_id      INT AUTO_INCREMENT PRIMARY KEY,
    ship_name    VARCHAR(40)  NOT NULL,
    ship_class   VARCHAR(20)  NOT NULL,
    home_sector  VARCHAR(20)  NOT NULL,
    crew_size    SMALLINT UNSIGNED NOT NULL,
    launch_year  SMALLINT     NOT NULL,
    fuel_reserve DECIMAL(5,2) NOT NULL
) ENGINE = InnoDB;
 
INSERT INTO starship (ship_name, ship_class, home_sector,
                      crew_size, launch_year, fuel_reserve)
VALUES ('Aurora Borealis', 'Explorer',  'Orion Arm',   120, 2231, 87.50),
       ('Kraken',          'Freighter', 'Cygnus Rift',  45, 2228, 64.20),
       ('Pathfinder',      'Scout',     'Orion Arm',    12, 2240, 95.10),
       ('Iron Comet',      'Freighter', 'Perseus Gap',  50, 2225, 41.75),
       ('Nova Lance',      'Cruiser',   'Cygnus Rift', 210, 2238, 72.40),
       ('Silent Drift',    'Scout',     'Perseus Gap',  10, 2242, 88.00),
       ('Helios Dawn',     'Explorer',  'Orion Arm',   135, 2236, 55.30),
       ('Vega Runner',     'Freighter', 'Orion Arm',    48, 2233, 30.90),
       ('Titan Wake',      'Cruiser',   'Perseus Gap', 198, 2229, 67.85),
       ('Ember Sail',      'Explorer',  'Cygnus Rift', 110, 2244, 99.00),
       ('Ghost Signal',    'Scout',     'Cygnus Rift',  14, 2241, 76.60),
       ('Solar Anvil',     'Cruiser',   'Orion Arm',   205, 2226, 22.15);


--Витягує абсолютно всі дані (всі стовпці та всі рядки) з таблиці starship (Повний реєстр).
SELECT * FROM starship;
 
-- Витягує лише три стовпці і тимчасово змінює їхні заголовки під час виведення на ship, class та crew за допомогою оператора AS.
SELECT ship_name   AS ship,
       ship_class  AS class,
       crew_size   AS crew
FROM starship;

-- Виводить список унікальних класів кораблів, прибираючи всі повторювані значення.
SELECT DISTINCT ship_class FROM starship;
 
-- Виводить унікальні комбінації (пари) класу корабля та його сектору приписки.
SELECT DISTINCT ship_class, home_sector
FROM starship;

-- Сортує список кораблів за розміром екіпажу від найбільшого до найменшого (DESC — за спаданням).
SELECT ship_name, crew_size
FROM starship
ORDER BY crew_size DESC;
 
-- Сортує кораблі спочатку за класом (за алфавітом), а всередині однакових класів — за роком запуску від найновішого до найстарішого (DESC).
SELECT ship_name, ship_class, launch_year
FROM starship
ORDER BY ship_class ASC, launch_year DESC;

-- Виводить 3 кораблі з найбільшим запасом палива (сортує за спаданням палива і залишає лише перші 3 результати завдяки LIMIT).
SELECT ship_name, fuel_reserve
FROM starship
ORDER BY fuel_reserve DESC
LIMIT 3;
 
-- Пропускає перші 3 кораблі (OFFSET 3) з відсортованого за паливом списку і виводить наступні 3 (тобто рядки 4, 5 та 6).
SELECT ship_name, fuel_reserve
FROM starship
ORDER BY fuel_reserve DESC
LIMIT 3 OFFSET 3;
