CREATE TRIGGER trgAfterUpdateRecord
ON Record
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @newCount INT;

    SELECT @newCount = COUNT(*) FROM Record;

    -- Send new visitor count to SignalR Hub
    EXEC sp_SendVisitorCount @newCount;
END;