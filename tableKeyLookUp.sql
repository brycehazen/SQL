SELECT 
    fk.name AS FK_Name,
    OBJECT_NAME(fk.parent_object_id) AS Parent_Table,
    c.name AS Parent_Column,
    OBJECT_NAME(fk.referenced_object_id) AS Referenced_Table,
    rc.name AS Referenced_Column
FROM 
    sys.foreign_keys AS fk
INNER JOIN 
    sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN 
    sys.columns AS c ON fkc.parent_object_id = c.object_id AND fkc.parent_column_id = c.column_id
INNER JOIN 
    sys.columns AS rc ON fkc.referenced_object_id = rc.object_id AND fkc.referenced_column_id = rc.column_id
WHERE 
    OBJECT_NAME(fk.parent_object_id) = 'RECORDS' -- Change this to your table name if different
    AND c.name = 'LAST_CHANGED_BY' -- Assuming this is the FK column name
