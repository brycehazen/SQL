-- This Query looks through a database for field when you do not know the column and table
-- Switch to the desired database
USE [BRT-10059058];

-- Declare variables and a temporary table to store results
DECLARE @SearchStr nvarchar(100) = 'A1101002287' --This is what we are looking for
DECLARE @Results TABLE(ColumnName nvarchar(370), ColumnValue nvarchar(3630))
DECLARE @TableName nvarchar(256), @ColumnName nvarchar(128), @SearchStr2 nvarchar(110)

-- Initialize the table name and prepare the search string
SET @TableName = ''
SET @SearchStr2 = QUOTENAME('%' + @SearchStr + '%','''')

-- Start loop through tables
WHILE @TableName IS NOT NULL
BEGIN
    SET @ColumnName = ''
    
    -- Fetch the next table
    SET @TableName = 
    (
        SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_TYPE = 'BASE TABLE'
            AND QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @TableName
            AND OBJECTPROPERTY(OBJECT_ID(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)), 'IsMSShipped') = 0
    )

    -- Loop through the columns of the current table
    WHILE (@TableName IS NOT NULL) AND (@ColumnName IS NOT NULL)
    BEGIN
        -- Fetch the next column
        SET @ColumnName =
        (
            SELECT MIN(QUOTENAME(COLUMN_NAME))
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = PARSENAME(@TableName, 2)
                AND TABLE_NAME = PARSENAME(@TableName, 1)
                AND DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar', 'text', 'ntext') -- Focus on string data types
                AND QUOTENAME(COLUMN_NAME) > @ColumnName
        )

        -- If a column is found, perform the search
        IF @ColumnName IS NOT NULL
        BEGIN
            INSERT INTO @Results
            EXEC
            (
                'SELECT ''' + @TableName + '.' + @ColumnName + ''', LEFT(' + @ColumnName + ', 3630) 
                FROM ' + @TableName + ' (NOLOCK) ' + -- Use NOLOCK for performance, but be cautious in prod environments
                ' WHERE ' + @ColumnName + ' LIKE ' + @SearchStr2
            )
        END
    END
END

-- Display the results
SELECT ColumnName, ColumnValue FROM @Results
