# 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
CREATE TABLE employees (
id BIGINT auto_increment PRIMARY KEY,
firstName VARCHAR (25),
lastName VARCHAR (50),
salary DECIMAL (7,2),
birthDate DATE,
position VARCHAR (50));

# 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO employees (firstName, lastName, salary, birthDate, position) 
VALUES 
('Bogdan', 'Kowlaski', 5000.00, '2000-01-01', 'junior-rookie'),
('Janina', 'Kowalska', 7000.00, '1995-11-25', 'rookie'),
('Kazik', 'Nowak', 9000.00, '1990-09-20', 'senior-rookie'),
('Baśka', 'Nowak', 11000.00, '1985-06-12', 'hardworker'),
('Janusz', 'Szef', 3000.00, '1980-04-08', 'boss'),
('Grażyna', 'Kociara', 15000.00, '1975-03-02', 'real-boss');

# 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM employees ORDER BY lastName;

# 4. Pobiera pracowników na wybranym stanowisku // dwie opcje
SELECT firstName, lastName FROM employees WHERE position LIKE '%boss';
SELECT firstName, lastName, date FROM employees WHERE position = 'rookie';

# 5. Pobiera pracowników, którzy mają co najmniej 30 lat // dwie opcje
SELECT firstName, lastName FROM employees WHERE DATEDIFF(NOW(), birthDate)>30*365;
SELECT firstName, lastName, birthDate FROM employees WHERE EXTRACT(YEAR from birthDate)<1989;

# 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10% // TRZEBA UWAŻAĆ :)
SET SQL_SAFE_UPDATES=0;
UPDATE employees SET salary = (salary*1.1) WHERE position = 'rookie';
SET SQL_SAFE_UPDATES=1;

# 7. Usuwa najmłodszego pracownika
SELECT id FROM employees WHERE birthDate= (SELECT MAX(birthDate) FROM employees);
DELETE FROM employees WHERE id = 1 /* wpisać nr z powyższej komendy*/;
-- To nie działa -- DELETE FROM employees WHERE id = (SELECT id FROM employees WHERE birthDate= (SELECT MAX(birthDate) FROM employees));

# 8. Usuwa tabelę pracownik
DROP TABLE employees;
DROP TABLE adress;
DROP TABLE positions;
DROP TABLE worker;

# 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE positions (
id SMALLINT  PRIMARY KEY,
name VARCHAR (25),
description VARCHAR (50),
salary DECIMAL (7,2));

#10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE adress (
id BIGINT auto_increment PRIMARY KEY,
streetAndNumber VARCHAR (50),
code VARCHAR (5) ,
city VARCHAR (30));

#11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE worker (
id BIGINT auto_increment PRIMARY KEY,
firstName VARCHAR (25),
lastName VARCHAR (50),
id_positions SMALLINT,
id_adress BIGINT);

#12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO positions (id, name, description, salary) 
VALUES 
(1, 'rookie', 'job stating position in company', 5000.00),
(2, 'junior', 'working all the days and nights', 6000.00),
(3, 'senior', 'only few days tu retire', 9000.00),
(4, 'boss', 'sth like god', 11000.00);

INSERT INTO adress (streetAndNumber, code, city) 
VALUES 
('Biała 1', '50200', 'Wrocław'),
('Czarna 2', '50200',  'Wrocałw'),
('Szara 3', '49300', 'Brzeg'),
('Zielona 4', '12541', 'Miasto');

INSERT INTO worker (firstName, lastName, id_positions, id_adress) 
VALUES 
('Bogdan', 'Kowlaski', 1, 1),
('Janina', 'Kowalska', 1, 1),
('Kazik', 'Nowak', 2, '2'),
('Baśka', 'Nowak', 3, '3'),
('Janusz', 'Szef', 3, '4'),
('Grażyna', 'Kociara', 4, '4');

#13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT * FROM worker w JOIN adress a JOIN positions p ON w.id_positions=p.id AND w.id_adress=a.id;

#14. Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(salary) FROM worker w JOIN positions p ON w.id_positions=p.id;

#15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)
SELECT * FROM worker w JOIN adress a ON w.id_adress=a.id WHERE code = '50200';

# Rozwiązanie umieść na githubie w postaci pliku .sql zawierającego wszystkie zapytania.

