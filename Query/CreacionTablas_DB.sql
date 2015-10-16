CREATE DATABASE FondoAhorrosDB;
GO

USE FondoAhorrosDB;
GO

CREATE TABLE Deudores(
ID INT IDENTITY(1, 1) NOT NULL,
Nombre VARCHAR(100),
PRIMARY KEY(ID)
);
GO

CREATE TABLE MovimientoInteresDiario(
ID INT IDENTITY(1, 1) NOT NULL,
Fecha DATE,
Monto INT,
PRIMARY KEY(ID)
);
GO

CREATE TABLE MovimientosSaldoAplicado(
ID INT IDENTITY(1, 1) NOT NULL,
Fecha DATE,
Amortizacion INT,
Intereses INT,
PRIMARY KEY(ID),
);
GO

CREATE TABLE MovimientoSaldoNoAplicado(
ID INT IDENTITY(1, 1) NOT NULL,
Fecha DATE,
Amortizacion INT,
Intereses INT,
PRIMARY KEY(ID),
);
GO

CREATE TABLE Prestamos(
ID INT IDENTITY(1, 1) NOT NULL,
MontoOriginal INT,
Cuota INT,
PlazoRestante INT,
SaldoNoAplicado INT,
SaldoAplicado INT,
InteresAcumuladoMensual INT,
DiaCorte INT,
PRIMARY KEY(ID),
);
GO

CREATE TABLE TipoMovimientoInteresDiario(
ID INT IDENTITY(1, 1) NOT NULL,
Nombre VARCHAR(100),
PRIMARY KEY(ID)
);
GO

CREATE TABLE TipoPrestamo(
ID INT IDENTITY(1, 1) NOT NULL,
Nombre VARCHAR(100),
Tasa INT,
Plazo INT,
Periodo INT,
PRIMARY KEY(ID)
);
