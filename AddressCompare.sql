-- Raisers Edge tables
WITH PreferredAddresses AS (
    SELECT 
        r.CONSTITUENT_ID,
        r.LAST_NAME + ', ' + r.FIRST_NAME as NAME,
        ad.Address_Block as Address
    FROM dbo.CONSTIT_ADDRESS c
    JOIN dbo.Address ad on ad.ID = c.ID
    JOIN dbo.RECORDS r on r.ID = c.ID
    WHERE c.PREFERRED = -1
)

-- Comparing imported parish csv
SELECT
    pa.CONSTITUENT_ID as ExistingConstituentID,
    imp.ConsID as ImportedConstituentID,
    pa.NAME,
    pa.Address as ExistingAddress,
    imp.AddrLines as ImportedAddress
FROM PreferredAddresses pa
LEFT JOIN [3-32 St Ann HC 04.24.23 Edit] imp ON pa.Address = imp.AddrLines -- Name of the file you import is the table name
WHERE imp.AddrLines IS NOT NULL
