USE FondoAhorrosDB;
GO

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
	@pMontoOriginal FLOAT = 0,
	@pCuota FLOAT = 0,
	@pPlazoRestante INT = 0,
	@pDiaCorte INT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.Prestamos(FK_Deudor, FK_TipoPrestamo, MontoOriginal, Cuota, PlazoRestante, SaldoNoAplicado, SaldoAplicado, InteresAcumuladoMensual, 
			DiaCorte, Activo)
			VALUES (@pDeudor, @pTipoPrestamo, @pMontoOriginal,
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
	@pPrestamo INT, 
	@pFecha DATE = NULL,
	@pMonto FLOAT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.MovimientoInteresDiario(FK_TipoMovimientoInteresDiario, FK_Prestamo,Fecha, Monto, Activo)
			VALUES (@pTipoMovimientoInteresDiario, @pPrestamo,@pFecha, @pMonto, 1)
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
	@pPrestamo INT,
	@pFecha DATE = NULL,
	@pAmortizacion FLOAT = 0,
	@pIntereses FLOAT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.MovimientoSaldoNoAplicado(FK_Prestamo,Fecha, Amortizacion, Intereses, Activo)
			VALUES (@pPrestamo, @pFecha, @pAmortizacion, @pIntereses, 1)
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
	@pPrestamo INT,
	@pFecha DATE = NULL,
	@pAmortizacion FLOAT = 0,
	@pInteres FLOAT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.MovimientoSaldoAplicado(FK_Prestamo,Fecha, Amortizacion, Intereses, Activo)
			VALUES(@pPrestamo, @pFecha, @pAmortizacion, @pInteres, 1)
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
	@pNombre VARCHAR(100)

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.TipoMovimientoInteresDiario(Nombre, Activo)
			VALUES(@pNombre, 1)
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
	@pTasa FLOAT = 0,
	@pPlazo INT = 0

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.TipoPrestamo(Nombre, Tasa, Plazo, Activo)
			VALUES (@pNombre, @pTasa, @pPlazo, 1)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_InsertarRecibo
	@pMovimientoSaldoNoAplicado INT,
	@pTexto VARCHAR(500)

AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEl READ UNCOMMITTED;
		BEGIN TRANSACTION;
			INSERT INTO dbo.Recibo(FK_MovimientoSaldoNoAplicado, Texto, Estado)
			VALUES (@pMovimientoSaldoNoAplicado, @pTexto, 1)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK

		RETURN @@ERROR * -1;
	END CATCH
END
GO