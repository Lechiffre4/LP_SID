-- FULL SCAN = lecture sequentielle
-- RANGE SCAN = lecture partielle
-- UNIQUE SCAN = lecture d'une position
-- by index rowid = lecture en acc�s direct



--------------ARBRE---------------
--Elipse = object name
--rectangle = options (op�ration)



--Display stats
SELECT TABLE_NAME, TABLESPACE_NAME,BLOCKS, NUM_ROWS,EMPTY_BLOCKS,SAMPLE_SIZE ,LAST_ANALYZED FROM USER_TABLES
where TABLE_NAME in
      ('SALESORDERDETAIL','SALESTERRITORY','SALESORDERHEADER','STORECONTACT','PRODUCT','CONTACTTYPE','CONTACT','CUSTOMER');

SELECT * from P2210384.SALESORDERDETAIL WHERE SPECIALOFFERID=2 and PRODUCTID=784;
-- 291 lignes retournées sur 121 317
-- 0.24% < 4% (critère oracle) et la table est de gros volume -->
-- Plan d'execution :
-- 1/ lecture sequentielle de la table SOD
-- obtention des résultats ( cost 403 )


SELECT * from salesorderdetail where specialofferid=2 and productid=784; 
-- 1/ Recup�re les index
-- 2/ lecture en acc�s direct
-- obtention des résultats ( cost 64 )

alter session set optimizer_mode = FIRST_ROWS_100;



SELECT name from P2210384.product where makeflag=1 and class='H';
--14,88% de ligne retourn�es
-- table de petit volume, la requete ram�ne presque 15% des lignes
-- lecture sequentielle de la table product -> obtention des r�sultats
-- cout = 6
create index P2210384.Product_Mk_cl_name_idx on
    P2210384.PRODUCT("MAKEFLAG","CLASS","NAME");
-- Lecture de l'index (lecture partielle)
-- l'index est utilis�, le cout est divis� par 4 
drop index P2210384.Product_Mk_cl_name_idx;

create BITMAP INDEX P2210384.Product_Mk_idx on
    P2210384.PRODUCT(MAKEFLAG);
--creation d'un index bitmap.
-- index non utilis�

create BITMAP INDEX P2210384.Product_class_idx on
    P2210384.PRODUCT(CLASS);
-- creation d'un index bitmap.
-- index non utilis�

--requete 3
explain plan for
SELECT salesorderid from p2210384.salesorderheader where customerid in 
(SELECT customerid from p2210384.customer where territoryid = 10);
-- 10,23% des lignes sont sorties
-- <15% donc une am�lioration est possible(index)
-- lecture sequentielle de customer puis sequentielle de salesorderheader
-- jointure de type hash join puis lecture des donn�es
-- cout = 38
create unique index P2210384.customer_terri_custid_idx on
    P2210384.CUSTOMER("TERRITORYID","CUSTOMERID");
-- creation d'un index unique
--lecture sequentielle de SOH puis lecture d'une position de l'index
--jointure de type nested loop puis obtention des donn�es
--cout =9 (9<38 l'index est utilis� et am�liore le temps de r�ponse (ne lis pas la table customer)) 


select operation, options, object_name,id, parent_id, cost from plan_table;


    
-- requete 4
Explain plan for Select productid from salesorderdetail where unitpricediscount = 0.1 
GROUP By productid 
HAVING sum(unitprice) > 
(select max(sum(unitprice)) from salesorderdetail where unitpricediscount = 0.3 group by productid );
SELECT operation, options, object_name, id, parent_id, cost from plan_table;
-- 0% de ligne retourn�e
-- lecture sequentielle de SOD puis cr�ation d'une table hash ( pour le r�sultat du grp by prodid + having )
-- lecture sequentielle de SOD puis tri(Group By de la sous requete) puis fonction de groupe (aggregate (max et sum))
-- Filtrage pour having requete principale
-- obtention des donn�es
-- cout : 405
-- Index interessant
create index P2210384.SOD_unitpd_productid_idx on
P2210384.SALESORDERDETAIL("UNITPRICEDISCOUNT","PRODUCTID");
-- Lecture partielle de l'index de SOD
-- Lecture en acc�s direct par id
-- tri pour faire un group by requete principal
-- Lecture partielle de l'index
-- Lecture en acc�s direct par id 
-- Tri pour faire un group by sous requete
-- Tri pour faire une aggregation(somme de la sous requ�te)
-- Resolution de la clause having ( filter )
-- Obtention des donn�es
-- cost : 113
delete from plan_table;
DROP index P2210384.SOD_unitpd_productid_unitprice_idx;

create index P2210384.SOD_unitpd_productid_unitprice_idx on
P2210384.SALESORDERDETAIL("UNITPRICEDISCOUNT","PRODUCTID", "UNITPRICE");
-- On change l'index pour rajouter unitprice
--Lecture partielle de l'index de SOD
-- tri group by reQUETE PRINCIPAL
--Lecture partielle de l'index de SOD
--tri group by sous requete
--tri pour aggregation ( max de sum ) sous requete
--r�solution de la clause having (filtre)
--obtention des donn�es
--cost : 3


--REQUETE 5

SELECT contactid FROM storecontact sc JOIN contacttype ct ON
sc.contacttypeid=ct.contacttypeid WHERE name = 'Purchasing Manager'; 
--245 lignes / 743 lignes(table la plus grande des deux) = 32% > 15% donc aucun index ne devrait �tre applicable
--lecture sequentielle de la table Contacttype
--lecture sequentielle de la table storecontact
-- jointure de type nested loop
-- cost 6
Create index P2210384.SC_contactid_idx on P2210384.storecontact(contactid);
Create unique index P2210384.CT_contacttypeid_idx on P2210384.contacttype(contacttypeid);
--ne change pas le plan d'action

DROP index P2210384.SC_contactid_idx;    

--REQUETE 6
SELECT a.territoryid, b.territoryid FROM salesterritory a JOIN salesterritory b ON
a.saleslastyear > b.saleslastyear; 
--lecture sequentielle de la table SALESTERRITORY
-- Tri
--lecture sequentielle de la table SALESTERRITORY
-- Tri
-- jointure de type merge join
-- cost : 8
create index P2210384.ST_saleslastyear_idx on salesterritory(saleslastyear);
--lecture sequentielle de l'index
--lecture en acc�s direct par index de salesterritory
--tri pour la jointure
--lecture sequentielle de la table salesterritory
--tri pour la jointure
--jointure de type merge join
--obtention des donn�es
DROP index P2210384.ST_saleslastyear_idx;   

--requete 7
create view ventesterritoire as select salesorderid,orderdate from salesorderheader
where territoryid=10 and onlineorderflag=1;
SELECT salesorderid FROM VentesTerritoire WHERE orderdate > '12/12/2004';
--0,13% on peut utiliser un index (entre 2 et 4%)
--l'optimiseur remplace la vue par la table d�finition
--lecture sequentielle de SOH
--obtention des donn�es
--cout : 165

--requete 8 
UPDATE Store SET SalesPersonId = 275 WHERE customerid IN (select customerid from
customer where territoryid in (select distinct territoryid from SalesTerritory where groups =
'North America'));
-- 541/701 lignes mis � jour (77,2%) aucun index ne pourra �tre appliquer >15%
-- lecture sequentielle de la table store
-- lecture s�quentielle de la table  SalesTerritory
-- Tri pour �liminer les doublon
-- cr�ation d'une vue r�sultat du tri
-- lecture s�quentielle de la table customer
-- jointure de type hash join 
-- cr�ation d'une vue r�sultat de hash join
-- hash join de la vue2 et de store 
-- update
-- cost 37

-- requete 9 

create index SOD_orderqty_idx on salesorderdetail(orderqty);
select SalesOrderId, SalesOrderDetailId,
productId from SalesOrderDetail where OrderQty = 2; 
-- 11,6% <15% index devrait etre utilis�
-- lecture partielle de l'index
-- lecture de la table en acces direct
--cout = 11
select /*+ full(salesorderdetail) */ + SalesOrderId, SalesOrderDetailId,
productId from SalesOrderDetail where OrderQty = 2; 
-- force la lecture sequentielle






    