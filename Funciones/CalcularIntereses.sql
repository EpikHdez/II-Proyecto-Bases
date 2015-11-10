USE FondoAhorrosDB;
GO

CREATE FUNCTION FAFN_CalcularInteres(@pSaldoNoAplicado INT, @pTasaInteres INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @InteresDiario FLOAT,

	@InteresDiario = @pSaldoNoAplicado * (@pTasaInteres / 360);

