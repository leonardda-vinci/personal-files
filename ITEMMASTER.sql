SELECT 
b.ItemCode, a.UomEntry, c.UomCode, d.BaseQty, b.ItemName, b.FrgnName, b.OnHand, f.CardCode, g.BcdCode[CodeBars], a.Price[CasePrice],
(SELECT Price FROM dbo.ITM1 WHERE ItemCode=a.ItemCode AND PriceList=28) AS GSP,
(SELECT Price FROM dbo.ITM1 WHERE ItemCode=a.ItemCode AND PriceList=4) AS GNP,
(SELECT Price FROM dbo.ITM1 WHERE ItemCode=a.ItemCode AND PriceList=3) AS GPP,
b.frozenFor, h.WhsName, b.DfltWH, b.U_Division, b.U_Department, b.U_Section, b.U_Category, b.U_Principal, e.UgpName,
b.U_DiscFam, b.U_StandardMArkup,

b.U_Traitflags_0, b.U_Traitflags_1, b.U_Traitflags_2, b.U_Traitflags_3, b.U_Traitflags_4, b.U_Traitflags_5, b.U_Traitflags_6,
b.U_Traitflags_7, b.U_Traitflags_8, b.U_Traitflags_9, b.U_Traitflags_10, b.U_Traitflags_11, b.U_Traitflags_12, b.U_Traitflags_13,
b.U_Traitflags_14, b.U_Traitflags_15, b.U_Traitflags_16, b.U_Traitflags_17, b.U_Traitflags_18, b.U_Traitflags_19, b.U_Traitflags_20,
b.U_Traitflags_21, b.U_Traitflags_22, b.U_Traitflags_23, b.U_Traitflags_24, b.U_Traitflags_25, b.U_Traitflags_26, b.U_Traitflags_27,
b.U_Traitflags_28, b.U_Traitflags_29, b.U_Traitflags_30, b.U_Traitflags_31,

b.U_Itemizer_1, b.U_Itemizer_2, b.U_Itemizer_3, b.U_Itemizer_4, b.U_Itemizer_5, b.U_Itemizer_6, b.U_Itemizer_7, b.U_Itemizer_8, b.U_Itemizer_9,
b.U_Itemizer_10, b.U_Itemizer_11, b.U_Itemizer_12, b.U_Itemizer_13, b.U_Itemizer_14, b.U_Itemizer_15, b.U_Itemizer_16, b.U_Itemizer_17,
b.U_Itemizer_18, b.U_Itemizer_19, b.U_Itemizer_20, b.U_Itemizer_21, b.U_Itemizer_22, b.U_Itemizer_23, b.U_Itemizer_24, b.U_Itemizer_25,
b.U_Itemizer_26, b.U_Itemizer_27, b.U_Itemizer_28, b.U_Itemizer_29, b.U_Itemizer_30, b.U_Itemizer_31, b.U_Itemizer_32,

b.U_LstExtDt, b.U_ExtractItem, b.U_LastExtractTime, b.U_LastPrice, b.U_isExtrct, b.U_PullOut,

b.U_ITMUDF1, b.U_ITMUDF2, b.U_ITMUDF3, b.U_ITMUDF4, b.U_ITMUDF5, b.U_ITMUDF6, b.U_ITMUDF7, b.U_ITMUDF8, b.U_ITMUDF9, b.U_ITMUDF10, 
b.U_ITMUDF11, b.U_ITMUDF12, b.U_ITMUDF13, b.U_ITMUDF14, b.U_ITMUDF15, b.U_ITMUDF16, b.U_ITMUDF17, b.U_ITMUDF18, b.U_ITMUDF19, b.U_ITMUDF20,
b.U_ITMUDF21, b.U_ITMUDF22, b.U_ITMUDF23, b.U_ITMUDF24, b.U_ITMUDF25, b.U_ITMUDF26, b.U_ITMUDF27, b.U_ITMUDF28, b.U_ITMUDF29, b.U_ITMUDF30,

b.U_isExtract, b.U_FileName, b.U_FTDigSign, b.U_ItmDiscPerc, b.InvntItem, b.SellItem, b.PrchseItem, ItmsGrpCod

FROM 
(
SELECT ItemCode, [UomEntry], Price FROM ITM1 WHERE PriceList = 28 
UNION 
SELECT ItemCode, UomEntry, Price FROM ITM9 WHERE PriceList = 28 
) a,
--dbo.ITM9 AS a,
dbo.OITM AS b,
dbo.OUOM AS c,
dbo.UGP1 AS d,
dbo.OUGP AS e,
dbo.OCRD AS f,
dbo.OBCD AS g,
dbo.OWHS AS h

WHERE 
	a.ItemCode = b.ItemCode 
AND a.ItemCode = g.ItemCode
AND a.UomEntry = g.UomEntry
AND a.UomEntry = c.UomEntry
AND d.UomEntry = a.UomEntry
AND b.UgpEntry = e.UgpEntry
AND d.UgpEntry = e.UgpEntry
AND b.CardCode = f.CardCode
AND b.DfltWH = h.WhsCode
AND not (g.BcdCode like '%-%'or g.BcdCode like '%[A-Z]%')