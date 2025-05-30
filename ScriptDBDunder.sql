USE [master]
GO
/****** Object:  Database [DBDunder]    Script Date: 28-04-2025 23:35:01 ******/
CREATE DATABASE [DBDunder]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBDunder', FILENAME = N'C:\SQLData\DBDunder.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBDunder_log', FILENAME = N'C:\SQLData\DBDunder_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DBDunder] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBDunder].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBDunder] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBDunder] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBDunder] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBDunder] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBDunder] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBDunder] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DBDunder] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBDunder] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBDunder] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBDunder] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBDunder] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBDunder] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBDunder] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBDunder] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBDunder] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBDunder] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBDunder] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBDunder] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBDunder] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBDunder] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBDunder] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBDunder] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBDunder] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBDunder] SET  MULTI_USER 
GO
ALTER DATABASE [DBDunder] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBDunder] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBDunder] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBDunder] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBDunder] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBDunder] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DBDunder] SET QUERY_STORE = ON
GO
ALTER DATABASE [DBDunder] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DBDunder]
GO
/****** Object:  Table [dbo].[departamentos]    Script Date: 28-04-2025 23:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departamentos](
	[id_dep] [int] IDENTITY(1,1) NOT NULL,
	[NombreDep] [varchar](50) NULL,
	[Ubicacion] [varchar](100) NULL,
	[NombreJefe] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_dep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[empleado]    Script Date: 28-04-2025 23:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[empleado](
	[id_emp] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[telefono] [varchar](20) NULL,
	[correo] [varchar](100) NULL,
	[departamento] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_emp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[empleado_departamento]    Script Date: 28-04-2025 23:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[empleado_departamento](
	[id_emp] [int] NOT NULL,
	[id_dep] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_emp] ASC,
	[id_dep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[departamentos] ON 

INSERT [dbo].[departamentos] ([id_dep], [NombreDep], [Ubicacion], [NombreJefe]) VALUES (1, N'Ventas', N'Scranton', N'Jan Levinson')
INSERT [dbo].[departamentos] ([id_dep], [NombreDep], [Ubicacion], [NombreJefe]) VALUES (2, N'Recepcion', N'Scranton', N'Michael Scott')
INSERT [dbo].[departamentos] ([id_dep], [NombreDep], [Ubicacion], [NombreJefe]) VALUES (3, N'Contabilidad', N'Scranton', N'Oscar Martinez')
INSERT [dbo].[departamentos] ([id_dep], [NombreDep], [Ubicacion], [NombreJefe]) VALUES (4, N'Recursos Humanos', N'Scranton', N'Holly Flax')
INSERT [dbo].[departamentos] ([id_dep], [NombreDep], [Ubicacion], [NombreJefe]) VALUES (5, N'Proveedores', N'Scranton', N'Oreed Bratton')
INSERT [dbo].[departamentos] ([id_dep], [NombreDep], [Ubicacion], [NombreJefe]) VALUES (6, N'Servicio al Cliente', N'Scranton', N'Michael Scott')
INSERT [dbo].[departamentos] ([id_dep], [NombreDep], [Ubicacion], [NombreJefe]) VALUES (7, N'Almacen', N'Scranton', N'Michael Scott')
INSERT [dbo].[departamentos] ([id_dep], [NombreDep], [Ubicacion], [NombreJefe]) VALUES (8, N'Corporativo', N'Nueva York', N'Jan Levinson')
SET IDENTITY_INSERT [dbo].[departamentos] OFF
GO
SET IDENTITY_INSERT [dbo].[empleado] ON 

INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (1, N'Michael', N'Scott', N'555-1234', N'michael.scott@dundermifflin.com', N'Ventas')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (2, N'Jim', N'Halpert', N'555-2345', N'jim.halpert@dundermifflin.com', N'Ventas')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (3, N'Dwight', N'Schrute', N'555-3456', N'dwight.schrute@dundermifflin.com', N'Ventas')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (4, N'Pam', N'Beesly', N'555-4567', N'pam.beesly@dundermifflin.com', N'Recepción')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (5, N'Ryan', N'Howard', N'555-5678', N'ryan.howard@dundermifflin.com', N'Ventas')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (6, N'Angela', N'Martin', N'555-6789', N'angela.martin@dundermifflin.com', N'Contabilidad')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (7, N'Kevin', N'Malone', N'555-7890', N'kevin.malone@dundermifflin.com', N'Contabilidad')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (8, N'Oscar', N'Martinez', N'555-8901', N'oscar.martinez@dundermifflin.com', N'Contabilidad')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (9, N'Toby', N'Flenderson', N'555-9012', N'toby.flenderson@dundermifflin.com', N'Recursos Humanos')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (10, N'Holly', N'Flax', N'555-3456', N'holly.flax@dundermifflin.com', N'Recursos Humanos')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (11, N'Stanley', N'Hudson', N'555-1111', N'stanley.hudson@dundermifflin.com', N'Ventas')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (12, N'Meredith', N'Palmer', N'555-2222', N'meredith.palmer@dundermifflin.com', N'Proveedores')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (13, N'Creed', N'Bratton', N'555-3333', N'creed.bratton@dundermifflin.com', N'Proveedores')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (14, N'Kelly', N'Kapoor', N'555-4444', N'kelly.kapoor@dundermifflin.com', N'Servicio al Cliente')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (15, N'Erin', N'Hannon', N'555-5555', N'erin.hannon@dundermifflin.com', N'Recepción')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (16, N'Phyllis', N'Vance', N'555-6666', N'phyllis.vance@dundermifflin.com', N'Ventas')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (17, N'Andy', N'Bernard', N'555-7777', N'andy.bernard@dundermifflin.com', N'Ventas')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (18, N'Darryl', N'Philbin', N'555-8888', N'darryl.philbin@dundermifflin.com', N'Almacén')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (19, N'Jan', N'Levinson', N'555-5678', N'jan.levinson@dundermifflin.com', N'Corporativo')
INSERT [dbo].[empleado] ([id_emp], [nombre], [apellido], [telefono], [correo], [departamento]) VALUES (20, N'David', N'Wallace', N'555-9999', N'david.wallace@dundermifflin.com', N'Corporativo')
SET IDENTITY_INSERT [dbo].[empleado] OFF
GO
ALTER TABLE [dbo].[empleado_departamento]  WITH CHECK ADD FOREIGN KEY([id_dep])
REFERENCES [dbo].[departamentos] ([id_dep])
GO
ALTER TABLE [dbo].[empleado_departamento]  WITH CHECK ADD FOREIGN KEY([id_emp])
REFERENCES [dbo].[empleado] ([id_emp])
GO
USE [master]
GO
ALTER DATABASE [DBDunder] SET  READ_WRITE 
GO
