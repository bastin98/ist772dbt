SELECT 
    {{ dbt_utils.generate_surrogate_key(['p.productid']) }} 
       AS productkey,
    p.productid AS productid,
    p.productname AS productname,
    p.supplierid AS supplierkey,
    c.categoryname AS categoryname,
    c.description AS categorydescription
FROM 
    {{source('northwind','Products')}} p
JOIN 
    {{source('northwind','Categories')}} c ON p.categoryid = c.categoryid
