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

