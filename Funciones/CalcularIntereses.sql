USE FondoAhorrosDB;
GO

CREATE FUNCTION FAFN_CalcularInteres(@pSaldoNoAplicado INT, @pTasaInteres INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @InteresDiario FLOAT = 0;

	@InteresDiario = @pSaldoNoAplicado * (@pTasaInteres / 360);

