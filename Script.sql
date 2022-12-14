USE [master]
GO
/****** Object:  Database [PortalWeb]    Script Date: 18/8/2022 13:04:51 ******/
CREATE DATABASE [PortalWeb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PortalWeb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PortalWeb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PortalWeb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PortalWeb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PortalWeb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PortalWeb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PortalWeb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PortalWeb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PortalWeb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PortalWeb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PortalWeb] SET ARITHABORT OFF 
GO
ALTER DATABASE [PortalWeb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PortalWeb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PortalWeb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PortalWeb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PortalWeb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PortalWeb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PortalWeb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PortalWeb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PortalWeb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PortalWeb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PortalWeb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PortalWeb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PortalWeb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PortalWeb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PortalWeb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PortalWeb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PortalWeb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PortalWeb] SET RECOVERY FULL 
GO
ALTER DATABASE [PortalWeb] SET  MULTI_USER 
GO
ALTER DATABASE [PortalWeb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PortalWeb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PortalWeb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PortalWeb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PortalWeb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PortalWeb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PortalWeb', N'ON'
GO
ALTER DATABASE [PortalWeb] SET QUERY_STORE = OFF
GO
USE [PortalWeb]
GO
/****** Object:  Table [dbo].[Permisos]    Script Date: 18/8/2022 13:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permisos](
	[Id_Permiso] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Permiso] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 18/8/2022 13:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id_Rol] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Rol] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles_Permisos]    Script Date: 18/8/2022 13:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles_Permisos](
	[Id_rol_permiso] [int] IDENTITY(1,1) NOT NULL,
	[Id_Rol] [int] NULL,
	[Id_Permiso] [int] NULL,
	[Estado] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 18/8/2022 13:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Edad] [int] NULL,
	[Usuario] [varchar](50) NULL,
	[Clave] [varchar](50) NULL,
	[Id_rol] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_datos]    Script Date: 18/8/2022 13:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_datos]
as begin
select * from Usuarios
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 18/8/2022 13:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Login]
@Usuario varchar(50),
@Clave varchar(max),
@Patron varchar(50)
as begin
select * from Usuarios where Usuario=@Usuario and Convert(varchar(50), Decryptbypassphrase(@Patron, Clave))=@Clave
end
GO
/****** Object:  StoredProcedure [dbo].[sp_permisos]    Script Date: 18/8/2022 13:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_permisos]
@Id_Rol int
as begin
select Nombre_Permiso, Estado from Roles_Permisos inner join Permisos on Permisos.Id_Permiso=Roles_Permisos.Id_Permiso where Id_Rol=@Id_Rol
end
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar]    Script Date: 18/8/2022 13:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_registrar]
@Nombre varchar(50),
@Edad int,
@Usuario varchar(50),
@Clave varchar(max),
@Id_Rol int=2,
@Patron varchar(50)
as begin
insert into Usuarios values(@Nombre, @Edad, @Usuario, ENCRYPTBYPASSPHRASE(@Patron, @Clave), @Id_Rol)
end
GO
USE [master]
GO
ALTER DATABASE [PortalWeb] SET  READ_WRITE 
GO
