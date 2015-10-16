USE FondoAhorrosDB;

CREATE PROCEDURE FASP_InsertarPrestamo
	@pMontoOriginal INT = 0,
	@pCuota INT = 0,
	@pPlazoRestante INT = 0,
	@pDiaCorte = 0,

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.Prestamos(MontoOriginal, Cuota, PlazoRestante, SaldoNoAplicado, SaldoAplicado, InteresAcumulado, DiaCorte)
			VALUES (@pMontoOriginal, @pCuota, @pPlazoRestante, 0, 0, 0 @pDiaCorte)
		COMMIT TRANSACTION;

		RETURN SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@error * -1;
	END CATCH
END
GO

