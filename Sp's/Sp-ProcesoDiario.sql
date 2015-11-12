USE FondoAhorrosDB;
GO

CREATE PROCEDURE FASP_CalcularInteresDiario

AS
BEGIN
	DECLARE @InteresDiario INT = 0;
	DECLARE @FechaProceso DATE = GETDATE();

	INSERT MovimientoInteresDiario(FK_TipoMovimientoIntereDiario, FK_Prestamo, Fecha, Monto, Activo)
	SELECT PR.FK_TipoPrestamo, PR.ID, @FechaProceso, dbo.CalcularIntereses(PR.SaldoNoAplicado, PR.FK_TipoPrestamo.Tasa), 1
	FROM Prestamos PR
	WHERE PR.SaldoNoAplicado > 0 AND @FechaProceso BETWEEN 

	UPDATE Prestamo
		SET InteresAcumuladoMensual = InteresAcumuladoMensual + dbo.FAFN_CalcularInteres(PR.SaldoNoAplicado, PR.FK_TipoPrestamo.Tasa)
	FROM Prestamos PR
	WHERE PR.SaldoNoAplicado > 0


END
GO