SELECT 
    o.orderid AS orderid,
    {{ dbt_utils.generate_surrogate_key(['employeeid']) }} as employeekey, 
    {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customerkey,
    replace(to_date(orderdate)::varchar,'-','')::int as orderdatekey,
    {{ dbt_utils.generate_surrogate_key(['productid']) }} as productkey,
    od.quantity AS quantity,
    (od.quantity * od.unitprice) AS extendedpriceamount,
    (od.quantity * od.unitprice * od.discount) AS discountamount,
    (od.quantity * od.unitprice - (od.quantity * od.unitprice * od.discount)) AS soldamount
FROM 
    {{source('northwind','Orders')}} o
JOIN 
    {{source('northwind','Order_Details')}} od ON od.orderid = o.orderid