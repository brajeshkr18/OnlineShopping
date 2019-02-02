USE [master]
GO
/****** Object:  Database [ShoppingOnline]    Script Date: 02-02-2019 13:05:25 ******/
CREATE DATABASE [ShoppingOnline]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ShoppingOnline_Data', FILENAME = N'c:\dzsqls\ShoppingOnline.mdf' , SIZE = 3136KB , MAXSIZE = 15360KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ShoppingOnline_Logs', FILENAME = N'c:\dzsqls\ShoppingOnline.ldf' , SIZE = 1024KB , MAXSIZE = 20480KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ShoppingOnline] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShoppingOnline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShoppingOnline] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShoppingOnline] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShoppingOnline] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShoppingOnline] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShoppingOnline] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShoppingOnline] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ShoppingOnline] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ShoppingOnline] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShoppingOnline] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShoppingOnline] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShoppingOnline] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShoppingOnline] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShoppingOnline] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShoppingOnline] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShoppingOnline] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShoppingOnline] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ShoppingOnline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShoppingOnline] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShoppingOnline] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShoppingOnline] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShoppingOnline] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShoppingOnline] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShoppingOnline] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShoppingOnline] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ShoppingOnline] SET  MULTI_USER 
GO
ALTER DATABASE [ShoppingOnline] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShoppingOnline] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShoppingOnline] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShoppingOnline] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ShoppingOnline]
GO
/****** Object:  User [Sudhanshu_SQLLogin_1]    Script Date: 02-02-2019 13:05:33 ******/
CREATE USER [Sudhanshu_SQLLogin_1] FOR LOGIN [Sudhanshu_SQLLogin_1] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Sudhanshu_SQLLogin_1]
GO
/****** Object:  Schema [Sudhanshu_SQLLogin_1]    Script Date: 02-02-2019 13:05:35 ******/
CREATE SCHEMA [Sudhanshu_SQLLogin_1]
GO
/****** Object:  StoredProcedure [dbo].[USP_MemberShoppingCartDetails]    Script Date: 02-02-2019 13:05:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_MemberShoppingCartDetails] 
(@memberId int) 
as 
begin 
select cr.CartId, p.Price,p.ProductId,p.ProductImage,p.ProductName,c.CategoryName 
from Tbl_Cart cr join Tbl_Product p on p.ProductId=cr.ProductId 
join Tbl_Category c on c.CategoryId=p.CategoryId 
join Tbl_Members m on m.MemberId=cr.MemberId where m.MemberId=@memberId 
and cr.CartStatusId=1 end 



GO
/****** Object:  StoredProcedure [dbo].[USP_Search]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[USP_Search](@searchKey varchar(100)) as begin select p.Description,p.Price,p.ProductId,p.ProductImage, p.ProductName, c.CategoryName from Tbl_Product p  join Tbl_Category c on p.CategoryId=c.CategoryId where p.IsActive=1 and p.IsDelete=0 and c.IsActive=1 and c.IsDelete=0 and (p.ProductName like '%'+@searchKey+'%' or c.CategoryName like '%'+@searchKey+'%') end



GO
/****** Object:  Table [dbo].[Tbl_Cart]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Cart](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[MemberId] [int] NULL,
	[CartStatusId] [int] NULL,
	[AddedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[ShippingDetailId] [int] NULL,
 CONSTRAINT [PK_Tbl_Cart] PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_CartStatus]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_CartStatus](
	[CartStatusId] [int] IDENTITY(1,1) NOT NULL,
	[CartStatus] [varchar](100) NULL,
 CONSTRAINT [PK_Tbl_CartStatus] PRIMARY KEY CLUSTERED 
(
	[CartStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_Category]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_Tbl_ServiceCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_MemberRole]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_MemberRole](
	[MemberRoleId] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_Tbl_MemberRole] PRIMARY KEY CLUSTERED 
(
	[MemberRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Members]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Members](
	[MemberId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[EmailId] [nvarchar](200) NULL,
	[Password] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_Tbl_Member] PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Product]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](100) NULL,
	[CategoryId] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[Description] [varchar](max) NULL,
	[ProductImage] [varchar](50) NULL,
	[Price] [decimal](18, 2) NULL,
	[IsFeatured] [bit] NULL,
 CONSTRAINT [PK_Tbl_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_Roles]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tbl_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ShippingDetails]    Script Date: 02-02-2019 13:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_ShippingDetails](
	[ShippingDetailId] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NULL,
	[AddressLine] [varchar](100) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[ZipCode] [varchar](50) NULL,
	[OrderId] [varchar](50) NULL,
	[AmountPaid] [decimal](18, 0) NULL,
	[PaymentType] [varchar](50) NULL,
 CONSTRAINT [PK_Tbl_ShippingAddress] PRIMARY KEY CLUSTERED 
(
	[ShippingDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Cart] ON 

GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (2, 7, 4, 3, CAST(0x0000A6900005523B AS DateTime), CAST(0x0000A6900005523B AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (3, 6, 4, 3, CAST(0x0000A690014D21E8 AS DateTime), CAST(0x0000A690014D21E8 AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (4, 4, 6, 2, CAST(0x0000A690017B4DD3 AS DateTime), CAST(0x0000A690017CB598 AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (5, 6, 6, 2, CAST(0x0000A690017B5669 AS DateTime), CAST(0x0000A690017CABFB AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (6, 2, 6, 2, CAST(0x0000A690017BABA7 AS DateTime), CAST(0x0000A690017CB23A AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (7, 4, 6, 2, CAST(0x0000A690017BD54E AS DateTime), CAST(0x0000A7CC0007EC09 AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (8, 6, 6, 2, CAST(0x0000A690017C2CBD AS DateTime), CAST(0x0000A7CC0007EA15 AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (9, 2, 6, 2, CAST(0x0000A690017C9BB4 AS DateTime), CAST(0x0000A7CC0007E78F AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1004, 7, 4, 3, CAST(0x0000A697001EF618 AS DateTime), CAST(0x0000A697001EF618 AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1005, 6, 4, 3, CAST(0x0000A697001F005D AS DateTime), CAST(0x0000A697001F005D AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1006, 5, 4, 3, CAST(0x0000A6970170A64F AS DateTime), CAST(0x0000A6970170A64F AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1007, 6, 4, 3, CAST(0x0000A6970170B2C2 AS DateTime), CAST(0x0000A6970170B2C2 AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1008, 5, 3, 3, CAST(0x0000A6CF018B2C52 AS DateTime), CAST(0x0000A6CF018B2C52 AS DateTime), 5)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1009, 4, 5, 2, CAST(0x0000A7BC017F3D60 AS DateTime), CAST(0x0000A7BC017F4DEE AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1010, 3, 5, 3, CAST(0x0000A7BC017F5976 AS DateTime), CAST(0x0000A7BC017F5976 AS DateTime), 4)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1011, 8, 3, 3, CAST(0x0000A7BC0182C9E1 AS DateTime), CAST(0x0000A7BC0182C9E1 AS DateTime), 5)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1012, 10, 3, 3, CAST(0x0000A7C000250EE2 AS DateTime), CAST(0x0000A7C000250EE2 AS DateTime), 5)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1013, 5, 3, 3, CAST(0x0000A7CC00074614 AS DateTime), CAST(0x0000A7CC00074614 AS DateTime), 6)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1014, 6, 6, 3, CAST(0x0000A7CC0007DA1D AS DateTime), CAST(0x0000A7CC0007DA1D AS DateTime), 7)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1015, 5, 3, 1, CAST(0x0000A7D500DF5B31 AS DateTime), CAST(0x0000A7D500DF5B31 AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1016, 12, 3, 1, CAST(0x0000A7D500DFDDC8 AS DateTime), CAST(0x0000A7D500DFDDC8 AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [MemberId], [CartStatusId], [AddedOn], [UpdatedOn], [ShippingDetailId]) VALUES (1017, 5, 8, 3, CAST(0x0000A9E800CE5B06 AS DateTime), CAST(0x0000A9E800CE5B06 AS DateTime), 8)
GO
SET IDENTITY_INSERT [dbo].[Tbl_Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_CartStatus] ON 

GO
INSERT [dbo].[Tbl_CartStatus] ([CartStatusId], [CartStatus]) VALUES (1, N'Added to cart')
GO
INSERT [dbo].[Tbl_CartStatus] ([CartStatusId], [CartStatus]) VALUES (2, N'Removed from cart')
GO
INSERT [dbo].[Tbl_CartStatus] ([CartStatusId], [CartStatus]) VALUES (3, N'Purchased the item')
GO
SET IDENTITY_INSERT [dbo].[Tbl_CartStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Category] ON 

GO
INSERT [dbo].[Tbl_Category] ([CategoryId], [CategoryName], [IsActive], [IsDelete]) VALUES (1, N'Mobile', 1, 0)
GO
INSERT [dbo].[Tbl_Category] ([CategoryId], [CategoryName], [IsActive], [IsDelete]) VALUES (2, N'Laptop', 1, 0)
GO
INSERT [dbo].[Tbl_Category] ([CategoryId], [CategoryName], [IsActive], [IsDelete]) VALUES (3, N'Grocery', 1, 0)
GO
INSERT [dbo].[Tbl_Category] ([CategoryId], [CategoryName], [IsActive], [IsDelete]) VALUES (4, N'Bags', 1, 0)
GO
INSERT [dbo].[Tbl_Category] ([CategoryId], [CategoryName], [IsActive], [IsDelete]) VALUES (5, N'shirts', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Tbl_Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_MemberRole] ON 

GO
INSERT [dbo].[Tbl_MemberRole] ([MemberRoleId], [MemberId], [RoleId]) VALUES (3, 3, 1)
GO
INSERT [dbo].[Tbl_MemberRole] ([MemberRoleId], [MemberId], [RoleId]) VALUES (6, 4, 2)
GO
INSERT [dbo].[Tbl_MemberRole] ([MemberRoleId], [MemberId], [RoleId]) VALUES (7, 5, 2)
GO
INSERT [dbo].[Tbl_MemberRole] ([MemberRoleId], [MemberId], [RoleId]) VALUES (8, 6, 2)
GO
INSERT [dbo].[Tbl_MemberRole] ([MemberRoleId], [MemberId], [RoleId]) VALUES (9, 5, 2)
GO
INSERT [dbo].[Tbl_MemberRole] ([MemberRoleId], [MemberId], [RoleId]) VALUES (10, 6, 2)
GO
INSERT [dbo].[Tbl_MemberRole] ([MemberRoleId], [MemberId], [RoleId]) VALUES (11, 7, 2)
GO
INSERT [dbo].[Tbl_MemberRole] ([MemberRoleId], [MemberId], [RoleId]) VALUES (12, 8, 2)
GO
SET IDENTITY_INSERT [dbo].[Tbl_MemberRole] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Members] ON 

GO
INSERT [dbo].[Tbl_Members] ([MemberId], [FirstName], [LastName], [EmailId], [Password], [IsActive], [IsDelete], [CreatedOn], [ModifiedOn]) VALUES (3, N'Imran', N'Ghani', N'admin@gmail.com', N'vicPOBK6uhdr10zyC7f2sg==', 1, 0, CAST(0x0000A68F01845FC9 AS DateTime), CAST(0x0000A68F01845FC9 AS DateTime))
GO
INSERT [dbo].[Tbl_Members] ([MemberId], [FirstName], [LastName], [EmailId], [Password], [IsActive], [IsDelete], [CreatedOn], [ModifiedOn]) VALUES (4, N'Muhammad', N'Ahmad', N'ahmad@gmail.com', N'vicPOBK6uhdr10zyC7f2sg==', 1, 0, CAST(0x0000A68F01845FC9 AS DateTime), CAST(0x0000A68F01845FC9 AS DateTime))
GO
INSERT [dbo].[Tbl_Members] ([MemberId], [FirstName], [LastName], [EmailId], [Password], [IsActive], [IsDelete], [CreatedOn], [ModifiedOn]) VALUES (5, N'Test', N'Test', N'Test@123.com', N'vicPOBK6uhdr10zyC7f2sg==', 1, 0, CAST(0x0000A7BC017F2B43 AS DateTime), CAST(0x0000A7BC017F2B43 AS DateTime))
GO
INSERT [dbo].[Tbl_Members] ([MemberId], [FirstName], [LastName], [EmailId], [Password], [IsActive], [IsDelete], [CreatedOn], [ModifiedOn]) VALUES (6, N'VINAY', N'KUMAR', N'VINAY@123.COM', N'vicPOBK6uhdr10zyC7f2sg==', 1, 0, CAST(0x0000A7CC0007CAE1 AS DateTime), CAST(0x0000A7CC0007CAE1 AS DateTime))
GO
INSERT [dbo].[Tbl_Members] ([MemberId], [FirstName], [LastName], [EmailId], [Password], [IsActive], [IsDelete], [CreatedOn], [ModifiedOn]) VALUES (7, N'Test@123.com', N'Test@123.com', N'Test@123.com', N'vicPOBK6uhdr10zyC7f2sg==', 1, 0, CAST(0x0000A7D500DE88E5 AS DateTime), CAST(0x0000A7D500DE88E5 AS DateTime))
GO
INSERT [dbo].[Tbl_Members] ([MemberId], [FirstName], [LastName], [EmailId], [Password], [IsActive], [IsDelete], [CreatedOn], [ModifiedOn]) VALUES (8, N'hello@123.com', N'hello@123.com', N'hello@123.com', N'CgE8GXJmBaYABF63sQKlRQ==', 1, 0, CAST(0x0000A9E800CE1C23 AS DateTime), CAST(0x0000A9E800CE1C23 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Tbl_Members] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Product] ON 

GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (1, N'Samsung Galexy', 1, NULL, NULL, NULL, NULL, N'<p><strong>aSasAS</strong></p>', N'Penguins.jpg', CAST(76.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (2, N'Samsung Galexy j4', 1, 1, 0, CAST(0xB83B0B00 AS Date), CAST(0x1B3D0B00 AS Date), N'<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>', N'samsung-galaxy-on5-spotted-1.jpg', CAST(656.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (3, N'Dell Inspiron', 2, 1, 0, CAST(0xB83B0B00 AS Date), CAST(0xB83B0B00 AS Date), N'<p>Dell Inspiron</p>', N'download (1).jpg', CAST(350.00 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (4, N'Samsung Galexy j5', 1, 1, 0, CAST(0xB83B0B00 AS Date), CAST(0xB83B0B00 AS Date), N'<p><span style="text-decoration: underline;"><strong><span style="text-decoration: underline;">Samsung Galexy j5</span></strong></span></p>', N'download.jpg', CAST(88.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (5, N'Dell Inspiron N5010', 2, 1, 0, CAST(0xEA3B0B00 AS Date), CAST(0xEA3B0B00 AS Date), N'<p><strong>Nice Mobile</strong></p>', N'3_download (1).jpg', CAST(90000.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (6, N'Nokia', 1, 1, 0, CAST(0xEA3B0B00 AS Date), CAST(0xEA3B0B00 AS Date), N'<p>Nice Mobile</p>', N'images.jpg', CAST(850.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (7, N'HTC', 1, 1, 0, CAST(0xEA3B0B00 AS Date), CAST(0xEA3B0B00 AS Date), N'<p>HTC Mobile</p>', N'Htc-Desire-516-white--SDL232582179-1-71d4a.jpg', CAST(7600.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (8, N'Orange', 3, 1, 0, CAST(0x173D0B00 AS Date), CAST(0x173D0B00 AS Date), N'<p>Just to let you know that in case if in your network someone is looking for Android app or iOS app, you can let me know. My team is ready to take&nbsp;</p>', N'cofee3.jpg', CAST(20.10 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (9, N'Bag 1', 4, 1, 0, CAST(0x1B3D0B00 AS Date), CAST(0x1B3D0B00 AS Date), N'<p>Bag 1</p>
<p>Bag 1</p>
<p>Bag 1</p>
<p>Bag 1</p>
<p>Bag 1</p>
<p>Bag 1</p>
<p>Bag 1</p>
<p>Bag 1</p>
<p>Bag 1</p>', N'pi4.jpg', CAST(100.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (10, N'bag2', 4, 1, 0, CAST(0x1B3D0B00 AS Date), CAST(0x1B3D0B00 AS Date), N'<p>F:\MVC\GroceryStore\TalaCall\TalaCall\TelaCall\Asset\images</p>
<p>F:\MVC\GroceryStore\TalaCall\TalaCall\TelaCall\Asset\images</p>
<p>F:\MVC\GroceryStore\TalaCall\TalaCall\TelaCall\Asset\images</p>
<p>F:\MVC\GroceryStore\TalaCall\TalaCall\TelaCall\Asset\images</p>
<p>F:\MVC\GroceryStore\TalaCall\TalaCall\TelaCall\Asset\images</p>', N'pi4.jpg', CAST(200.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (11, N'FRUIT', 3, 1, 0, CAST(0x273D0B00 AS Date), CAST(0x273D0B00 AS Date), N'<p>sdcvadsmvndsfklvdsfl;b dfgdfgjkefog;l</p>', N'pic2.jpg', CAST(30.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[Tbl_Product] ([ProductId], [ProductName], [CategoryId], [IsActive], [IsDelete], [CreatedDate], [ModifiedDate], [Description], [ProductImage], [Price], [IsFeatured]) VALUES (12, N'full shirt', 5, 1, 0, CAST(0x303D0B00 AS Date), CAST(0x303D0B00 AS Date), N'<p>full shirt full shirt full shirt</p>', N'pic-brajeshkr.jpg', CAST(500.00 AS Decimal(18, 2)), 1)
GO
SET IDENTITY_INSERT [dbo].[Tbl_Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Roles] ON 

GO
INSERT [dbo].[Tbl_Roles] ([RoleId], [RoleName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Tbl_Roles] ([RoleId], [RoleName]) VALUES (2, N'User')
GO
SET IDENTITY_INSERT [dbo].[Tbl_Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_ShippingDetails] ON 

GO
INSERT [dbo].[Tbl_ShippingDetails] ([ShippingDetailId], [MemberId], [AddressLine], [City], [State], [Country], [ZipCode], [OrderId], [AmountPaid], [PaymentType]) VALUES (1, 4, N'sdsad', N'sdasd', N'dwfef', N'ewdwd', N'wqewqe', N'30b8dcac-4e3e-4596-b171-ab8be74868c1', CAST(8450 AS Decimal(18, 0)), N'Pay Using Debit/Credit Card')
GO
INSERT [dbo].[Tbl_ShippingDetails] ([ShippingDetailId], [MemberId], [AddressLine], [City], [State], [Country], [ZipCode], [OrderId], [AmountPaid], [PaymentType]) VALUES (2, 4, N'Karol Bagh', N'Delhi', N'New Delhi', N'India', N'110009', N'428f09f8-141b-49b9-be38-77f5a288ea73', CAST(8450 AS Decimal(18, 0)), N'Pay Using Net banking')
GO
INSERT [dbo].[Tbl_ShippingDetails] ([ShippingDetailId], [MemberId], [AddressLine], [City], [State], [Country], [ZipCode], [OrderId], [AmountPaid], [PaymentType]) VALUES (3, 4, N'Karol Bagh', N'Delhi', N'New Delhi', N'India', N'110006', N'314a9d28-550d-443c-ba6b-13dc905fabaf', CAST(90850 AS Decimal(18, 0)), N'Cash On Delivery')
GO
INSERT [dbo].[Tbl_ShippingDetails] ([ShippingDetailId], [MemberId], [AddressLine], [City], [State], [Country], [ZipCode], [OrderId], [AmountPaid], [PaymentType]) VALUES (4, 5, N'test', N'test', N'test', N'test', N'563256', N'46be9e5a-a1b1-427d-9736-9638f30d7e85', CAST(350 AS Decimal(18, 0)), N'Cash On Delivery')
GO
INSERT [dbo].[Tbl_ShippingDetails] ([ShippingDetailId], [MemberId], [AddressLine], [City], [State], [Country], [ZipCode], [OrderId], [AmountPaid], [PaymentType]) VALUES (5, 3, N'casc', N'cacaascas', N'asca', N'sacas', N'qwdwq', N'741f7044-0e43-4728-aa50-34e99fd40a74', CAST(90220 AS Decimal(18, 0)), N'Pay Using Net banking')
GO
INSERT [dbo].[Tbl_ShippingDetails] ([ShippingDetailId], [MemberId], [AddressLine], [City], [State], [Country], [ZipCode], [OrderId], [AmountPaid], [PaymentType]) VALUES (6, 3, N'test', N'zcsdx', N'vfdv', N'cfEDF', N'522120', N'0acd6463-55e5-4ebc-ba4e-e2d084ab3274', CAST(90000 AS Decimal(18, 0)), N'Cash On Delivery')
GO
INSERT [dbo].[Tbl_ShippingDetails] ([ShippingDetailId], [MemberId], [AddressLine], [City], [State], [Country], [ZipCode], [OrderId], [AmountPaid], [PaymentType]) VALUES (7, 6, N'VIN', N'V', N'VINAY@123.COM', N'VINAY@123.COM', N'859653', N'057d5d2c-d074-49e6-89bf-2abac08ea706', CAST(850 AS Decimal(18, 0)), N'Pay Using Debit/Credit Card')
GO
INSERT [dbo].[Tbl_ShippingDetails] ([ShippingDetailId], [MemberId], [AddressLine], [City], [State], [Country], [ZipCode], [OrderId], [AmountPaid], [PaymentType]) VALUES (8, 8, N'Mohan Nagar', N'Ghjaziaabad', N'UP', N'India', N'201007', N'beb10549-5957-426c-beef-447ffd636c1c', CAST(90000 AS Decimal(18, 0)), N'Cash On Delivery')
GO
SET IDENTITY_INSERT [dbo].[Tbl_ShippingDetails] OFF
GO
ALTER TABLE [dbo].[Tbl_Cart]  WITH CHECK ADD FOREIGN KEY([CartStatusId])
REFERENCES [dbo].[Tbl_CartStatus] ([CartStatusId])
GO
ALTER TABLE [dbo].[Tbl_Cart]  WITH CHECK ADD  CONSTRAINT [FK__Tbl_Cart__Produc__1FCDBCEB] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Tbl_Product] ([ProductId])
GO
ALTER TABLE [dbo].[Tbl_Cart] CHECK CONSTRAINT [FK__Tbl_Cart__Produc__1FCDBCEB]
GO
ALTER TABLE [dbo].[Tbl_MemberRole]  WITH CHECK ADD  CONSTRAINT [fk_Tbl_Roles_Tbl_MemberRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Tbl_Roles] ([RoleId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_MemberRole] CHECK CONSTRAINT [fk_Tbl_Roles_Tbl_MemberRole]
GO
ALTER TABLE [dbo].[Tbl_Product]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Category_Tbl_Product] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Tbl_Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Tbl_Product] CHECK CONSTRAINT [FK_Tbl_Category_Tbl_Product]
GO
USE [master]
GO
ALTER DATABASE [ShoppingOnline] SET  READ_WRITE 
GO
