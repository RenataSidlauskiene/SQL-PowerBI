-- Cleaned DateTable

SELECT 
    [DateKey],
    [FullDateAlternateKey] as Date,
     -- ,[DayNumberOfWeek]
    [EnglishDayNameOfWeek] as Day,
     -- ,[SpanishDayNameOfWeek]
     -- ,[FrenchDayNameOfWeek]
     -- ,[DayNumberOfMonth]
     -- ,[DayNumberOfYear]
    [WeekNumberOfYear] as WeekNr,
    [EnglishMonthName] as Month,
	Left([EnglishMonthName], 3) as MonthShort,
     -- ,[SpanishMonthName]
    --  ,[FrenchMonthName]
    [MonthNumberOfYear] as MonthNo,
    [CalendarQuarter] as Quarter, 
    [CalendarYear] as Year
     -- ,[CalendarSemester]
   --   ,[FiscalQuarter]
    --  ,[FiscalYear]
      --,[FiscalSemester]
FROM 
    [AdventureWorksDW].[dbo].[DimDate]
;
