if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ClearAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ClearAll]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Entries]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Entries]
GO

CREATE TABLE [dbo].[Entries] (
	[MachineName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[HostName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[AssemblyName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FileName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LineNumber] [int] NULL ,
	[TypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[MemberAccessed] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[EntryDate] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[EntryTime] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ExceptionName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ExceptionMessage] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ProvidedFault] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ProvidedMessage] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Event] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[EntryNumber] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE dbo.ClearAll
AS
	SET NOCOUNT OFF;
DELETE FROM Entries


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

