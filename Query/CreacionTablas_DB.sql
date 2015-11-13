CREATE DATABASE FondoAhorrosDB;
GO

USE FondoAhorrosDB;
GO

CREATE TABLE Deudores (
ID INT IDENTITY(1, 1) NOT NULL,
Cedula INT,
Nombre VARCHAR(100),
Activo BIT,
PRIMARY KEY (ID)
);
GO

CREATE TABLE TipoPrestamo (
ID INT IDENTITY(1, 1) NOT NULL,
Nombre VARCHAR(100),
Tasa FLOAT,
Plazo INT,
Activo BIT,
PRIMARY KEY (ID)
);
GO

CREATE TABLE Prestamos (
ID INT IDENTITY(1, 1) NOT NULL,
FK_Deudor INT,
FK_TipoPrestamo INT,
MontoOriginal FLOAT,
Cuota FLOAT,
PlazoRestante INT,
SaldoNoAplicado FLOAT,
SaldoAplicado FLOAT,
InteresAcumuladoMensual FLOAT,
DiaCorte INT,
DiaPago INT,
FechaInicio DATE,
Activo BIT,
PRIMARY KEY(ID),
FOREIGN KEY (FK_Deudor) REFERENCES Deudores (ID),
FOREIGN KEY (FK_TipoPrestamo) REFERENCES TipoPrestamo (ID)
);
GO

CREATE TABLE TipoMovimientoInteresDiario (
ID INT IDENTITY(1, 1) NOT NULL,
Nombre VARCHAR(100),
Activo BIT,
PRIMARY KEY (ID)
);
GO

CREATE TABLE MovimientoInteresDiario (
ID INT IDENTITY(1, 1) NOT NULL,
FK_TipoMovimientoInteresDiario INT,
FK_Prestamo INT,
Fecha DATE,
Monto FLOAT,
Activo BIT,
PostDate DATE,
PostIn VARCHAR(100),
PostBy VARCHAR(100),
PRIMARY KEY (ID),
FOREIGN KEY (FK_TipoMovimientoInteresDiario) REFERENCES TipoMovimientoInteresDiario (ID),
FOREIGN KEY (FK_Prestamo) REFERENCES Prestamos (ID)
);
GO

CREATE TABLE MovimientoSaldoNoAplicado (
ID INT IDENTITY(1, 1) NOT NULL,
FK_Prestamo INT,
Fecha DATE,
Amortizacion FLOAT,
Intereses FLOAT,
Activo BIT,
PostDate DATE,
PostIn VARCHAR(100),
PostBy VARCHAR(100),
PRIMARY KEY (ID),
FOREIGN KEY (FK_Prestamo) REFERENCES Prestamos (ID)
);
GO

CREATE TABLE Recibo (
ID INT IDENTITY(1,  1) NOT NULL,
FK_MovimientoSaldoNoAplicado INT,
Texto VARCHAR(500),
Estado BIT,
PostDate DATE,
PostIn VARCHAR(100),
PostBy VARCHAR(100),
PRIMARY KEY (ID),
FOREIGN KEY (FK_MovimientoSaldoNoAplicado) REFERENCES MovimientoSaldoNoAplicado (ID)
);

CREATE TABLE MovimientoSaldoAplicado (
ID INT IDENTITY(1, 1) NOT NULL,
FK_Prestamo INT,
Fecha DATE,
Amortizacion FLOAT,
Intereses FLOAT,
Activo BIT,
PostDate DATE,
PostIn VARCHAR(100),
PostBy VARCHAR(100),
PRIMARY KEY (ID),
FOREIGN KEY (FK_Prestamo) REFERENCES Prestamos (ID)
);
GO