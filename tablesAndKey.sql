SELECT 
    fk.name AS FK_name,
    tp.name AS Parent_table,
    cp.name AS Parent_column,
    tr.name AS Referenced_table,
    cr.name AS Referenced_column
FROM 
    sys.foreign_keys AS fk
INNER JOIN 
    sys.tables AS tp ON fk.parent_object_id = tp.object_id
INNER JOIN 
    sys.tables AS tr ON fk.referenced_object_id = tr.object_id
INNER JOIN 
    sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN 
    sys.columns AS cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN 
    sys.columns AS cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
WHERE 
    tp.name = 'CONSTIT_ADDRESS' AND tr.name = 'RECORDS'
