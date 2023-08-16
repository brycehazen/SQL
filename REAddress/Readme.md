# CSV Importing Process into SQL Server

This README provides step-by-step instructions on importing a CSV file into SQL Server using the SQL Server Management Studio (SSMS) and then comparing the imported data with existing data in the database.

## Prerequisites

- SQL Server Management Studio (SSMS)
- A CSV file with data to import

## Step-by-step Process

### 1. Open SSMS

- Launch SQL Server Management Studio.
- Connect to your SQL Server instance.

### 2. Import CSV

- Right-click on the database you wish to import data into.
- Choose `Tasks` > `Import Data` to launch the SQL Server Import and Export Wizard.
- For the data source, choose "Flat File Source".
- Browse and select your CSV file.
- Configure the format settings based on the contents of your CSV:
  - **Format**: Delimited
  - **Text qualifier**: Depending on your CSV, this is typically a double quote (`"`)
  - **Header rows to skip**: Usually 0 if your CSV starts with data. If there's a header, SSMS should auto-detect and adjust.
  - **Column names in the first data row**: Check this if your CSV has column headers.

### 3. Specify Import Destination

- For the destination, choose "SQL Server Native Client".
- Enter the details of your SQL Server instance and select the database.

### 4. Configure Data Mapping

- Ensure data types and columns from your CSV match the destination table in SQL Server.
- Adjust column mappings if necessary.
  
### 5. Execute the Import

- Run the import process.
- Check for any errors. If there are issues, SSMS will provide details on what went wrong.

### 6. Compare Imported Data with Existing Data

To compare the imported data with existing data in your database, you can use SQL queries. Here's an example:

```sql
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

SELECT
    pa.CONSTITUENT_ID as ExistingConstituentID,
    imp.ConsID as ImportedConstituentID,
    pa.NAME,
    pa.Address as ExistingAddress,
    imp.AddrLines as ImportedAddress
FROM PreferredAddresses pa
LEFT JOIN [YourImportedTableName] imp ON pa.Address = imp.AddrLines
WHERE imp.AddrLines IS NOT NULL;
