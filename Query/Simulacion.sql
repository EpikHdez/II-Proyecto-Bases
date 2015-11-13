USE FondoAhorrosDB;
GO

CREATE PROCEDURE FASP_Simulacion
AS
BEGIN

EXEC CCSP_CargarDatos;
DECLARE @FechaInicial DATE;
DECLARE @FechaFinal DATE;

SELECT @FechaInicial = MIN(P.FechaInicio)
FROM Prestamos P

SET @FechaFinal = DATEADD(DAY, @Dias, @FechaInicial)
WHILE @FechaInicial < @FechaFinal
BEGIN
EXEC FASP_CalcularInteresDiario(@FechaFinal)
SET @FechaInicial = DATEADD(DAY, 1, @FechaInicial)
END
GO

