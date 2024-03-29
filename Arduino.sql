USE [arduino]
GO
/****** Object:  Table [dbo].[status]    Script Date: 09/13/2014 17:18:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[status](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](500) NOT NULL,
	[dateCreate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[dateDelete] [datetime] NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[status] ON
INSERT [dbo].[status] ([id], [name], [description], [dateCreate], [lastUpdate], [dateDelete], [deleted]) VALUES (1, N'Active', N'Active', CAST(0x0000A3A300C0A4B3 AS DateTime), CAST(0x0000A3A300C0A4B3 AS DateTime), NULL, 0)
INSERT [dbo].[status] ([id], [name], [description], [dateCreate], [lastUpdate], [dateDelete], [deleted]) VALUES (2, N'Inactive', N'Inactive', CAST(0x0000A3A300C0C526 AS DateTime), CAST(0x0000A3A300C0C526 AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[status] OFF
/****** Object:  Table [dbo].[user]    Script Date: 09/13/2014 17:18:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NOT NULL,
	[password] [varchar](12) NOT NULL,
	[dateCreate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[dateDelete] [datetime] NULL,
	[deleted] [bit] NOT NULL,
	[idStatus] [smallint] NOT NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[user] ON
INSERT [dbo].[user] ([id], [name], [password], [dateCreate], [lastUpdate], [dateDelete], [deleted], [idStatus]) VALUES (1, N'arduino', N'arduino', CAST(0x0000A3A300C11904 AS DateTime), CAST(0x0000A3A300C11904 AS DateTime), NULL, 0, 1)
SET IDENTITY_INSERT [dbo].[user] OFF
/****** Object:  Table [dbo].[port]    Script Date: 09/13/2014 17:18:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[port](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[port] [char](1) NOT NULL,
	[description] [varchar](500) NOT NULL,
	[dateCreate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[dateDelete] [datetime] NULL,
	[deleted] [bit] NOT NULL,
	[idStatus] [smallint] NOT NULL,
 CONSTRAINT [PK_arduino] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[port] ON
INSERT [dbo].[port] ([id], [name], [port], [description], [dateCreate], [lastUpdate], [dateDelete], [deleted], [idStatus]) VALUES (2, N'Port A', N'A', N'Port A', CAST(0x0000A3A300C0E751 AS DateTime), CAST(0x0000A3A300C0E751 AS DateTime), NULL, 0, 1)
INSERT [dbo].[port] ([id], [name], [port], [description], [dateCreate], [lastUpdate], [dateDelete], [deleted], [idStatus]) VALUES (3, N'Port B', N'B', N'Port B', CAST(0x0000A3A300C100E2 AS DateTime), CAST(0x0000A3A300C100E2 AS DateTime), NULL, 0, 1)
SET IDENTITY_INSERT [dbo].[port] OFF
/****** Object:  Table [dbo].[relationship]    Script Date: 09/13/2014 17:18:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[relationship](
	[idUser] [int] NOT NULL,
	[idPort] [int] NOT NULL,
	[idStatus] [smallint] NOT NULL,
 CONSTRAINT [PK_relationship] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC,
	[idPort] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[relationship] ([idUser], [idPort], [idStatus]) VALUES (1, 2, 1)
INSERT [dbo].[relationship] ([idUser], [idPort], [idStatus]) VALUES (1, 3, 2)
/****** Object:  StoredProcedure [dbo].[SetStatusPort]    Script Date: 09/13/2014 17:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetStatusPort]
	@user VARCHAR(20),
	@port CHAR(1),
	@IdStatus INT
AS

	UPDATE
		[relationship]
	SET 
		[idStatus] = @IdStatus
	FROM 
		[relationship] [r]
		INNER JOIN [user] [u] ON [u].[id] = [r].[idUser] 
		INNER JOIN [port] [p] ON [p].[id] = [r].[idPort] 
	WHERE
		[u].[name] = @user 
		AND [u].[deleted] = 0 
		AND [u].[idStatus] = 1
		AND [p].[port] = @port 
		AND [p].[deleted] = 0 
		AND [p].[idStatus] = 1
GO
/****** Object:  StoredProcedure [dbo].[ReadStatusPort]    Script Date: 09/13/2014 17:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReadStatusPort]
	@user VARCHAR(20)
AS

	SELECT 
		[p].[port],
		[r].[idStatus]
	FROM 
		[relationship] [r]
		INNER JOIN [user] [u] ON [u].[id] = [r].[idUser] 
		INNER JOIN [port] [p] ON [p].[id] = [r].[idPort] 
	WHERE
		[u].[name] = @user 
		AND [u].[deleted] = 0 
		AND [u].[idStatus] = 1
		AND [p].[deleted] = 0 
		AND [p].[idStatus] = 1
GO
/****** Object:  Default [DF_arduino_dateCreate]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[port] ADD  CONSTRAINT [DF_arduino_dateCreate]  DEFAULT (getdate()) FOR [dateCreate]
GO
/****** Object:  Default [DF_arduino_lastUpdate]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[port] ADD  CONSTRAINT [DF_arduino_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
/****** Object:  Default [DF_arduino_deleted]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[port] ADD  CONSTRAINT [DF_arduino_deleted]  DEFAULT ((0)) FOR [deleted]
GO
/****** Object:  Default [DF_arduino_status]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[port] ADD  CONSTRAINT [DF_arduino_status]  DEFAULT ((1)) FOR [idStatus]
GO
/****** Object:  Default [DF_status_dateCreate]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[status] ADD  CONSTRAINT [DF_status_dateCreate]  DEFAULT (getdate()) FOR [dateCreate]
GO
/****** Object:  Default [DF_status_lastUpdate]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[status] ADD  CONSTRAINT [DF_status_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
/****** Object:  Default [DF_status_deleted]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[status] ADD  CONSTRAINT [DF_status_deleted]  DEFAULT ((0)) FOR [deleted]
GO
/****** Object:  Default [DF_user_dateCreate]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_user_dateCreate]  DEFAULT (getdate()) FOR [dateCreate]
GO
/****** Object:  Default [DF_user_lastUpdate]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_user_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
/****** Object:  Default [DF_user_deleted]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_user_deleted]  DEFAULT ((0)) FOR [deleted]
GO
/****** Object:  Default [DF_user_idStatus]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_user_idStatus]  DEFAULT ((1)) FOR [idStatus]
GO
/****** Object:  ForeignKey [FK_arduino_status]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[port]  WITH CHECK ADD  CONSTRAINT [FK_arduino_status] FOREIGN KEY([idStatus])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[port] CHECK CONSTRAINT [FK_arduino_status]
GO
/****** Object:  ForeignKey [FK_relationship_port]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[relationship]  WITH CHECK ADD  CONSTRAINT [FK_relationship_port] FOREIGN KEY([idPort])
REFERENCES [dbo].[port] ([id])
GO
ALTER TABLE [dbo].[relationship] CHECK CONSTRAINT [FK_relationship_port]
GO
/****** Object:  ForeignKey [FK_relationship_status1]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[relationship]  WITH CHECK ADD  CONSTRAINT [FK_relationship_status1] FOREIGN KEY([idStatus])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[relationship] CHECK CONSTRAINT [FK_relationship_status1]
GO
/****** Object:  ForeignKey [FK_relationship_user1]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[relationship]  WITH CHECK ADD  CONSTRAINT [FK_relationship_user1] FOREIGN KEY([idUser])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[relationship] CHECK CONSTRAINT [FK_relationship_user1]
GO
/****** Object:  ForeignKey [FK_user_status]    Script Date: 09/13/2014 17:18:57 ******/
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [FK_user_status] FOREIGN KEY([idStatus])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_status]
GO
