CREATE TRIGGER Production.TR_ProductListPrice_Update
ON Production.Product
AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;
	INSERT Production.ProductAudit(ProductID, UpdateTime, ModifyingUser, OriginalListPrice,NewListPrice)
	SELECT Inserted.ProductID,SYSDATETIME(),ORIGINAL_LOGIN(),deleted.ListPrice, inserted.ListPrice
	FROM deleted
	INNER JOIN inserted
	ON deleted.ProductID = inserted.ProductID
	WHERE deleted.ListPrice > 1000 OR inserted.ListPrice > 1000;
END;
GO
-- ===========================
UPDATE Production.Product
SET ListPrice=5230.00
WHERE ProductID BETWEEN 859 and 863;
GO
SELECT * FROM Production.ProductAudit
GO


-- ===========Store Procedure===============

CREATE PROCEDURE Production.GetAvailableModelsAsXML
AS BEGIN
  SELECT p.ProductID,
         p.Name as ProductName,
         p.ListPrice,
         p.Color,
         p.SellStartDate, 
         pm.ProductModelID,
         pm.Name as ProductModel
  FROM Production.Product AS p
  INNER JOIN Production.ProductModel AS pm
  ON p.ProductModelID = pm.ProductModelID 
  WHERE p.SellStartDate IS NOT NULL
  AND p.SellEndDate IS NULL
  ORDER BY p.SellStartDate, p.Name DESC
  FOR XML RAW('AvailableModel'), ROOT('AvailableModels');
END;
GO

EXEC Production.GetAvailableModelsAsXML;
GO

CREATE PROCEDURE Sales.UpdateSalesTerritoriesByXML (@SalespersonMods as xml)
AS BEGIN
	UPDATE  Sales.SalesPerson
	SET TerritoryID = updates.SalesTerritoryID
	FROM    Sales.SalesPerson sp
	INNER JOIN (
		SELECT
			SalespersonMod.value('@BusinessEntityID','int') AS BusinessEntityID 
			,SalespersonMod.value('(Mods/Mod/@SalesTerritoryID)[1]','int') AS SalesTerritoryID
		FROM @SalespersonMods.nodes('/SalespersonMods/SalespersonMod') as SalespersonMods(SalespersonMod)
	) AS updates
	ON sp.BusinessEntityID = updates.BusinessEntityID;
END;
GO

DECLARE @xmlTestString nvarchar(2000);
SET @xmlTestString ='
<SalespersonMods>
     <SalespersonMod BusinessEntityID="274">
           <Mods>
               <Mod SalesTerritoryID="3"/>
           </Mods>
     </SalespersonMod>
      <SalespersonMod BusinessEntityID="278">
           <Mods>
                <Mod SalesTerritoryID="4"/>
           </Mods>
     </SalespersonMod>
</SalespersonMods>
)';
DECLARE @testDoc xml;
SET @testDoc = @xmlTestString;

EXEC Sales.UpdateSalesTerritoriesByXML @testDoc;
GO
