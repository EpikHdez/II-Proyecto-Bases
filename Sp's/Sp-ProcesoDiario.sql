USE FondoAhorrosDB

CREATE PROCEDURE FASP_ProcesoDiario
AS
BEGIN
	DECLARE @InteresDiario INT = 0;
	DECLARE @FechaProceso DATE = GETDATE();
	