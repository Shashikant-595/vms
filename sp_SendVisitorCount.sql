CREATE PROCEDURE sp_SendVisitorCount
@newCount INT
AS
BEGIN
    DECLARE @hubContext varbinary(max);
    EXEC sp_apiappcontext_get_singleton @name = 'Microsoft.AspNetCore.SignalR.HubLifetimeManager', @result = @hubContext OUTPUT;

    IF @hubContext IS NOT NULL
    BEGIN
        DECLARE @hub NVARCHAR(4000);
        SELECT TOP 1 @hub = h.Hub FROM sys.hubs h
        JOIN sys.assemblies a ON h.assembly_id = a.assembly_id;

        DECLARE @instance varbinary(max);
        EXEC sp_apiappcontext_cast_instance @instance = @hubContext, @destination_type = @hub;

        EXEC sp_execute_sql @instance, N'EXEC dbo.ChatHub.SendVisitorCount @newCount', N'@newCount int', @newCount;
    END
END;