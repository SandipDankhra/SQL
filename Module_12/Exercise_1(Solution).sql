use InternetSales

alter database InternetSales
add filegroup SalesFG contains
MEMORY_OPTIMIZED_DATA
Go

ALTER DATABASE InternetSales   
ADD FILE(  
    NAME =N'Data',  
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Data.ndf' 
)  
TO FILEGROUP SalesFG;  


CREATE TABLE dbo.ShoppingCart
(SessionID INT NOT NULL,
TimeAdded DATETIME NOT NULL,
CustomerKey INT NOT NULL,
ProductKey INT NOT NULL,
Quantity INT NOT NULL
PRIMARY KEY NONCLUSTERED (SessionID, ProductKey)) 
WITH  (MEMORY_OPTIMIZED = ON,  DURABILITY = SCHEMA_AND_DATA);


INSERT INTO ShoppingCart(SessionID,TimeAdded,CustomerKey,ProductKey,Quantity)VALUES (1,GETDATE(),2,3,1);
INSERT INTO ShoppingCart(SessionID,TimeAdded,CustomerKey,ProductKey,Quantity)VALUES (2,GETDATE(),2,4,3);
