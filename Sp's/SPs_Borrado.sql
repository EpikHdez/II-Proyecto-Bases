USE FondoAhorrosDB;
GO

CREATE PROCEDURE FASP_BorrarDeudor
	@IDDeudor INT
AS
BEGIN
	BEGIN TRY
		DECLARE @prestamosDeudor TABLE (ID INT);

		INSERT INTO @prestamosDeudor (ID)
		SELECT PR.ID FROM dbo.Prestamos PR
		WHERE PR.FK_Deudor = @IDDeudor;

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE MIT
			SET Activo = 0
			FROM dbo.MovimientoInteresDiario MIT
			INNER JOIN @prestamosDeudor PD ON PD.ID = MIT.FK_Prestamo;

			UPDATE MSNA
			SET Activo = 0
			FROM dbo.MovimientoSaldoNoAplicado MSNA
			INNER JOIN @prestamosDeudor PD ON PD.ID = MSNA.FK_Prestamo;

			UPDATE MSA
			SET Activo = 0
			FROM dbo.MovimientoSaldoAplicado MSA
			INNER JOIN @prestamosDeudor PD ON PD.ID = MSA.FK_Prestamo;

			UPDATE dbo.Prestamos
			SET Activo = 0
			WHERE FK_Deudor = @IDDeudor;

			UPDATE dbo.Deudores
			SET Activo = 0
			WHERE ID = @IDDeudor;
		COMMIT TRANSACTION;

		RETURN 1;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_BorrarPrestamo
	@IDPrestamo INT
AS
BEGIN
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		BEGIN TRANSACTION
			UPDATE dbo.MovimientoInteresDiario
			SET Activo = 0
			WHERE FK_Prestamo = @IDPrestamo;

			UPDATE dbo.MovimientoSaldoNoAplicado
			SET Activo = 0
			WHERE FK_Prestamo = @IDPrestamo;

			UPDATE dbo.MovimientoSaldoAplicado
			SET Activo = 0
			WHERE FK_Prestamo = @IDPrestamo;

			UPDATE dbo.Prestamos
			SET Activo = 0
			WHERE ID = @IDPrestamo;
		COMMIT TRANSACTION;

		RETURN 1;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_BorrarMovimientoInteresDiario
	@IDMovimientoInteresDiario INT
AS
BEGIN
	BEGIN TRY
		UPDATE dbo.MovimientoInteresDiario
		SET Activo = 0
		WHERE ID = @IDMovimientoInteresDiario;
		
		RETURN 1;
	END TRY
	BEGIN CATCH
		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_BorrarMovimientoSaldoNoAplicado
	@IDMovimientoSaldoNoAplicado INT
AS
BEGIN
	BEGIN TRY
		UPDATE dbo.MovimientoSaldoNoAplicado
		SET Activo = 0
		WHERE ID = @IDMovimientoSaldoNoAplicado;
		
		RETURN 1;
	END TRY
		RETURN @@ERROR * -1;
	BEGIN CATCH
	END CATCH
END
GO

CREATE PROCEDURE FASP_BorrarMovimientoSaldoAplicado
	@IDMovimientoSaldoAplicado INT
AS
BEGIN
	BEGIN TRY
		UPDATE dbo.MovimientoSaldoAplicado
		SET Activo = 0
		WHERE ID = @IDMovimientoSaldoAplicado;
		
		RETURN 1;
	END TRY
	BEGIN CATCH
		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_BorrarTipoMovimientoInteresDiario
	@IDTipoMovimientoInteresDiario INT
AS
BEGIN
	BEGIN TRY
		UPDATE dbo.TipoMovimientoInteresDiario
		SET Activo = 0
		WHERE ID = @IDTipoMovimientoInteresDiario;
		
		RETURN 1;
	END TRY
	BEGIN CATCH
		RETURN @@ERROR * -1;
	END CATCH
END
GO

CREATE PROCEDURE FASP_BorrarTipoPrestamo
	@IDTipoPrestamo INT
AS
BEGIN
	BEGIN TRY
		UPDATE dbo.TipoPrestamo
		SET Activo = 0
		WHERE ID = @IDTipoPrestamo;
		
		RETURN 1;
	END TRY
	BEGIN CATCH
		RETURN @@ERROR * -1;
	END CATCH
END
GO