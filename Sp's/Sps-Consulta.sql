USE FondoAhorrosDB

CREATE PROCEDURE FASP_ConsultarDeudores
AS
BEGIN
	SELECT D.Nombre
	FROM Deudores D;
END
GO

CREATE PROCEDURE FASP_ConsultarPrestamos
AS
BEGIN 
	SELECT P.MontoOriginal, P.Cuota, P.PlazoRestante, P.SaldoNoAplicado, P.SaldoAplicado, P.InteresAcumuladoMensual,
	P.DiaCorte
	FROM Prestamos P;
END
GO

CREATE PROCEDURE FASP_ConsultarTipoPrestamo
AS
BEGIN
	SELECT T.Nombre, T.Tasa, T.Plazo, T.Periodo
	FROM TipoPrestamo T;
END
GO


