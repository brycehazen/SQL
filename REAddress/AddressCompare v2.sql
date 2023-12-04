WITH PreferredAddresses AS (
    SELECT 
        r.CONSTITUENT_ID,
        r.LAST_NAME + ', ' + r.FIRST_NAME as NAME,
        ad.Address_Block as Address
    FROM [RE7_17537_8df8b88e-5f5d-4808-b520-bdeb493f669e].dbo.CONSTIT_ADDRESS c
    JOIN [RE7_17537_8df8b88e-5f5d-4808-b520-bdeb493f669e].dbo.Address ad ON ad.ID = c.ID
    JOIN [RE7_17537_8df8b88e-5f5d-4808-b520-bdeb493f669e].dbo.RECORDS r ON r.ID = c.ID
    WHERE c.PREFERRED = -1
)

SELECT
    pa.CONSTITUENT_ID as ExistingConstituentID,
    imp.ExceptionConsID as ExceptionConstituentID,
    pa.NAME,
    pa.Address as ExistingAddress,
    imp.ExceptionAddress as ExceptionAddress
FROM PreferredAddresses pa
LEFT JOIN [RE7_17537_8df8b88e-5f5d-4808-b520-bdeb493f669e].dbo.ExceptionAddrlineImport imp 
    ON pa.Address = imp.ExceptionAddress
WHERE imp.ExceptionAddress IS NOT NULL;
