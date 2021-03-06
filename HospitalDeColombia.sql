USE [master]
GO
/****** Object:  Database [HospitalDeColombia]    Script Date: 24/08/2015 19:11:05 ******/
CREATE DATABASE [HospitalDeColombia]
 CONTAINMENT = NONE
GO
ALTER DATABASE [HospitalDeColombia] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HospitalDeColombia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HospitalDeColombia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET ARITHABORT OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [HospitalDeColombia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HospitalDeColombia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HospitalDeColombia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HospitalDeColombia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HospitalDeColombia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET RECOVERY FULL 
GO
ALTER DATABASE [HospitalDeColombia] SET  MULTI_USER 
GO
ALTER DATABASE [HospitalDeColombia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HospitalDeColombia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HospitalDeColombia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HospitalDeColombia] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HospitalDeColombia', N'ON'
GO
USE [HospitalDeColombia]
GO
/****** Object:  StoredProcedure [dbo].[CV_CrudPersonas]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM Personas
--[dbo].[CV_CrudPersonas] '0', '-1', 'Carlos', 'Vargas', '1013626407', 'cavargas40@gmail.com' --INSERT
--[dbo].[CV_CrudPersonas] '0', '6', 'Carlos Andres', 'Vargas Lopez', '1013626408', 'cavargas40@gmail.com' --UPDATE
--[dbo].[CV_CrudPersonas] '1', '7', 'Carlos Andres', 'Vargas Lopez', '1013626408', 'cavargas40@gmail.com' --DELETE
--[dbo].[CV_CrudPersonas] '2', '6', 'Carlos Andres', 'Vargas Lopez', '1013626408', 'cavargas40@gmail.com' --SELECT
CREATE PROCEDURE [dbo].[CV_CrudPersonas]
@Op int,
@id_persona int = '-1',
@Nombres nvarchar(200) = '-1',
@Apellidos nvarchar(200) = '-1',
@Documento nvarchar(50) = '-1',
@email nvarchar(100) = '-1'
AS BEGIN
	--INSERT / UPDATE
	IF(@Op = 0)
	BEGIN
		IF(SELECT COUNT(1) FROM Personas WHERE id_persona = @id_persona)>0
		BEGIN
			UPDATE	Personas
			SET     Nombres = @Nombres, Apellidos = @Apellidos, Documento = @Documento, email = @email
			WHERE	id_persona = @id_persona

			SELECT	id_persona, 
					Nombres,  
					Apellidos,
					Documento, 
					email
			FROM	Personas 
			WHERE   id_persona = @id_persona;
			RETURN;
		END
		INSERT INTO Personas(Nombres, Apellidos, Documento, email)
		VALUES        (@Nombres,@Apellidos,@Documento,@email);

		SELECT	id_persona, 
				Nombres,  
				Apellidos,
				Documento, 
				email 
		FROM	Personas 
		WHERE   id_persona = SCOPE_IDENTITY();

		RETURN;
	END
	--DELETE
	IF(@Op = 1)
	BEGIN
		DELETE 
		FROM	Personas
		WHERE	id_persona = @id_persona
	END
	--SELECT
	IF(@Op = 2)
	BEGIN
		SELECT	Nombres, Documento, id_persona, Apellidos, email
		FROM    Personas
	END
END

GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[id_categoria] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cita_Medica]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cita_Medica](
	[id_cita] [int] IDENTITY(1,1) NOT NULL,
	[id_paciente] [int] NOT NULL,
	[id_medico] [int] NOT NULL,
	[id_valor] [int] NOT NULL,
	[Observaciones] [nvarchar](200) NULL,
	[fecha] [date] NOT NULL,
	[id_sede] [int] NOT NULL,
	[Tipo_Medicina] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cita_Medica] PRIMARY KEY CLUSTERED 
(
	[id_cita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Especialidad]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialidad](
	[id_especialidad] [int] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_Especialidad] PRIMARY KEY CLUSTERED 
(
	[id_especialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Especialidad_Medico]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialidad_Medico](
	[id_especialidad_Medico] [int] IDENTITY(1,1) NOT NULL,
	[id_medico] [int] NOT NULL,
	[id_especialidad] [int] NOT NULL,
 CONSTRAINT [PK_Especialidad_Medico] PRIMARY KEY CLUSTERED 
(
	[id_especialidad_Medico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Medicos]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicos](
	[id_medico] [int] IDENTITY(1,1) NOT NULL,
	[id_persona] [int] NOT NULL,
 CONSTRAINT [PK_Medicos] PRIMARY KEY CLUSTERED 
(
	[id_medico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Paciente]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paciente](
	[id_paciente] [int] IDENTITY(1,1) NOT NULL,
	[id_persona] [int] NOT NULL,
	[TipoUsuario] [nvarchar](50) NOT NULL,
	[id_categoria] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Paciente] PRIMARY KEY CLUSTERED 
(
	[id_paciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Personas]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[id_persona] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [nvarchar](200) NULL,
	[Apellidos] [nvarchar](200) NULL,
	[Documento] [nvarchar](50) NULL,
	[F_nacimiento] [smalldatetime] NULL,
	[sexo] [nvarchar](50) NULL,
	[Telefono] [nvarchar](50) NULL,
	[Direccion] [nvarchar](100) NULL,
	[email] [nvarchar](100) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[id_persona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sede]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sede](
	[id_sede] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Observacion] [nvarchar](100) NULL,
 CONSTRAINT [PK_Sede] PRIMARY KEY CLUSTERED 
(
	[id_sede] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sede_Medico]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sede_Medico](
	[id_Sede_Medico] [int] IDENTITY(1,1) NOT NULL,
	[id_medico] [int] NOT NULL,
	[id_sede] [int] NOT NULL,
 CONSTRAINT [PK_Sede_Medico] PRIMARY KEY CLUSTERED 
(
	[id_Sede_Medico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ValorConsulta]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValorConsulta](
	[id_valor] [int] NOT NULL,
	[id_categoria] [nvarchar](50) NOT NULL,
	[V_MedicinaGeneral] [money] NOT NULL,
	[V_MedicinaEspecial] [money] NOT NULL,
 CONSTRAINT [PK_ValorConsulta] PRIMARY KEY CLUSTERED 
(
	[id_valor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[NinosMenores10Sur]    Script Date: 24/08/2015 19:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[NinosMenores10Sur]
AS 
	SELECT	COUNT(1) AS [# de Niños Menores de 10 años sede Sur]
	FROM    Cita_Medica 
			INNER JOIN Paciente ON Cita_Medica.id_paciente = Paciente.id_paciente 
			INNER JOIN Personas ON Paciente.id_persona = Personas.id_persona 
			INNER JOIN Sede ON Cita_Medica.id_sede = Sede.id_sede
	WHERE   (DATEDIFF(month, Personas.F_nacimiento, GETDATE()) <= 120)
	AND		Sede.Nombre IN ('Kennedy')

GO
INSERT [dbo].[Categoria] ([id_categoria]) VALUES (N'A')
INSERT [dbo].[Categoria] ([id_categoria]) VALUES (N'B')
INSERT [dbo].[Categoria] ([id_categoria]) VALUES (N'C')
SET IDENTITY_INSERT [dbo].[Cita_Medica] ON 

INSERT [dbo].[Cita_Medica] ([id_cita], [id_paciente], [id_medico], [id_valor], [Observaciones], [fecha], [id_sede], [Tipo_Medicina]) VALUES (2, 2, 1, 1, NULL, CAST(0x303A0B00 AS Date), 2, N'MedicinaGeneral')
INSERT [dbo].[Cita_Medica] ([id_cita], [id_paciente], [id_medico], [id_valor], [Observaciones], [fecha], [id_sede], [Tipo_Medicina]) VALUES (3, 1, 1, 2, NULL, CAST(0x84380B00 AS Date), 2, N'MedicinaEspecialista')
SET IDENTITY_INSERT [dbo].[Cita_Medica] OFF
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (1, N'MedicinaGeneral', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (2, N'MedicinaInterna', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (3, N'Ginecologia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (4, N'Gastroenterologia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (5, N'Neurologia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (6, N'Hematologia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (7, N'Dermatologia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (8, N'Fisioterapia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (9, N'Oncologia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (10, N'Urologia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (11, N'Otorrinolaringología', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (12, N'Proctologia', NULL)
INSERT [dbo].[Especialidad] ([id_especialidad], [Nombre], [Descripcion]) VALUES (13, N'Cardiolodia', NULL)
SET IDENTITY_INSERT [dbo].[Especialidad_Medico] ON 

INSERT [dbo].[Especialidad_Medico] ([id_especialidad_Medico], [id_medico], [id_especialidad]) VALUES (1, 1, 2)
SET IDENTITY_INSERT [dbo].[Especialidad_Medico] OFF
SET IDENTITY_INSERT [dbo].[Medicos] ON 

INSERT [dbo].[Medicos] ([id_medico], [id_persona]) VALUES (1, 5)
SET IDENTITY_INSERT [dbo].[Medicos] OFF
SET IDENTITY_INSERT [dbo].[Paciente] ON 

INSERT [dbo].[Paciente] ([id_paciente], [id_persona], [TipoUsuario], [id_categoria]) VALUES (1, 2, N'Beneficiario', N'A')
INSERT [dbo].[Paciente] ([id_paciente], [id_persona], [TipoUsuario], [id_categoria]) VALUES (2, 4, N'Cotizante', N'B')
SET IDENTITY_INSERT [dbo].[Paciente] OFF
SET IDENTITY_INSERT [dbo].[Personas] ON 

INSERT [dbo].[Personas] ([id_persona], [Nombres], [Apellidos], [Documento], [F_nacimiento], [sexo], [Telefono], [Direccion], [email]) VALUES (2, N'Cristian Pamela', N'Sanabria Barrera', N'14101454504', CAST(0xA2670000 AS SmallDateTime), N'Masculino', N'4500232', N'Calle 25a N 39 sur', N'xiomy@love.com')
INSERT [dbo].[Personas] ([id_persona], [Nombres], [Apellidos], [Documento], [F_nacimiento], [sexo], [Telefono], [Direccion], [email]) VALUES (4, N'Martina Natalia', N'Gonzales', N'12345678', CAST(0x9DD90000 AS SmallDateTime), N'Femenino', N'7863409', N'Calle 9 N 37 98', N'pameynata@gmail.com')
INSERT [dbo].[Personas] ([id_persona], [Nombres], [Apellidos], [Documento], [F_nacimiento], [sexo], [Telefono], [Direccion], [email]) VALUES (5, N'Juan Carlos', N'Narvaes', N'54983652788', CAST(0x7F7E0000 AS SmallDateTime), N'Masculino', N'23487655333', N'Carrera 52 n 34-25', NULL)
INSERT [dbo].[Personas] ([id_persona], [Nombres], [Apellidos], [Documento], [F_nacimiento], [sexo], [Telefono], [Direccion], [email]) VALUES (9, N'Xiomara Andrea', N'Pulido Balmaceda', N'23456789', NULL, NULL, NULL, NULL, N'xiomy@nose.com')
INSERT [dbo].[Personas] ([id_persona], [Nombres], [Apellidos], [Documento], [F_nacimiento], [sexo], [Telefono], [Direccion], [email]) VALUES (10, N'Carlos Andres', N'Vargas Lopez', N'1013626407', NULL, NULL, NULL, NULL, N'cavargas40@gmail.com')
SET IDENTITY_INSERT [dbo].[Personas] OFF
INSERT [dbo].[Sede] ([id_sede], [Nombre], [Observacion]) VALUES (1, N'Floresta', NULL)
INSERT [dbo].[Sede] ([id_sede], [Nombre], [Observacion]) VALUES (2, N'Kennedy', NULL)
INSERT [dbo].[Sede] ([id_sede], [Nombre], [Observacion]) VALUES (3, N'Chapinero', NULL)
INSERT [dbo].[Sede] ([id_sede], [Nombre], [Observacion]) VALUES (4, N'Calle163', NULL)
INSERT [dbo].[Sede] ([id_sede], [Nombre], [Observacion]) VALUES (5, N'Normandia', NULL)
SET IDENTITY_INSERT [dbo].[Sede_Medico] ON 

INSERT [dbo].[Sede_Medico] ([id_Sede_Medico], [id_medico], [id_sede]) VALUES (1, 1, 2)
SET IDENTITY_INSERT [dbo].[Sede_Medico] OFF
INSERT [dbo].[ValorConsulta] ([id_valor], [id_categoria], [V_MedicinaGeneral], [V_MedicinaEspecial]) VALUES (1, N'A', 4000.0000, 5000.0000)
INSERT [dbo].[ValorConsulta] ([id_valor], [id_categoria], [V_MedicinaGeneral], [V_MedicinaEspecial]) VALUES (2, N'B', 6000.0000, 7000.0000)
INSERT [dbo].[ValorConsulta] ([id_valor], [id_categoria], [V_MedicinaGeneral], [V_MedicinaEspecial]) VALUES (3, N'C', 8000.0000, 9000.0000)
ALTER TABLE [dbo].[Cita_Medica]  WITH CHECK ADD  CONSTRAINT [FK_Cita_Medica_Medicos] FOREIGN KEY([id_medico])
REFERENCES [dbo].[Medicos] ([id_medico])
GO
ALTER TABLE [dbo].[Cita_Medica] CHECK CONSTRAINT [FK_Cita_Medica_Medicos]
GO
ALTER TABLE [dbo].[Cita_Medica]  WITH CHECK ADD  CONSTRAINT [FK_Cita_Medica_Paciente] FOREIGN KEY([id_paciente])
REFERENCES [dbo].[Paciente] ([id_paciente])
GO
ALTER TABLE [dbo].[Cita_Medica] CHECK CONSTRAINT [FK_Cita_Medica_Paciente]
GO
ALTER TABLE [dbo].[Cita_Medica]  WITH CHECK ADD  CONSTRAINT [FK_Cita_Medica_Sede] FOREIGN KEY([id_sede])
REFERENCES [dbo].[Sede] ([id_sede])
GO
ALTER TABLE [dbo].[Cita_Medica] CHECK CONSTRAINT [FK_Cita_Medica_Sede]
GO
ALTER TABLE [dbo].[Cita_Medica]  WITH CHECK ADD  CONSTRAINT [FK_Cita_Medica_ValorConsulta] FOREIGN KEY([id_valor])
REFERENCES [dbo].[ValorConsulta] ([id_valor])
GO
ALTER TABLE [dbo].[Cita_Medica] CHECK CONSTRAINT [FK_Cita_Medica_ValorConsulta]
GO
ALTER TABLE [dbo].[Especialidad_Medico]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Medico_Especialidad] FOREIGN KEY([id_especialidad])
REFERENCES [dbo].[Especialidad] ([id_especialidad])
GO
ALTER TABLE [dbo].[Especialidad_Medico] CHECK CONSTRAINT [FK_Especialidad_Medico_Especialidad]
GO
ALTER TABLE [dbo].[Especialidad_Medico]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Medico_Medicos] FOREIGN KEY([id_medico])
REFERENCES [dbo].[Medicos] ([id_medico])
GO
ALTER TABLE [dbo].[Especialidad_Medico] CHECK CONSTRAINT [FK_Especialidad_Medico_Medicos]
GO
ALTER TABLE [dbo].[Paciente]  WITH CHECK ADD  CONSTRAINT [FK_Paciente_Categoria] FOREIGN KEY([id_categoria])
REFERENCES [dbo].[Categoria] ([id_categoria])
GO
ALTER TABLE [dbo].[Paciente] CHECK CONSTRAINT [FK_Paciente_Categoria]
GO
ALTER TABLE [dbo].[Paciente]  WITH CHECK ADD  CONSTRAINT [FK_Paciente_Personas] FOREIGN KEY([id_persona])
REFERENCES [dbo].[Personas] ([id_persona])
GO
ALTER TABLE [dbo].[Paciente] CHECK CONSTRAINT [FK_Paciente_Personas]
GO
ALTER TABLE [dbo].[Sede_Medico]  WITH CHECK ADD  CONSTRAINT [FK_Sede_Medico_Medicos] FOREIGN KEY([id_medico])
REFERENCES [dbo].[Medicos] ([id_medico])
GO
ALTER TABLE [dbo].[Sede_Medico] CHECK CONSTRAINT [FK_Sede_Medico_Medicos]
GO
ALTER TABLE [dbo].[Sede_Medico]  WITH CHECK ADD  CONSTRAINT [FK_Sede_Medico_Sede] FOREIGN KEY([id_sede])
REFERENCES [dbo].[Sede] ([id_sede])
GO
ALTER TABLE [dbo].[Sede_Medico] CHECK CONSTRAINT [FK_Sede_Medico_Sede]
GO
ALTER TABLE [dbo].[ValorConsulta]  WITH CHECK ADD  CONSTRAINT [FK_ValorConsulta_Categoria] FOREIGN KEY([id_categoria])
REFERENCES [dbo].[Categoria] ([id_categoria])
GO
ALTER TABLE [dbo].[ValorConsulta] CHECK CONSTRAINT [FK_ValorConsulta_Categoria]
GO
USE [master]
GO
ALTER DATABASE [HospitalDeColombia] SET  READ_WRITE 
GO
