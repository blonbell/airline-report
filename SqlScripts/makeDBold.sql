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
	Receivable nvarchar(50),
	Payable nvarchar(50),
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
	AccountReceivable decimal(18,2) NOT NULL,
	AccountPayable decimal(18,2) NOT NULL,
	comments nvarchar(200),
	CONSTRAINT FK_Client FOREIGN KEY ([ClientId]) REFERENCES dbo.TClient(Id) ON DELETE CASCADE,
	CONSTRAINT FK_Report FOREIGN KEY ([Invoice]) REFERENCES dbo.TReport(Invoice) On DELETE CASCADE
)

CREATE TABLE dbo.TPayNote (
	[Invoice] nvarchar(50) NOT NULL,
	[paydate] [date],
	[comments] nvarchar(100),
	CONSTRAINT [PK_PayNote] PRIMARY KEY ([Invoice]),
	CONSTRAINT [FK_PayNote] FOREIGN KEY ([Invoice]) REFERENCES dbo.TReport(Invoice) ON DELETE CASCADE
)

insert into dbo.Client(Name) values ('HBSC');
insert into dbo.Client(Name) values ('DHS');
insert into dbo.Client(Name) values ('BillyTravelling');
insert into dbo.Client(Name) values ('T1');
insert into dbo.Client(Name) values ('T2');

INSERT INTO [dbo].[TReport]
([TransactionDate], [Receivable], [Payable], [Invoice] , [CCAmount] , [CommissionAirline] , [CommissionAgent] , [AccountReceivable],
[AccountPayable] , [BSPGST] , [NetRemit] , [Rebate] , [GSTCollected] , [GSTPaid])
VALUES ('2014-02-03',N'BSP',N'PAX',N'37330',null,null,60.00,null,null,null,null,null,2.86,null)

INSERT INTO [dbo].[TReport]
([TransactionDate], [Receivable], [Payable], [Invoice] , [CCAmount] , [CommissionAirline] , [NetRemit] , [Rebate] , [GSTCollected] , [GSTPaid])
VALUES ('2014-02-26',N'BSP',N'HT Travel',N'839548',2320.69,100.00,100.00,100.00,1.00,1.00)

COMMIT