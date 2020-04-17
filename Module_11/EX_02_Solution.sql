USE AdventureWorks
GO

CREATE TABLE Production.ProductAudit(
ProductID int NOT NULL,
UpdateTime datetime2(7) NOT NULL,
ModifyingUser nvarchar(100) NOT NULL,
OriginalListPrice money NULL,
NewListPrice money NULL
)

GO

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


SELECT * FROM Marketing.CampaignBalance;
GO


EXEC Marketing.MoveCampaignBalance 2,3,20100;
GO

EXEC Marketing.MoveCampaignBalance 5,3,2020;
GO

SELECT * FROM Marketing.CampaignAudit;
GO 

DELETE FROM Marketing.CampaignAudit;
GO