﻿/*
Deployment script for F15I4PRJ4Gr3

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "F15I4PRJ4Gr3"
:setvar DefaultFilePrefix "F15I4PRJ4Gr3"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[Tags]...';


GO
CREATE TABLE [dbo].[Tags] (
    [TagId] INT            NOT NULL,
    [Tag]   NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [pk_Tags] PRIMARY KEY CLUSTERED ([TagId] ASC),
    UNIQUE NONCLUSTERED ([Tag] ASC),
    UNIQUE NONCLUSTERED ([TagId] ASC)
);


GO
PRINT N'Creating [dbo].[fk_Answers]...';


GO
ALTER TABLE [dbo].[Answers] WITH NOCHECK
    ADD CONSTRAINT [fk_Answers] FOREIGN KEY ([QuestionId]) REFERENCES [dbo].[Questions] ([QuestionId]) ON UPDATE CASCADE;


GO
PRINT N'Creating [dbo].[fk_Questions]...';


GO
ALTER TABLE [dbo].[Questions] WITH NOCHECK
    ADD CONSTRAINT [fk_Questions] FOREIGN KEY ([QuizId]) REFERENCES [dbo].[Quiz] ([QuizId]) ON UPDATE CASCADE;


GO
PRINT N'Creating [dbo].[fk_QuizTagRelation]...';


GO
ALTER TABLE [dbo].[QuizTagRelation] WITH NOCHECK
    ADD CONSTRAINT [fk_QuizTagRelation] FOREIGN KEY ([QuizId]) REFERENCES [dbo].[Quiz] ([QuizId]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [dbo].[fk_QuizTagRelation2]...';


GO
ALTER TABLE [dbo].[QuizTagRelation] WITH NOCHECK
    ADD CONSTRAINT [fk_QuizTagRelation2] FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tags] ([TagId]) ON UPDATE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Answers] WITH CHECK CHECK CONSTRAINT [fk_Answers];

ALTER TABLE [dbo].[Questions] WITH CHECK CHECK CONSTRAINT [fk_Questions];

ALTER TABLE [dbo].[QuizTagRelation] WITH CHECK CHECK CONSTRAINT [fk_QuizTagRelation];

ALTER TABLE [dbo].[QuizTagRelation] WITH CHECK CHECK CONSTRAINT [fk_QuizTagRelation2];


GO
PRINT N'Update complete.';


GO