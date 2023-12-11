WITH StreetNameVariations AS (
    SELECT
        street,
        street + ' St' AS StreetSt,
        street + ' Street' AS StreetStreet,
        street + ' Str' AS StreetStr,
        street + ' St.' AS StreetStDot,
		street + ' N' AS StreetN,
		street + ' N.' AS StreetNDot,
		street + ' North' AS StreetNorth,
		street + ' E' AS StreetE,
		street + ' E.' AS StreetEDot,
		street + ' East' AS StreetEast,
		street + ' S' AS StreetS,
		street + ' S.' AS StreetSDot,
		street + ' South' AS StreetSouth,
		street + ' W' AS StreetW,
		street + ' W.' AS StreetWDot,
		street + ' West' AS StreetWest,
        street + ' Sq' AS StreetSq,
        street + ' Square' AS StreetSquare,
        street + ' Rd' AS StreetRd,
        street + ' Road' AS StreetRoad,
        street + ' Rd.' AS StreetRdDot,
        street + ' Ave' AS StreetAve,
        street + ' Avenue' AS StreetAvenue,
        street + ' Ave.' AS StreetAveDot,
        street + ' Blvd' AS StreetBlvd,
        street + ' Boulevard' AS StreetBoulevard,
        street + ' Blvd.' AS StreetBlvdDot,
        street + ' Dr' AS StreetDr,
        street + ' Drive' AS StreetDrive,
        street + ' Dr.' AS StreetDrDot,
        street + ' Ct' AS StreetCt,
        street + ' Court' AS StreetCourt,
        street + ' Ct.' AS StreetCtDot,
        street + ' Ln' AS StreetLn,
        street + ' Lane' AS StreetLane,
        street + ' Ln.' AS StreetLnDot,
        street + ' Pl' AS StreetPl,
        street + ' Place' AS StreetPlace,
        street + ' Pl.' AS StreetPlDot,
        street + ' Terr' AS StreetTerr,
        street + ' Terrace' AS StreetTerrace,
        street + ' Pkwy' AS StreetPkwy,
        street + ' Parkway' AS StreetParkway,
        street + ' Pkwy.' AS StreetPkwyDot,
        street + ' Cir' AS StreetCir,
        street + ' Circle' AS StreetCircle,
        street + ' Cir.' AS StreetCirDot,
        street + ' Aly' AS StreetAly,
        street + ' Alley' AS StreetAlley,
        street + ' Aly.' AS StreetAlyDot,
        street + ' Way' AS StreetWay,
        street + ' Hwy' AS StreetHwy,
        street + ' Highway' AS StreetHighway,
        street + ' Exp' AS StreetExp,
        street + ' Expressway' AS StreetExpressway,
        street + ' Fwy' AS StreetFwy,
        street + ' Freeway' AS StreetFreeway,
        street + ' Trl' AS StreetTrl,
        street + ' Trail' AS StreetTrail,
        street + ' Esp' AS StreetEsp,
        street + ' Esplanade' AS StreetEsplanade,
        street + ' Prom' AS StreetProm,
        street + ' Promenade' AS StreetPromenade
        -- Add more variations as needed
    FROM
        (VALUES 
			('1919 main Blvd'),
      -- Replace these with your street names
			('123 fake street')
        ) AS StreetNames(street)
)
SELECT
    r.CONSTITUENT_ID,
    r.LAST_NAME + ', ' + r.FIRST_NAME as NAME,
    ad.Address_Block as Address
FROM [RE7_17537_8df8b88e-5f5d-4808-b520-bdeb493f669e].dbo.CONSTIT_ADDRESS c
JOIN [RE7_17537_8df8b88e-5f5d-4808-b520-bdeb493f669e].dbo.Address ad ON ad.ID = c.ID
JOIN [RE7_17537_8df8b88e-5f5d-4808-b520-bdeb493f669e].dbo.RECORDS r ON r.ID = c.ID
JOIN StreetNameVariations snv ON ad.Address_Block LIKE '%' + snv.street + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetSt + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetStreet + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetStr + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetStDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetSq + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetSquare + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetRd + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetRoad + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetRdDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetAve + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetN + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetNDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetNorth + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetE + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetEDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetEast + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetS + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetSDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetSouth + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetW + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetWDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetWest + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetAvenue + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetAveDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetBlvd + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetBoulevard + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetBlvdDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetDr + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetDrive + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetDrDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetCt + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetCourt + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetCtDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetLn + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetLane + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetLnDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetPl + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetPlace + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetPlDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetTerr + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetTerrace + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetPkwy + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetParkway + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetPkwyDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetCir + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetCircle + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetCirDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetAly + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetAlley + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetAlyDot + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetWay + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetHwy + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetHighway + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetExp + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetExpressway + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetFwy + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetFreeway + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetTrl + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetTrail + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetEsp + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetEsplanade + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetProm + '%'
   OR ad.Address_Block LIKE '%' + snv.StreetPromenade + '%'
