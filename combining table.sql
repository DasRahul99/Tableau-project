create table product2 as (select a.productcategorykey,
	a.englishproductcategoryname as category ,
	b.productsubcategorykey,
	b.englishproductsubcategoryname as sub_category
from productcategory as a full join productsubcategory as b
on a.productcategorykey=b.productcategorykey);

create table product_table as (select a.productkey, a.englishproductname as product_name,b.*
from product as a right join product2 as b
on a.productsubcategorykey=b.productsubcategorykey);

create table sales as(select productkey,customerkey,salesordernumber as order_number, salesamount as amount,
orderdate,duedate,shipdate,totalproductcost as product_cost
from internetsales
where left(orderdate,4) in ('2021','2022','2023'));



create table customer_table as (select a.customerkey, 
a.firstname ||' '||middlename||' '||lastname as name,a.birthdate,a.maritalstatus,
a.yearlyincome,a.englisheducation as education,a.addressline1,
b.geographykey,b.city,b.stateprovincename as state,b.englishcountryregionname as country,
b.postalcode,b.salesterritorykey as territory_key
from customer as a left join geography as b
	on a.geographykey=b.geographykey);

alter table sales
alter column orderdate type date using to_date(orderdate,'yyyy-mm-dd hh24:mi:ss');

alter table sales
alter column duedate type date using to_date(duedate,'yyyy-mm-dd hh24:mi:ss');

alter table sales
alter column shipdate type date using to_date(shipdate,'yyyy-mm-dd hh24:mi:ss');