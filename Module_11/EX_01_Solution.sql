USE MarketDev
GO

ALTER TRIGGER Marketing.TR_CampaignBalance_Update
ON Marketing.CampaignBalance
AFTER UPDATE
AS BEGIN
SET NOCOUNT ON;

INSERT Marketing.CampaignAudit 
(AuditTime, ModifyingUser, RemainingBalance)
SELECT SYSDATETIME(),
ORIGINAL_LOGIN(),
inserted.RemainingBalance
FROM deleted
INNER JOIN inserted
ON deleted.CampaignID = inserted.CampaignID 
WHERE ABS(deleted.RemainingBalance  - inserted.RemainingBalance) > 10000;
END;
GO


UPDATE Production.Product
SET ListPrice=4000
WHERE ProductID BETWEEN 600 and 603;
GO



SELECT * FROM Production.ProductAudit;
GO 
