USE FondoAhorrosDB;
GO

CREATE FUNCTION FAFN_CalcularInteres(@pSaldoNoAplicado FLOAT, @pTasaInteres FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @InteresDiario FLOAT = 0.0;

	SET @InteresDiario = (@pSaldoNoAplicado * (@pTasaInteres / 360));

	RETURN @InteresDiario;
END


