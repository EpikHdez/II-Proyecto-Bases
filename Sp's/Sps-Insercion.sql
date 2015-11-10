USE FondoAhorrosDB;

CREATE PROCEDURE FASP_InsertarDeudores
	@pCedula INT = 0,
	@pNombre VARCHAR(100) = NULL

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.Deudores(Cedula, Nombre,Activo)
			VALUES (@pCedula, @pNombre, 1)
		COMMIT TRANSACTION;

		RETURN SCOPE_IDENTITY();

	END TRY
	BEGIN CATCH	
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_InsertarPrestamo
	@pDeudor INT,
	@pTipoPrestamo INT,
	@pMovimientoInteresDiario INT,
	@pMovimientoSaldoNoAplicado INT,
	@pMovimientoSaldoAplicado INT,
	@pMontoOriginal INT = 0,
	@pCuota INT = 0,
	@pPlazoRestante INT = 0,
	@pDiaCorte DATE = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.Prestamos(FK_Deudor, FK_TipoPrestamo,FK_MovimientoInteresDiario, FK_MovimientoSaldoNoAplicado, 
			FK_MovimientoSaldoAplicado,MontoOriginal, Cuota, PlazoRestante, SaldoNoAplicado, SaldoAplicado, InteresAcumuladoMensual, 
			DiaCorte, Activo)
			VALUES (@pDeudor, @pTipoPrestamo, @pMovimientoInteresDiario, @pMovimientoSaldoNoAplicado, @pMovimientoSaldoAplicado, @pMontoOriginal,
			@pCuota, @pPlazoRestante, 0, 0, 0, @pDiaCorte, 1)
		COMMIT TRANSACTION;

		RETURN SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_InsertarMovimientoInteresDiario
	@pTipoMovimientoInteresDiario INT,
	@pFecha DATE = NULL,
	@pMonto INT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.MovimientoInteresDiario(FK_TipoMovimientoInteresDiario, Fecha, Monto, Activo)
			VALUES (@pTipoMovimientoInteresDiario,@pFecha, @pMonto, 1)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_InsertarMovimientoSaldoNoAplicado
	@pFecha DATE = NULL,
	@pAmortizacion INT = 0,
	@pIntereses INT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.MovimientoSaldoNoAplicado(Fecha, Amortizacion, Intereses, Activo)
			VALUES (@pFecha, @pAmortizacion, @pIntereses, 1)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_InsertarMovimientoSaldoAplicado
	@pFecha DATE = NULL,
	@pAmortizacion INT = 0,
	@pInteres INT = 0,

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.MovimientoSaldoAplicado(Fecha, Amortizacion, Interes)
			VALUES(@pFecha, @pAmortizacion, @pIntereses)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_TipoMovimientoInteresDiario
	@pNombre VARCHAR(100),

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.TipoMovimientoInteresDiario(Nombre)
			VALUES(@pNombre)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_TipoPrestamo
	@pNombre VARCHAR(100) = NULL,
	@pTasa INT = 0,
	@pPlazo INT = 0,
	@pPeriodo INT = 0;

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.TipoPrestamo(Nombre, Tasa, Plazo, Periodo)
			VALUES (@pNombre, @pTasa, @pPlazo, @pPeriodo)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK

		RETURN @@ERROR * -1;
	END CATCH
END
GO