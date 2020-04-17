
CREATE TRIGGER TvEmployeeUpdate
ON  dbo.vEmployeeDetails
INSTEAD OF UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	declare @EmployeeId int;
	declare @EmployeeName Varchar(50);
	declare @city Varchar(50);
    select @EmployeeId=EmployeeId,@EmployeeName=EmployeeName,@city=City from inserted;	
	update vEmployeeDetails set EmployeeName=@EmployeeName from inserted where inserted.EmployeeId=@EmployeeId
	update vEmployeeDeatils set City=@city from  inserted where inserted.EmployeeId=@EmployeeId
END
GO
