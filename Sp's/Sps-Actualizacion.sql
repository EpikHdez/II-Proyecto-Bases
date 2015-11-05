USE FondoAhorrosDB;

CREATE PROCEDURE FASP_ActualizarDeudores
	@pID INT = 0,
	@pNombre VARCHAR(100) = NULL,

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE dbo.Deudores
			SET Nombre = @pNombre
			WHERE ID = @pID;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * - 1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_ActualizarPrestamos
	@pID INT = 0,
	@pMontoOriginal INT = 0,
	@pCuota INT = 0,
	@pPlazoRestante INT = 0,
	@pSaldoNoAplicado INT = 0,
	@pSaldoAplicado INT = 0,
	@pInteresAcumulado INT = 0,
	@pDiaCorte INT = 0
	
AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE dbo.Prestamos
			SET MontoOriginal = @pMontoOriginal,
			Cuota = @pCuota,
			PlazoRestante = @pPlazoRestante,
			SaldoNoAplicado = @pSaldoNoAplicado,
			SaldoAplicado = @pSaldoAplicado
			InteresAcumuladoMensual = @pInteresAcumuladoMensual,
			DiaCorte = @pDiaCorte
			WHERE ID = @pID;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_ActualizarMovimientoInteresDiario
	@pID INT = 0,
	@pFecha DATE = null,
	@pMonto INT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE dbo.MovimientoInteresDiario
			SET Fecha = @pFecha,
			Monto = @pMonto
			WHERE ID = @pID;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK

		RETURN @@ERROR * -1;
	END CATCH
END
GO

