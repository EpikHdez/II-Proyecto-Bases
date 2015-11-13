USE FondoAhorrosDB;
GO

CREATE PROCEDURE FASP_ActualizarDeudores
	@pID INT = 0,
	@pNombre VARCHAR(100) = NULL

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
	@pDiaCorte INT = 0,
	@pActivo BIT = 1
	
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
			SaldoAplicado = @pSaldoAplicado,
			InteresAcumuladoMensual = @pInteresAcumulado,
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

CREATE PROCEDURE FASP_ActualizarMovimientoSaldoNoAplicado
	@pID INT = 0,
	@pFecha DATE = null,
	@pAmortizacion INT = 0,
	@pInteres INT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE dbo.MovimientoSaldoNoAplicado
			SET Fecha = @pFecha,
			Amortizacion = @pAmortizacion,
			Intereses = @pInteres
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

CREATE PROCEDURE FASP_ActualizarMovimientoSaldoAplicado
	@pID INT = 0,
	@pFecha DATE,
	@pAmortizacion INT = 0,
	@pInteres INT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE dbo.MovimientoSaldoAplicado
			SET Fecha = @pFecha,
			Amortizacion = @pAmortizacion,
			Intereses = @pInteres
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

CREATE PROCEDURE FASP_ActualizarTipoMovimientoInteresDiario
	@pID INT = 0,
	@pNombre VARCHAR(100) = null
AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE dbo.TipoMovimientoInteresDiario
			SET Nombre = @pNombre
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

CREATE PROCEDURE FASP_ActualizarTipoPrestamo
	@pID INT = 0,
	@pNombre VARCHAR(100) = 0,
	@pTasa INT = 0,
	@pPlazo INT = 0,
	@pPeriodo INT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE dbo.TipoPrestamo
			SET Nombre = @pNombre,
			Tasa = @pTasa,
			Plazo = @pPlazo
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

