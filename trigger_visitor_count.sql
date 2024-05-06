CREATE TRIGGER trgAfterUpdateRecord
ON Record
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @newCount INT;

    SELECT @newCount = COUNT(*) FROM Record;

    -- Send new visitor count to SignalR Hub
    EXEC SendVisitorCount @newCount;
END;