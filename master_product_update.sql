SELECT 
a.ItemCode, a.ItemName, d.UomCode[Uom], 

CASE WHEN OBSP.Price = NBSP.Price THEN 0 ELSE OBSP.Price END 'Old Price',
CASE WHEN OBSP.Price = NBSP.Price THEN 0 ELSE NBSP.Price END 'New Price',
CASE WHEN OBSP.Price <> NBSP.Price THEN 'Change BSP' 
WHEN OLD.ItemName <> NEW.ItemName THEN 'Change Description'
WHEN OBSP.Price <> NBSP.Price and OLD.ItemName <> NEW.ItemName THEN 'Change BSP & Description' END 'Status',
OLD.ItemName 'Old Name', 
NEW.ItemName'New Name', 
e.CardCode, e.CardName, a.UpdateDate, a.U_Itemizer_21 'Assign Barcode', a.U_Itemizer_21 'Assign Barcode Count',
a.ItemName 'Promo Items',

Case When (SELECT TOP 1 CASE WHEN ougp.UgpName = 'PCS' or ougp.UgpName = 'PI' THEN '-' ELSE OBCD.BcdCode END
FROM OUGP INNER JOIN UGP1 ON OUGP.UgpEntry = UGP1.UgpEntry
INNER JOIN OBCD ON UGP1.UomEntry = OBCD.UomEntry
WHERE OUGP.UgpEntry = a.UgpEntry AND OBCD.ItemCode = a.ItemCode
ORDER BY UGP1.BaseQty DESC) = '' or 
(SELECT TOP 1 CASE WHEN ougp.UgpName = 'PCS' or ougp.UgpName = 'PI' THEN '-' ELSE OBCD.BcdCode END
FROM OUGP INNER JOIN UGP1 ON OUGP.UgpEntry = UGP1.UgpEntry
INNER JOIN OBCD ON UGP1.UomEntry = OBCD.UomEntry
WHERE OUGP.UgpEntry = a.UgpEntry AND OBCD.ItemCode = a.ItemCode
ORDER BY UGP1.BaseQty DESC) = '-' THEN 1 ELSE 0 END AS 'No Case Code',

l.UgpName 'PCS Uom', l.BaseUom 'Base Qty', a.StockValue 'Stock Level',

a.U_ITMUDF1, a.U_ITMUDF2, a.U_ITMUDF3, a.U_ITMUDF4, 
a.U_ITMUDF5, a.U_ITMUDF6, a.U_ITMUDF7, a.U_ITMUDF8, 
a.U_ITMUDF9, a.U_ITMUDF10, a.U_ITMUDF11, a.U_ITMUDF12, 
a.U_ITMUDF13, a.U_ITMUDF14, a.U_ITMUDF15, a.U_ITMUDF16, 
a.U_ITMUDF17, a.U_ITMUDF18, a.U_ITMUDF19, a.U_ITMUDF20,
a.U_ITMUDF21, a.U_ITMUDF22, a.U_ITMUDF23, a.U_ITMUDF24, 
a.U_ITMUDF25, a.U_ITMUDF26, a.U_ITMUDF27, a.U_ITMUDF28, 
a.U_ITMUDF29, a.U_ITMUDF30

FROM
AITM AS a,
OITM AS b,
(SELECT ItemCode, MIN(UomEntry)'UomEntry' FROM OBCD GROUP BY iTEMCODE) c,
OUOM AS d,
OCRD AS e,
(SELECT MAX(AITM.loginstanc)'loginstanc', AITM.ItemCode FROM AITM GROUP BY ItemCode) g,

(SELECT MAX(AITM.loginstanc)'loginstanc', AIT1.ItemCode 
FROM AIT1, AITM
WHERE AIT1.ItemCode = AITM.ItemCode AND AITM.UpdateDate = '2024-07-31' and AITM.Codebars IS NULL 
GROUP BY AIT1.ItemCode) h,

(select OPLN.ListNum from OPLN where OPLN.U_BranchCode = (Select convert(varchar(10),a.AliasName) from OADM a)) i,
(select OPLN.ListNum from OPLN where OPLN.U_BranchCode = (Select convert(varchar(10),a.AliasName) from OADM a)) j,

AIT1 AS OBSP,
AIT1 AS NBSP,
AITM AS OLD,
AITM AS NEW,
UGP1 AS k,
OUGP as l

WHERE a.ItemCode = b.ItemCode
AND a.ItemCode = c.ItemCode
AND c.UomEntry = d.UomEntry
AND b.CardCode = e.CardCode
AND a.ItemCode = g.ItemCode
AND a.ItemCode = h.ItemCode
AND a.LogInstanc = h.loginstanc
AND h.ItemCode = OBSP.ItemCode
AND h.ItemCode = NBSP.ItemCode
AND OBSP.PriceList = i.ListNum
AND NBSP.PriceList = j.ListNum
AND OBSP.LogInstanc = (h.loginstanc-1)
AND NBSP.LogInstanc = h.loginstanc
AND a.ItemCode = OLD.ItemCode
AND a.ItemCode = NEW.ItemCode
AND OLD.LogInstanc = (g.loginstanc-1)
AND NEW.LogInstanc = g.loginstanc
AND c.ItemCode = b.ItemCode
AND l.UgpEntry = k.UgpEntry
AND k.UomEntry = c.UomEntry
AND l.UgpEntry = b.UgpEntry
AND a.UpdateDate = '2024-07-31'
AND a.ItemCode = '6498541073029'


--SELECT * FROM OBCD WHERE BcdCode = '19501000005633'


--PriceList | OBSP & NBSP
--select OPLN.ListNum, U_BranchCode from OPLN
--Select convert(varchar(10),a.AliasName) from OADM a --Branch Code
--SELECT Loginstanc FROM AITM
--SELECT Loginstanc, * FROM AIT1 WHERE ItemCode = '10128' AND PriceList='28'



--SELECT TOP 1 CASE WHEN ougp.UgpName = 'PCS' or ougp.UgpName = 'PI' THEN '-' ELSE OBCD.BcdCode END
--FROM OITM b, OUGP INNER JOIN UGP1 ON OUGP.UgpEntry = UGP1.UgpEntry
--INNER JOIN OBCD ON UGP1.UomEntry = OBCD.UomEntry
--WHERE OUGP.UgpEntry = b.UgpEntry AND OBCD.ItemCode = b.ItemCode
--ORDER BY UGP1.BaseQty DESC