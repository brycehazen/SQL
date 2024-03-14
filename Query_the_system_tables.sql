-- Selects foreign key relationships where 'PHONES' table is involved
SELECT
    -- Retrieves name of the table containing the foreign key
    OBJECT_NAME(f.parent_object_id) AS TableName,
    -- Retrieves name of the column in the table that contains the foreign key
    COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ColumnName,
    -- Retrieves name of the referenced table in the foreign key relationship
    OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName,
    -- Retrieves name of the referenced column in the foreign key relationship
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS ReferenceColumnName
FROM
    -- Specifies the sys.foreign_keys system view as the data source for foreign keys
    sys.foreign_keys AS f
INNER JOIN
    -- Joins with sys.foreign_key_columns to get detailed column information
    sys.foreign_key_columns AS fc 
    ON f.OBJECT_ID = fc.constraint_object_id
-- Filter condition to fetch foreign key relationships involving 'PHONES' table
WHERE
    -- Includes relationships where 'PHONES' is the table containing the foreign key
    OBJECT_NAME(f.parent_object_id) = 'PHONES'
    OR 
    -- Includes relationships where 'PHONES' is the referenced table
    OBJECT_NAME(f.referenced_object_id) = 'PHONES'
