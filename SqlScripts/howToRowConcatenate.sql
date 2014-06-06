CREATE TABLE dbo.InvoiceClient(
	Client nvarchar(50) NOT NULL,
	Invoice nvarchar(50) NOT NULL
)

INSERT INTO [dbo].[InvoiceClient]
([Invoice], [Client])
VALUES ('1','Ben');

INSERT INTO [dbo].[InvoiceClient]
([Invoice], [Client])
VALUES ('1','John');

INSERT INTO [dbo].[InvoiceClient]
([Invoice], [Client])
VALUES ('2','Charlie');

INSERT INTO [dbo].[InvoiceClient]
([Invoice], [Client])
VALUES ('3','Aaron');

INSERT INTO [dbo].[InvoiceClient]
([Invoice], [Client])
VALUES ('3','Ben');

INSERT INTO [dbo].[InvoiceClient]
([Invoice], [Client])
VALUES ('1','Leo');


SELECT Invoice,
       STUFF((SELECT ',' + i1.Client
              FROM dbo.InvoiceClient i1
              WHERE
              i1.Invoice = o1.Invoice
                        FOR XML PATH('')
                        ), 1, 1, '' )
       AS [Clients]
FROM  dbo.InvoiceClient o1;

SELECT ',' + i1.Client
FROM dbo.InvoiceClient i1
FOR XML PATH('')

select client + ', ' as K 
from dbo.InvoiceClient Client
for xml auto