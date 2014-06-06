IF DB_ID('ReportingDB') IS NOT NULL
	DROP DATABASE ReportingDB
	
CREATE DATABASE ReportingDB
GO
use ReportingDB;

BEGIN TRANSACTION
GO

CREATE TABLE dbo.TClient(
	Id int NOT NULL IDENTITY,
	Name nvarchar(50) NOT NULL UNIQUE,
	CONSTRAINT PK_Client PRIMARY KEY (Id)
)

CREATE TABLE dbo.TReport(
	TransactionDate date NOT NULL DEFAULT GETDATE(),
	Invoice nvarchar(50) NOT NULL UNIQUE,
	CCAmount decimal(18,2),
	CommissionAirline decimal(18,2),
	CommissionAgent decimal(18,2),
	AccountReceivable decimal(18,2),
	AccountPayable decimal(18,2),
	BSPGST decimal(18,2), 
	NetRemit decimal(18,2),
	Rebate decimal(18,2),
	GSTCollected decimal(18,2),
	GSTPaid decimal(18,2),
	CONSTRAINT PK_Invoice PRIMARY KEY (Invoice)
)

CREATE TABLE dbo.AggInvoiceClient(
	Invoice nvarchar(50) NOT NULL,
	ClientId int NOT NULL,
	AccountReceivable decimal(18,2),
	AccountPayable decimal(18,2),
	comments nvarchar(200),
	paid bit
	CONSTRAINT PK_AggInvCli PRIMARY KEY (Invoice, ClientId)
	CONSTRAINT FK_Client FOREIGN KEY ([ClientId]) REFERENCES dbo.TClient(Id) ON DELETE CASCADE,
	CONSTRAINT FK_Report FOREIGN KEY ([Invoice]) REFERENCES dbo.TReport(Invoice) On DELETE CASCADE
)

insert into dbo.TClient(Name) values ('Jaime');
insert into dbo.TClient(Name) values ('Cersei');
insert into dbo.TClient(Name) values ('Jon Snow');
insert into dbo.TClient(Name) values ('Barriston');
insert into dbo.TClient(Name) values ('Daenerys');
insert into dbo.TClient(Name) values ('Brienne');
insert into dbo.TClient(Name) values ('Samwell');
insert into dbo.TClient(Name) values ('Sansa');
insert into dbo.TClient(Name) values ('Bran');
insert into dbo.TClient(Name) values ('Petyr');

INSERT INTO [dbo].[TReport]
([TransactionDate], [Invoice] , [CCAmount] , [CommissionAirline] , [CommissionAgent] , [AccountReceivable],
[AccountPayable] , [BSPGST] , [NetRemit] , [Rebate] , [GSTCollected] , [GSTPaid])
VALUES ('2014-02-03',N'37330',30.00,35.00,60.00,22.22,11.11,0.04,1.00,1.00,2.86,1.00)

INSERT INTO [dbo].[TReport]
([TransactionDate], [Invoice] , [CCAmount] , [CommissionAirline] , [NetRemit] , [Rebate] , [GSTCollected] , [GSTPaid])
VALUES ('2014-02-26',N'839548',2320.69,100.00,100.00,100.00,1.00,1.00)

INSERT INTO dbo.AggInvoiceClient(Invoice,ClientId,AccountReceivable)
values (N'37330', 9, 20.40)
INSERT INTO dbo.AggInvoiceClient(Invoice,ClientId,AccountReceivable)
values (N'37330', 3, 40.40)
INSERT INTO dbo.AggInvoiceClient(Invoice,ClientId,AccountReceivable)
values (N'37330', 4, 50.40)
INSERT INTO dbo.AggInvoiceClient(Invoice,ClientId,AccountPayable)
values (N'37330', 1, 40.00)
INSERT INTO dbo.AggInvoiceClient(Invoice,ClientId,AccountPayable)
values (N'37330', 2, 40.00)

INSERT INTO dbo.AggInvoiceClient(Invoice,ClientId,AccountReceivable)
values (N'839548', 1, 20.40)
INSERT INTO dbo.AggInvoiceClient(Invoice,ClientId,AccountPayable)
values (N'839548', 3, 20.40)

COMMIT