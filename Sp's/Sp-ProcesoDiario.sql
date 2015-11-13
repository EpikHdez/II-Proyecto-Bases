USE FondoAhorrosDB;
GO

CREATE PROCEDURE FASP_CalcularInteresDiario

AS
BEGIN
	DECLARE @InteresDiario INT = 0;
	DECLARE @FechaProceso DATE = CONVERT(DATE, GETDATE());

	INSERT MovimientoInteresDiario(FK_TipoMovimientoInteresDiario, FK_Prestamo, Fecha, Monto, Activo)
	SELECT 1, PR.ID, @FechaProceso, dbo.CalcularIntereses(PR.SaldoNoAplicado, TP.tasa), 1
	FROM Prestamos PR INNER JOIN dbo.TipoPrestamo TP
	ON PR.FK_TipoPrestamo = TP.ID
	WHERE PR.SaldoNoAplicado > 0 AND (@FechaProceso BETWEEN PR.FechaInicio AND DATEADD(YEAR, TP.Plazo, PR.FechaInicio));

	UPDATE Prestamo
	SET InteresAcumuladoMensual = InteresAcumuladoMensual + dbo.FAFN_CalcularInteres(PR.SaldoNoAplicado, TP.Plazo)
	FROM Prestamos PR INNER JOIN dbo.TipoPrestamo TP
	ON PR.FK_TipoPrestamo = TP.ID
	WHERE PR.SaldoNoAplicado > 0


END
GO