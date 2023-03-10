USE [master]
GO
/****** Object:  Database [Shop]    Script Date: 1/29/2023 7:47:52 PM ******/
CREATE DATABASE [Shop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Shop', FILENAME = N'D:\SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Shop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Shop_log', FILENAME = N'D:\SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Shop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Shop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [Shop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Shop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Shop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Shop] SET  MULTI_USER 
GO
ALTER DATABASE [Shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Shop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Shop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Shop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Shop', N'ON'
GO
ALTER DATABASE [Shop] SET QUERY_STORE = ON
GO
ALTER DATABASE [Shop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Shop]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 1/29/2023 7:47:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](15) NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 1/29/2023 7:47:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[RatingId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 1/29/2023 7:47:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Points] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (1, N'Beverages', N'Soft drinks, coffees, teas, beers, and ales')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (2, N'Condiments', N'Sweet and savory sauces, relishes, spreads, and seasonings')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (3, N'Confections', N'Desserts, candies, and sweet breads')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (4, N'Dairy Products', N'Cheeses')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (5, N'Grains/Cereals', N'Breads, crackers, pasta, and cereal')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (6, N'Meat/Poultry', N'Prepared meats')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (7, N'Produce', N'Dried fruit and bean curd')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (8, N'Seafood', N'Seaweed and fish')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (1, N'Chai', 1, 18.0000, 39, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (2, N'Chang', 1, 19.0000, 17, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (3, N'Aniseed Syrup', 2, 10.0000, 13, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (4, N'Chef Anton''s Cajun Seasoning', 2, 22.0000, 53, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (5, N'Chef Anton''s Gumbo Mix', 2, 21.3500, 0, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (6, N'Grandma''s Boysenberry Spread', 2, 25.0000, 120, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (7, N'Uncle Bob''s Organic Dried Pears', 7, 30.0000, 15, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (8, N'Northwoods Cranberry Sauce', 2, 40.0000, 6, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (9, N'Mishi Kobe Niku', 6, 97.0000, 29, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (10, N'Ikura', 8, 31.0000, 31, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (11, N'Queso Cabrales', 4, 21.0000, 22, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (12, N'Queso Manchego La Pastora', 4, 38.0000, 86, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (13, N'Konbu', 8, 6.0000, 24, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (14, N'Tofu', 7, 23.2500, 35, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (15, N'Genen Shouyu', 2, 15.5000, 39, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (16, N'Pavlova', 3, 17.4500, 29, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (17, N'Alice Mutton', 6, 39.0000, 0, 4)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (18, N'Carnarvon Tigers', 8, 62.5000, 42, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (19, N'Teatime Chocolate Biscuits', 3, 9.2000, 25, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (20, N'Sir Rodney''s Marmalade', 3, 81.0000, 40, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (21, N'Sir Rodney''s Scones', 3, 10.0000, 3, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (22, N'Gustaf''s Knäckebröd', 5, 21.0000, 104, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (23, N'Tunnbröd', 5, 9.0000, 61, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (24, N'Guaraná Fantástica', 1, 4.5000, 20, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (25, N'NuNuCa Nuß-Nougat-Creme', 3, 14.0000, 76, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (26, N'Gumbär Gummibärchen', 3, 31.2300, 15, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (27, N'Schoggi Schokolade', 3, 43.9000, 49, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (28, N'Rössle Sauerkraut', 7, 45.6000, 26, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (29, N'Thüringer Rostbratwurst', 6, 123.7900, 0, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (30, N'Nord-Ost Matjeshering', 8, 25.8900, 10, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (31, N'Gorgonzola Telino', 4, 12.5000, 0, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (32, N'Mascarpone Fabioli', 4, 32.0000, 9, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (33, N'Geitost', 4, 2.5000, 112, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (34, N'Sasquatch Ale', 1, 14.0000, 111, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (35, N'Steeleye Stout', 1, 18.0000, 20, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (36, N'Inlagd Sill', 8, 19.0000, 112, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (37, N'Gravad lax', 8, 26.0000, 11, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (38, N'Côte de Blaye', 1, 263.5000, 17, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (39, N'Chartreuse verte', 1, 18.0000, 69, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (40, N'Boston Crab Meat', 8, 18.4000, 123, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (41, N'Jack''s New England Clam Chowder', 8, 9.6500, 85, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (42, N'Singaporean Hokkien Fried Mee', 5, 14.0000, 26, 4)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (43, N'Ipoh Coffee', 1, 46.0000, 17, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (44, N'Gula Malacca', 2, 19.4500, 27, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (45, N'Rogede sild', 8, 9.5000, 5, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (46, N'Spegesild', 8, 12.0000, 95, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (47, N'Zaanse koeken', 3, 9.5000, 36, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (48, N'Chocolade', 3, 12.7500, 15, 4)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (49, N'Maxilaku', 3, 20.0000, 10, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (50, N'Valkoinen suklaa', 3, 16.2500, 65, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (51, N'Manjimup Dried Apples', 7, 53.0000, 20, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (52, N'Filo Mix', 5, 7.0000, 38, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (53, N'Perth Pasties', 6, 32.8000, 0, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (54, N'Tourtière', 6, 7.4500, 21, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (55, N'Pâté chinois', 6, 24.0000, 115, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (56, N'Gnocchi di nonna Alice', 5, 38.0000, 21, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (57, N'Ravioli Angelo', 5, 19.5000, 36, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (58, N'Escargots de Bourgogne', 8, 13.2500, 62, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (59, N'Raclette Courdavault', 4, 55.0000, 79, 4)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (60, N'Camembert Pierrot', 4, 34.0000, 19, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (61, N'Sirop d''érable', 2, 28.5000, 113, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (62, N'Tarte au sucre', 3, 49.3000, 17, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (63, N'Vegie-spread', 2, 43.9000, 24, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (64, N'Wimmers gute Semmelknödel', 5, 33.2500, 22, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (65, N'Louisiana Fiery Hot Pepper Sauce', 2, 21.0500, 76, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (66, N'Louisiana Hot Spiced Okra', 2, 17.0000, 4, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (67, N'Laughing Lumberjack Lager', 1, 14.0000, 52, 1)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (68, N'Scottish Longbreads', 3, 12.5000, 6, 4)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (69, N'Gudbrandsdalsost', 4, 36.0000, 26, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (70, N'Outback Lager', 1, 15.0000, 15, 4)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (71, N'Flotemysost', 4, 21.5000, 26, 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (72, N'Mozzarella di Giovanni', 4, 34.8000, 14, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (73, N'Röd Kaviar', 8, 15.0000, 101, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (74, N'Longlife Tofu', 7, 10.0000, 4, 5)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (75, N'Rhönbräu Klosterbier', 1, 7.7500, 125, 6)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (76, N'Lakkalikööri', 1, 18.0000, 57, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (77, N'Original Frankfurter grüne Soße', 2, 13.0000, 32, 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Price], [Quantity], [RatingId]) VALUES (78, N'Kurasan', 5, 1.5000, 21, 5)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Rating] ON 

INSERT [dbo].[Rating] ([Id], [Points]) VALUES (1, 0)
INSERT [dbo].[Rating] ([Id], [Points]) VALUES (2, 1)
INSERT [dbo].[Rating] ([Id], [Points]) VALUES (3, 2)
INSERT [dbo].[Rating] ([Id], [Points]) VALUES (4, 3)
INSERT [dbo].[Rating] ([Id], [Points]) VALUES (5, 4)
INSERT [dbo].[Rating] ([Id], [Points]) VALUES (6, 5)
SET IDENTITY_INSERT [dbo].[Rating] OFF
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_CategoryId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_RatingId] FOREIGN KEY([RatingId])
REFERENCES [dbo].[Rating] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_RatingId]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD CHECK  (([Points]>=(0) AND [Points]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [Shop] SET  READ_WRITE 
GO
