-- Cleaned Customer Table

use AdventureWorksDW;

SELECT 
     [CustomerKey] as [Customer Key],
     -- ,[GeographyKey]
     -- ,[CustomerAlternateKey]
     -- ,[Title]
     [FirstName] as [Fist Name],
     -- ,[MiddleName]
     [LastName] as [Last Name],
	 [FirstName] + ' ' +[LastName] as [Full Name], 
     -- ,[NameStyle]
     -- ,[BirthDate]
     -- ,[MaritalStatus]
     -- ,[Suffix]
Case [Gender] when 'M' then 'Male' when 'F' then 'Female' END as Gender,
     -- ,[EmailAddress]
     --,[YearlyIncome]
     -- ,[TotalChildren]
     -- ,[NumberChildrenAtHome]
     -- ,[EnglishEducation]
     -- ,[SpanishEducation]
     -- ,[FrenchEducation]
     -- ,[EnglishOccupation]
     -- ,[SpanishOccupation]
     -- ,[FrenchOccupation]
     -- ,[HouseOwnerFlag]
     -- ,[NumberCarsOwned]
     -- ,[AddressLine1]
     -- ,[AddressLine2]
     -- ,[Phone]
    [DateFirstPurchase] as [Date First Purchase],
	City as [Customer City]
     -- ,[CommuteDistance]
FROM 
    [dbo].[DimCustomer]
	Left Join dbo.DimGeography on dbo.DimGeography.GeographyKey = dbo.DimCustomer.GeographyKey
Order by 
    CustomerKey asc;
