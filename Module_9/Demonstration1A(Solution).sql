-- Step 1 - Switch to the AdventureWorks database

USE AdventureWorks;
GO

-- Step 2 - Execute the sp_configure system stored procedure

EXEC sp_configure;
GO

-- Step 3 - Execute the xp_dirtree extended system stored procedure

EXEC xp_dirtree "F:\Radixweb\C-Sharp\Microsoft Learning\SQL\Module_9\Demo",0,1;
GO