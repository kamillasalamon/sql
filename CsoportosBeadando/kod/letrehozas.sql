----1. az adatbázis létrehozása:
CREATE DATABASE autosiskola;
GO
0
----2. a táblák létrehozása:
USE autosiskola;
GO

CREATE TABLE tanulo (
    tanulo_id INT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    szul_datum DATE,
    cim VARCHAR(200),
    telefonszam VARCHAR(20) NOT NULL
);

CREATE TABLE oktatok (
    oktato_id INT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    telefonszam VARCHAR(20)
);

CREATE TABLE jarmu (
    jarmu_id INT PRIMARY KEY,
    oktato_fk INT NOT NULL,
    rendszam VARCHAR(20) NOT NULL,
    marka VARCHAR(50),
    tipus VARCHAR(50),
    FOREIGN KEY (oktato_fk) REFERENCES oktatok(oktato_id)
);

CREATE TABLE tanfolyam (
    tanfolyam_id INT PRIMARY KEY,
    tanulo_fk INT NOT NULL,
    oktato_fk INT NOT NULL,
    tipus VARCHAR(50),
    kezdo_datum DATE,
    FOREIGN KEY (tanulo_fk) REFERENCES tanulo(tanulo_id),
    FOREIGN KEY (oktato_fk) REFERENCES oktatok(oktato_id)
);

CREATE TABLE vizsga (
    vizsga_id INT PRIMARY KEY,
    tanfolyam_fk INT NOT NULL,
    tipus VARCHAR(50) NOT NULL,
    datum DATE,
    teljesitette BIT,
    FOREIGN KEY (tanfolyam_fk) REFERENCES tanfolyam(tanfolyam_id)
);
