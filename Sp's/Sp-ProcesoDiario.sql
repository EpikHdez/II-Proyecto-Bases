USE FondoAhorrosDB;
GO

CREATE PROCEDURE FASP_CalcularInteresDiario

AS
BEGIN
	DECLARE @InteresDiario INT = 0;
	DECLARE @FechaProceso DATE = GETDATE();

	INSERT MovimientoInteresDiario()