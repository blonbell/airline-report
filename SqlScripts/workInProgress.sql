use ReportingDB;

DECLARE @Client nvarchar(50);
SET @Client = N'Jon Snow';
DECLARE @StartDate date;
SET @StartDate = '2014-01-25';
DECLARE @EndDate date;
SET @EndDate = '2014-02-27';

select * from
(select R.Invoice, R.TransactionDate,
STUFF((SELECT ',|' + iC.name + '|'
              FROM dbo.TClient iC inner join dbo.AggInvoiceClient A
              ON iC.id = A.clientId
              WHERE
              A.invoice = R.invoice AND A.AccountReceivable IS NOT NULL
                        FOR XML PATH('')
                        ), 1, 1, '' )
       AS [Receivables],
STUFF((SELECT ',|' + iC.name + '|'
              FROM dbo.TClient iC inner join dbo.AggInvoiceClient A
              ON iC.id = A.clientId
              WHERE
              A.invoice = R.invoice AND A.AccountPayable IS NOT NULL
                        FOR XML PATH('')
                        ), 1, 1, '' )
       AS [Payable],
R.CCAmount,R.CommissionAirline,R.CommissionAgent,R.AccountReceivable,
R.AccountPayable,R.BSPGST,R.NetRemit,R.Rebate,R.GSTCollected,
R.GSTPaid, 0 as Paid, 0 as ClientId, 1 as Zindex
from dbo.TReport as R 
UNION
select R.Invoice, R.TransactionDate,
(Select '|' + cliR.name + '|' from dbo.TClient as cliR 
where cliR.Id = C.Id AND A.AccountReceivable IS NOT NULL) as Receivables, 
(Select '|' + cliP.name + '|' from dbo.TClient as cliP 
where cliP.ID = C.Id AND A.AccountPayable IS NOT NULL) as Payables,
R.CCAmount,R.CommissionAirline,R.CommissionAgent,A.AccountReceivable,
A.AccountPayable,R.BSPGST,R.NetRemit,R.Rebate,R.GSTCollected,
R.GSTPaid, A.Paid, A.ClientId, 3 as Zindex
from dbo.TReport as R inner join dbo.AggInvoiceClient as A 
on R.Invoice = A.Invoice inner join dbo.TClient as C
on A.ClientId = C.Id
) as PView
WHERE (PView.invoice in (select distinct A.invoice from dbo.TReport as R inner join dbo.AggInvoiceClient as A 
on R.Invoice = A.Invoice
WHERE A.ClientId = @ClientId AND R.TransactionDate BETWEEN @StartDate AND @EndDate))
ORDER BY Invoice, Zindex;

