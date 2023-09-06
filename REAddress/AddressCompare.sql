-- This WITH clause defines a Common Table Expression (CTE) for preferred addresses from Raisers Edge tables.
WITH PreferredAddresses AS (
    -- Selecting relevant columns from linked tables to fetch the preferred addresses.
    SELECT 
        r.CONSTITUENT_ID,
        r.LAST_NAME + ', ' + r.FIRST_NAME as NAME, -- Concatenating last name and first name to form a single name column.
        ad.Address_Block as Address
    FROM dbo.CONSTIT_ADDRESS c
    JOIN dbo.Address ad on ad.ID = c.ID -- Joining on address ID to fetch address details.
    JOIN dbo.RECORDS r on r.ID = c.ID -- Joining on record ID to fetch constituent details.
    WHERE c.PREFERRED = -1 -- Filtering for preferred addresses.
)

-- Query to compare the data from the imported parish csv with the preferred addresses from Raisers Edge tables.
SELECT
    pa.CONSTITUENT_ID as ExistingConstituentID, -- Constituent ID from preferred addresses.
    imp.ConsID as ImportedConstituentID, -- Constituent ID from imported data.
    pa.NAME, -- Name from preferred addresses.
    pa.Address as ExistingAddress, -- Address from preferred addresses.
    imp.AddrLines as ImportedAddress -- Address from imported data.
FROM PreferredAddresses pa
LEFT JOIN [3-32 St Ann HC 04.24.23 Edit] imp ON pa.Address = imp.AddrLines -- Joining on address. Note: The table name is based on the imported file's name.
WHERE imp.AddrLines IS NOT NULL -- Filtering out rows where imported address is null.
