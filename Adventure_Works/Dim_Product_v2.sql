-- Cleaned products table

SELECT 
     p.[ProductKey],
     p.[ProductAlternateKey] as [Product Item Code],
     -- ,[ProductSubcategoryKey]
     -- ,[WeightUnitMeasureCode]
     -- ,[SizeUnitMeasureCode]
     p.[EnglishProductName] as [Product Name],
	 ps.[EnglishProductSubcategoryName] as [Sub Category], -- joined in from Subcategory table
	 pc.[EnglishProductCategoryName] as [Product Category], -- joined in from Category table 
     -- ,[SpanishProductName]
     -- ,[FrenchProductName]
     -- ,[StandardCost]
     -- ,[FinishedGoodsFlag]
     p.[Color] as [Product Color],
     -- ,[SafetyStockLevel]
     -- ,[ReorderPoint]
     -- ,[ListPrice]
     p.[Size] as [Product Size],
     -- ,[SizeRange]
     -- ,[Weight]
     -- ,[DaysToManufacture]
     p.[ProductLine] as [Product line],
     -- ,[DealerPrice]
     -- ,[Class]
     -- ,[Style]
     p.[ModelName] as [Product Model Name],
     -- ,[LargePhoto]
     p.[EnglishDescription] as [Product Description],
     -- ,[FrenchDescription]
     -- ,[ChineseDescription]
     -- ,[ArabicDescription]
     -- ,[HebrewDescription]
     -- ,[ThaiDescription]
     -- ,[GermanDescription]
     -- ,[JapaneseDescription]
     -- ,[TurkishDescription]
     -- ,[StartDate]
     -- ,[EndDate]
ISNULL (p.[Status], 'Outdated') as [Product Status]
FROM
     [AdventureWorksDW].[dbo].[DimProduct] as p
	 Left Join [AdventureWorksDW].[dbo].[DimProductSubcategory] as ps on ps.ProductSubcategoryKey = p.ProductSubcategoryKey
	 Left Join [AdventureWorksDW].[dbo].[DimProductCategory] as pc on ps.ProductCategoryKey = pc.ProductCategoryKey
Order by 
     p.ProductKey asc;
