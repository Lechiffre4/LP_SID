--17
select distinct numfamille from article;

--18
select distinct numfournisseur from article order by numfournisseur;

--19
select to_char(AVG(ca_client),'9G999G999D99') as moyenne_ca, to_char(MAX(ca_client),'9G999G999D99') as max_ca, to_char(MIN(ca_client),'9G999G999D99') as min_ca  from client;

--20
select COUNT(numclient) from client where numcategorie = 6;

--21
select SUM(ca_article) as SOMME_CA  from article where numfournisseur= 45;

--22
select numcategorie,
ROUND(AVG(ca_client)) as MOYENNE_CA_CLIENT,
ROUND(MAX(ca_client)) as MAX_CA_CLIENT,
ROUND(MIN(ca_client)) as MIN_CA_CLIENT
from client
Group by numcategorie;

--23
select numfournisseur,
SUM(ca_article) as MOYENNE_CA_ARTICLE
from article
Group by numfournisseur;

--24
select numcategorie,
COUNT(numclient)
from client
group by numcategorie;

--25
select numcategorie,  to_char(AVG(ca_client),'9G999G999D99') as CA_MOYEN_CAT
from client
group by numcategorie
having AVG(ca_client) > 9800;

--26
select numfamille, SUM(ca_article) as SOMME_CA_ARTICLE, AVG(ca_article) MOYENNE_CA_ARTICLE
from article
group by numfamille
having AVG(ca_article) <75000;

--27
select cli. numclient, cli.rs_client, ca.lib_categorie
from client cli
join categorie ca
on cli.numcategorie = ca.numcategorie;

--28
select cli.numclient, cli.rs_client, co.numcommande, a.numarticle, a.designation, li.qte_commande
from client cli
join commande co on cli.numclient = co.numclient
join lignecde li on co.numcommande = li.numcommande
join article a on a.numarticle = li.numarticle;

--29
select cli.numclient, cli.rs_client, liv.numlivraison, a.designation, liliv.qte_livraison
from client cli
join livraison liv on liv.numclient = cli.numclient
join ligneliv liliv on liv.numlivraison = liliv.numlivraison
join article a on a.numarticle = liliv.numarticle;

--30
select co.numcommande, co.date_commande, a.numarticle, a.designation, li.qte_commande
from commande co
join lignecde li on co.numcommande= li.numcommande
join article a on a.numarticle = li.numarticle
WHERE date_commande < to_date('30-01-2018', 'DD-MM-YYYY');

--31
select a.numarticle, SUM(li.qte_commande) as cumul_qte
from article a
join lignecde li on a.numarticle= li.numarticle
join commande c  on li.numcommande = c.numcommande
where c.etat_commande = 'O'
group by a.numarticle;

--32
select ca.numcategorie, COUNT(*) nb_commandes
from commande c
join client cli on cli.numclient = c.numclient
join categorie ca on ca.numcategorie = cli.numcategorie
group by ca.numcategorie;

--33
select a.numfamille, AVG(distinct a.ca_article) ca_moyen, MAX(a.ca_article) ca_max, MIN(a.ca_article) ca_min
from article a
join  lignecde li on li.numarticle = a.numarticle
group by a.numfamille
order by a.numfamille;

--34
select numarticle,designation, qte_stock
from article
where qte_stock >= (select AVG(qte_stock) from article);

--35
select numrepresentant, nom_representant 
from representant
where numrepresentant in (select numrepresentant from commande);

--36
select numcommande, date_commande, etat_commande, numclient, numrepresentant, delais
from commande
where numcommande in (select numcommande from livraison) and etat_commande = 'N';

--37
select numarticle, designation 
from article
where numarticle not in 
(select li.numarticle from lignecde li
join commande co on co.numcommande= li.numcommande
where co.date_commande like '%18');

--38
select cli.numclient, cli.rs_client, a.numarticle, a.designation
from client cli
join commande co on cli.numclient = co.numclient
join LIGNECDE lc on co.NUMCOMMANDE = lc.NUMCOMMANDE
join article a on a.numarticle = lc.numarticle;

-- 39
Select cli.NUMCATEGORIE, ROUND(AVG(cli.CA_CLIENT),2) CA from CLIENT cli
HAVING MAX(cli.CA_CLIENT) > (SELECT AVG(cli.CA_CLIENT) from CLIENT cli)
group by cli.NUMCATEGORIE;

--40
SELECT co.NUMCOMMANDE, COUNT(L.NUMCOMMANDE) NB_Commande from COMMANDE co
join LIGNECDE L on co.NUMCOMMANDE = L.NUMCOMMANDE
HAVING COUNT(L.NUMCOMMANDE) =
(SELECT MAX(COUNT(L.NUMCOMMANDE)) from LIGNECDE L group by L.NUMCOMMANDE)
group by co.NUMCOMMANDE;

--41
SELECT DISTINCT cli.NUMCLIENT, cli.RS_CLIENT from client cli
join COMMANDE co on cli.NUMCLIENT = co.NUMCLIENT
HAVING COUNT(co.NUMCOMMANDE) >= 2
GROUP BY  cli.NUMCLIENT, cli.RS_CLIENT;

--42
SELECT cat.LIB_CATEGORIE, cli.NUMCLIENT, cli.RS_CLIENT from CLIENT cli
right join CATEGORIE cat on cli.NUMCATEGORIE = cat.NUMCATEGORIE;

--43
SELECT cli.NUMCLIENT, cli.RS_CLIENT, cli.CA_CLIENT from CLIENT cli
WHERE cli.CA_CLIENT <
(select avg(cl.CA_CLIENT) from CLIENT cl
join CATEGORIE ca on cl.NUMCATEGORIE = ca.NUMCATEGORIE
where ca.NUMCATEGORIE = cli.NUMCATEGORIE
group by ca.NUMCATEGORIE);

--44
SELECT a.NUMARTICLE, a.DESIGNATION, F.LIB_FAMILLE from ARTICLE a
join FAMILLE F on a.NUMFAMILLE = F.NUMFAMILLE
where a.CA_ARTICLE =
      (SELECT MAX(art.CA_ARTICLE)
      from ARTICLE art
               join FAMILLE fa on fa.NUMFAMILLE = art.NUMFAMILLE
      WHERE F.NUMFAMILLE = art.NUMFAMILLE
      GROUP BY LIB_FAMILLE);

--45
SELECT cli.NUMCLIENT, cli.RS_CLIENT, cli.CA_CLIENT from CLIENT cli
WHERE cli.CA_CLIENT <
(select avg(cl.CA_CLIENT) from CLIENT cl
join CATEGORIE ca on cl.NUMCATEGORIE = ca.NUMCATEGORIE
where ca.NUMCATEGORIE = cli.NUMCATEGORIE
group by ca.NUMCATEGORIE)
union
SELECT C2.NUMCLIENT, C2.RS_CLIENT, C2.CA_CLIENT from COMMANDE co
join CLIENT C2 on co.NUMCLIENT = C2.NUMCLIENT
HAVING COUNT(co.NUMCLIENT) = 1
group by C2.NUMCLIENT, C2.RS_CLIENT, C2.CA_CLIENT;

--46
SELECT cli.NUMCLIENT, cli.RS_CLIENT, cli.CA_CLIENT from CLIENT cli
WHERE cli.CA_CLIENT <
(select avg(cl.CA_CLIENT) from CLIENT cl
join CATEGORIE ca on cl.NUMCATEGORIE = ca.NUMCATEGORIE
where ca.NUMCATEGORIE = cli.NUMCATEGORIE
group by ca.NUMCATEGORIE)
intersect
SELECT C2.NUMCLIENT, C2.RS_CLIENT, C2.CA_CLIENT from COMMANDE co
join CLIENT C2 on co.NUMCLIENT = C2.NUMCLIENT
HAVING COUNT(co.NUMCLIENT) = 1
group by C2.NUMCLIENT, C2.RS_CLIENT, C2.CA_CLIENT;

--47
SELECT cli.NUMCLIENT, cli.RS_CLIENT, cli.CA_CLIENT from CLIENT cli
WHERE cli.CA_CLIENT <
(select avg(cl.CA_CLIENT) from CLIENT cl
join CATEGORIE ca on cl.NUMCATEGORIE = ca.NUMCATEGORIE
where ca.NUMCATEGORIE = cli.NUMCATEGORIE
group by ca.NUMCATEGORIE)
minus
SELECT C2.NUMCLIENT, C2.RS_CLIENT, C2.CA_CLIENT from COMMANDE co
join CLIENT C2 on co.NUMCLIENT = C2.NUMCLIENT
HAVING COUNT(co.NUMCLIENT) = 1
group by C2.NUMCLIENT, C2.RS_CLIENT, C2.CA_CLIENT;

--48
SELECT cli.NUMCLIENT, cli.RS_CLIENT from CLIENT cli
where cli.CA_CLIENT > ANY
(SELECT cl.CA_CLIENT FROM CLIENT cl
WHERE cl.NUMCATEGORIE = 1
)
order by cli.NUMCLIENT;

--49
SELECT cli.NUMCLIENT, cli.RS_CLIENT from CLIENT cli
where cli.CA_CLIENT > all
(SELECT cl.CA_CLIENT FROM CLIENT cl
WHERE cl.NUMCATEGORIE = 1
)
order by cli.NUMCLIENT;

--50
SELECT cli.NUMCLIENT, cli.RS_CLIENT from CLIENT cli
WHERE not EXISTS(SELECT distinct com.NUMCLIENT from COMMANDE com
    where com.NUMCLIENT = cli.NUMCLIENT);

--51
INSERT INTO SECTEUR VALUES ('24','Québec');


--52
UPDATE ARTICLE
SET QTE_STOCK = 600
WHERE NUMARTICLE = 1;

--53
UPDATE ARTICLE a
SET a.QTE_STOCK = (SELECT AVG(ar.QTE_MINI) from ARTICLE ar
WHERE a.NUMFAMILLE = ar.NUMFAMILLE
group by ar.NUMFAMILLE);

select * from ARTICLE;













