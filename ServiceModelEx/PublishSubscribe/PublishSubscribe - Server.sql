IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'PublishSubscribe')
	DROP DATABASE [PublishSubscribe]
GO


DECLARE @device_directory NVARCHAR(520)
SELECT @device_directory = SUBSTRING(filename, 1, CHARINDEX(N'master.mdf', LOWER(filename)) - 1)
FROM master.dbo.sysaltfiles WHERE dbid = 1 AND fileid = 1

EXECUTE (N'CREATE DATABASE PublishSubscribe
  ON PRIMARY (NAME = N''PublishSubscribe'', FILENAME = N''' + @device_directory + N'PublishSubscribe.mdf'')
  LOG ON (NAME = N''PublishSubscribe_log'',  FILENAME = N''' + @device_directory + N'PublishSubscribe_log.ldf'')')
GO


exec sp_dboption N'PublishSubscribe', N'autoclose', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'bulkcopy', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'trunc. log', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'torn page detection', N'true'
GO

exec sp_dboption N'PublishSubscribe', N'read only', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'dbo use', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'single', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'autoshrink', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'ANSI null default', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'recursive triggers', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'ANSI nulls', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'concat null yields null', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'cursor close on commit', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'default to local cursor', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'quoted identifier', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'ANSI warnings', N'false'
GO

exec sp_dboption N'PublishSubscribe', N'auto create statistics', N'true'
GO

exec sp_dboption N'PublishSubscribe', N'auto update statistics', N'true'
GO

if( (@@microsoftversion / power(2, 24) = 8) and (@@microsoftversion & 0xffff >= 724) )
	exec sp_dboption N'PublishSubscribe', N'db chaining', N'false'
GO

use [PublishSubscribe]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PersistentSubscribers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PersistentSubscribers]
GO

CREATE TABLE [dbo].[PersistentSubscribers] (
	[Address] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Operation] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Contract] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

INSERT INTO PersistentSubscribers (Address,Operation,Contract) Values ('http://localhost:7000/MyPersistentSubscriber1.svc','OnEvent1','IMyEvents')
INSERT INTO PersistentSubscribers (Address,Operation,Contract) Values ('http://localhost:7000/MyPersistentSubscriber2.svc','OnEvent2','IMyEvents')
INSERT INTO PersistentSubscribers (Address,Operation,Contract) Values ('http://localhost:7000/MyPersistentSubscriber3.svc','OnEvent3','IMyEvents')
GO


