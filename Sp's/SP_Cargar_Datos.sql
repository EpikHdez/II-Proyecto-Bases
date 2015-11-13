USE FondoAhorrosDB;
GO

CREATE PROCEDURE CCSP_CargarDatos
AS
BEGIN
	BEGIN TRY
		DECLARE @command NVARCHAR(500);
		DECLARE @document XML;
		DECLARE @xmlPath NVARCHAR(300);

		--Variables tablas para almacenar los datos leidos del documento xml
		DECLARE @deudoresT TABLE (ID INT IDENTITY(1, 1), Cedula INT, NombreCompleto VARCHAR(100));
		DECLARE @tipoPrestamoT TABLE (ID INT IDENTITY(1, 1), Nombre VARCHAR(100), Tasa FLOAT, Plazo INT);
		DECLARE @medioPagoT TABLE (ID INT IDENTITY(1, 1), Nombre VARCHAR(100));
		DECLARE @prestamosT TABLE (ID INT IDENTITY(1, 1), FK_TipoPrestamo INT, Deudor VARCHAR(100), MontoOriginal INT,
								Cuota INT, DiaCorte INT, DiaPago INT, FechaInicio DATE);

		--Comando necesario para poder cargar el documento xml desde cualquier ubicación
		SET @xmlPath = N'C:\XMLBasesProyecto2.xml';
		SET @command = N'SET @document = (SELECT * FROM OPENROWSET(BULK ''' +
			@xmlPath + ''', SINGLE_BLOB) AS data)';
		
		--Ejecutar el comando anterior y asignar a la variable @document los datos del xml leido
		EXEC dbo.sp_executesql
			@command = @command,
			@params = N'@document xml output',
			@document = @document output

		--Lectura e inserción de datos en las respectivas variables tablas
		INSERT INTO @deudoresT (Cedula, NombreCompleto)
		SELECT Deudor.value('@Cedula', 'INT'),
				Deudor.value('@Nombre', 'VARCHAR(100)')
		FROM @document.nodes('Deudores/Persona') AS DE(Deudor);

		SELECT * FROM @deudoresT;

		--INSERT INTO @tipoPrestamoT (Nombre, Tasa, Plazo)
		--SELECT TPrestamo.value('@Nombre', 'VARCHAR(100)'),
		--		TPrestamo.value('@TasaPorcentual', 'FLOAT'),
		--		TPrestamo.value('@Plazo', 'INT')
		--FROM @document.nodes('TipPrestamos/TPrestamo') AS TP(TPrestamo);

		--INSERT INTO @medioPagoT (Nombre)
		--SELECT MedioPago.value('@Tipo', 'VARCHAR(100)')
		--FROM @document.nodes('MedioPago/Medio') AS MP(MedioPago);

		--INSERT INTO @prestamosT (FK_TipoPrestamo, Deudor, MontoOriginal, Cuota, DiaCorte, DiaPago, FechaInicio)
		--SELECT Prestamo.value('@IDTipPrestamo', 'INT'),
		--		Prestamo.value('@NombrePersona', 'VARCHAR(100)'),
		--		Prestamo.value('@MontoOriginal', 'INT'),
		--		Prestamo.value('@Cuota', 'INT'),
		--		Prestamo.value('@DiaCorte', 'INT'),
		--		Prestamo.value('@DiaPaga', 'INT'),
		--		Prestamo.value('@FechaInicio', 'DATE')
		--FROM @document.nodes('Prestamos/Prestamo') AS PR(Prestamo);

		----Pasar los valores de las variables tablas a las tablas reales de la BD mediate transacción
		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		--BEGIN TRANSACTION
		--	INSERT INTO dbo.Deudores (Cedula, Nombre)
		--	SELECT DE.Cedula, DE.NombreCompleto
		--	FROM @deudoresT DE;

		--	INSERT INTO dbo.TipoPrestamo (Nombre, Tasa, Plazo)
		--	SELECT TP.Nombre, TP.Tasa, TP.Plazo
		--	FROM @tipoPrestamoT TP;

		--	INSERT INTO dbo.MedioPago (Nombre)
		--	SELECT MP.Nombre
		--	FROM @medioPagoT MP;

		--	INSERT INTO dbo.Prestamo (FK_TipoPrestamo, Deudor, MontoOriginal, Cuota, DiaCorte, DiaPago, FechaInicio)
		--	SELECT PR.FK_TipoPrestamo, PR.Deudor, PR.MontoOriginal, PR.Cuota, PR.DiaCorte, PR.DiaPago, PR.FechaInicio
		--	FROM @prestamosT PR;
		--COMMIT TRANSACTION;

		RETURN 1;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		RETURN @@ERROR * -1;
	END CATCH
END
