USE FondoAhorrosDB;
GO

CREATE PROCEDURE FASP_PagarRecibo

Create table #TopRecibo(ID int,
							[FK-MovSaldoNoApl] int,
							Estado bit)
	
	Insert into #TopRecibo(ID,
						   [FK-MovSaldoNoApl],
						   Estado)
	Select top 1 R.ID,
				 R.[FK-MovSaldoNoApl],
				 R.Estado
	
	From Recibo R
	Inner join MovSaldoNoApl MSNA on MSNA.ID=R.[FK-MovSaldoNoApl]
	Inner join Prestamo P on P.ID=MSNA.[FK-Prestamo]

	Where P.ID=@prestamo and R.Estado=1
	
	


	Set transaction isolation level read uncommitted
	Begin transaction
		
		Insert MovSaldoAplicado([FK-Prestamo], [FK-TipoMovSaldoApl], Amortizacion, Intereses, Fecha)
		Select @prestamo, 1, MSNA.Amortizacion, MSNA.Intereses, GETDATE()
		From MovSaldoNoApl MSNA
		Inner join Recibo R on R.[FK-MovSaldoNoApl]=MSNA.ID
		Inner join #TopRecibo TR on TR.ID=R.ID
		Where MSNA.[FK-Prestamo]=@prestamo
		
		Update Prestamo 
		Set SaldoAplicado=SaldoAplicado-MSNA.Amortizacion
		From MovSaldoNoApl MSNA
		Inner join Recibo R on R.[FK-MovSaldoNoApl]=MSNA.ID
		Inner join #TopRecibo TR on TR.ID=R.ID
		Where MSNA.[FK-Prestamo]=@prestamo

		Update Recibo
		Set Estado=0
		From #TopRecibo TR
		Where Recibo.ID = TR.ID

	Commit transaction