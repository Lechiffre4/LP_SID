create table cycle(
	numcycle number(2) constraint cycle_numcycle_pk primary key,
	nomcycle varchar2(70) NOT NULL,
	niveau number(1) NOT NULL constraint cycle_niveau_ck check (niveau in (1,2,3)));

create table entreprise(
	codesiret char(14) constraint entreprise_codesiret_pk primary key,
	constraint entreprise_codesiret_ck CHECK (REGEXP_LIKE(codesiret,'[0-9]{14}')),
	raisonsoc varchar2(30) NOT NULL);

-- Inutile de mettre le début ^et la fin $ de l'expression régulière car la chaine doit faire 14 caractères max -- et l'expression régulière donne le pattern pour 14 caractères; on ne peut rien mettre avant, ni après
-- sans dépasser 14 caractères.

create table stagiaire(
	numstagiaire char(7) constraint stagiaire_numstag_pk primary key,
	nomst varchar2(20) NOT NULL,
	prenomst varchar2(20) NOT NULL,
	moygene number(4,2) default 0,
	statut char(1) NOT NULL,
	codeadmis char(1) NOT NULL constraint stagiaire_codeadmis_ck check (codeadmis in ('0','1')),
	numcycle number(2) NOT NULL,
	codesiret char(14),
	constraint stagiaire_num_ck CHECK (REGEXP_LIKE(numstagiaire, '[0-9]{6}[A-Z]','i')),
	-- i casse ignorée
	-- ou (REGEXP_LIKE(numstagiaire, '^[[:digit:]]{6}[[:alpha:]]{1}$'))
	-- alpha (pas de caractères autres que des lettres, comme par exemple =, - etc
	-- contrainte suivante sur table obligatoire et non sur colonne
	-- OU '[0-9] {6}[a-zA-Z]'
    -- Inutile de mettre le début ^et la fin $ de l'expression régulière- idem
	constraint stagiaire_statut_ck
	  check ((statut = '0' and codesiret is NULL) OR (statut='1' and codesiret is NOT NULL)));

create table module(
	codemodule varchar2(3) constraint module_code_ck check(length(codemodule) = 3)
	constraint module_codemodule_pk primary key,
	libelle varchar2(60) NOT NULL,
	nbh number(2) NOT NULL constraint module_nbh_ck check (nbh in (33,66,90)));




create table cours(
	numcycle number(2),
	codemodule varchar2(3),
	coeff number(4,2) NOT NULL constraint cours_coeff_ck CHECK (coeff > 0),
	constraint cours_modcycle_pk primary key(codemodule,numcycle));

-- clé composée : NOT NULL par défaut pour chaque colonne
create table controle (
	codemodule varchar2(3),
	datecontrole date,
	salle number(2) NOT NULL,
	constraint controle_moddate_pk primary key(codemodule,datecontrole));

create table resultmodule(
	numstagiaire char(7),
	codemodule varchar2(3),
	moymodule number(4,2) default 0,
	constraint resultmodule_numstmod_pk primary key(numstagiaire,codemodule));

create table resultcont(
	numstagiaire char(7),
	codemodule varchar2(3),
	datecontrole date,
	note number(4,2) constraint resultcont_note_ck check (note between 0 and 20) NOT NULL,
	constraint resultcont_numstmoddate_pk primary key(numstagiaire,codemodule,datecontrole));

alter table stagiaire
add constraint stagiaire_numcycle_fk foreign key(numcycle) references cycle
add constraint stagiaire_codesiret_fk foreign key(codesiret) references entreprise;

ALTER TABLE cours
add constraint cours_codemodule_fk foreign key(codemodule) references module
ADD CONSTRAINT cours_numcycle_fk foreign key(numcycle) references cycle;

ALTER TABLE controle
ADD constraint controle_codemodule_fk foreign key(codemodule) references module;

ALTER TABLE resultmodule
ADD CONSTRAINT resultmodule_numst_fk foreign key(numstagiaire) references stagiaire ON DELETE CASCADE
ADD constraint resultmodule_codemodule_fk foreign key(codemodule) references module;

ALTER TABLE resultcont
ADD CONSTRAINT resultcont_numst_fk foreign key (numstagiaire) references stagiaire ON DELETE CASCADE
	ADD CONSTRAINT resultcont_moddate_fk foreign key(codemodule,datecontrole) references
	controle(codemodule,datecontrole);

-- pour trigger, tables temporaires
-- Création d'une table temporaire vide de même structure que CONTROLE
CREATE GLOBAL TEMPORARY TABLE TEMP_CONTROLE AS SELECT * FROM CONTROLE;
-- même structure que la table contrôle; seules les contraintes "not null" sont copiées
CREATE GLOBAL TEMPORARY TABLE TEMP_NOTE(numst char(7), codemod varchar2(3), note number(4,2));





--Tuples : Fichier base.sql
-- cycles
insert into cycle values(1,'Technicien développement applications informatiques',1 );
insert into cycle values(2,'Technicien micro réseaux et internet',2 );
insert into cycle values(3,'Webmestre : conception de sites et administration de serveurs web',3);

-- modules
insert into module values('ARI','Architecture d''internet',66);
insert into module values ('SRE','Systèmes et réseaux',66);
insert into module values('APC','Algorithmique programmation orientée internet aspect client',33);
insert into module values('APR','Algorithmique programmation orientée internet aspect server',33);
insert into module values('IAS','Installation et administration d''un serveur web',90);
insert into module values('GEW','Graphisme et Web',90);
insert into module values('SR1','Systèmes en réseaux (1)',66);
insert into module values('SR2','Systèmes en réseaux (2)',66);
insert into module values('TIR','Technologies informatiques et réseaux',90);
insert into module values('SIT','Services internet',90);
insert into module values('IWD','Introduction au web dynamique',33);
insert into module values('AP1','Algorithmique programmation(1)',33);
insert into module values('AP2','Algorithmique programmation(2)',33);
insert into module values('SDD','Structures de données',66);
insert into module values('BDR','Bases de données',90);
insert into module values('AGR','Réalisation d''applications de gestion de b.d.d',90);

-- cours
insert into cours values(1,'AP1',25);
insert into cours values(1,'AP2',25);
insert into cours values(1,'SDD',48);
insert into cours values(1,'BDR',70);
insert into cours values(1,'AGR',70);
insert into cours values(1,'ARI',30);
insert into cours values(2,'SR1',55);
insert into cours values(2,'SR2',55);
insert into cours values(2,'TIR',80);
insert into cours values(2,'SIT',80);
insert into cours values(2,'IWD',28);
insert into cours values(3,'ARI',38);
insert into cours values(3,'SRE',38);
insert into cours values(3,'APC',20);
insert into cours values(3,'APR',20);
insert into cours values(3,'IAS',63);
insert into cours values(3,'GEW',63);
insert into cours values(3,'SIT',40);

-- contrôles
insert into controle values('ARI','12/12/2020',15);
insert into controle values('SRE','19/12/2020',26);
insert into controle values('APC','1/12/2020',20);
insert into controle values('APR','6/12/2020',15);
insert into controle values('IAS','11/12/2020',34);
insert into controle values('GEW','28/01/2021',15);
insert into controle values('SR1','10/11/2020',26);
insert into controle values('SR1','4/11/2020',20);
insert into controle values('SR2','15/11/2020',26);
insert into controle values('TIR','18/11/2020',15);
insert into controle values('SIT','23/11/2020',20);
insert into controle values('IWD','9/11/2020',20);
insert into controle values('AP1','14/01/2021',26);
insert into controle values('AP2','20/01/2021',15);
insert into controle values('SDD','24/01/2021',4);
insert into controle values('BDR','4/02/2021',15);
insert into controle values('AGR','10/02/2021',34);

-- entreprises
insert into entreprise values('44754628400012', 'COCA-COLA');
insert into entreprise values('44754628400013', 'CREATIF');
insert into entreprise values('44754628400014', 'ABEILLE RUSH');
insert into entreprise values('44754628400015', 'DEGRYSE ET LESAGE');
insert into entreprise values('44754628400016', 'AGENOR SECURITE');
insert into entreprise values('44754628400017', 'DUNLOP France');
insert into entreprise values('44754628400019', 'ELECMATIC');
insert into entreprise values('44754628400041', 'ELITE MEDICALE');
insert into entreprise values('44754628400048', 'ARC LOCATION');
insert into entreprise values('44754628400044', 'ATAC LOGISTIQUE');
insert into entreprise values('44754628400045', 'EUROMASTER');

-- stagiaires
insert into stagiaire values('656541A','Adamczyk','Katarzyna',NULL,'1','0',2,'44754628400012');
insert into stagiaire values('656542A','Anassalon','Christine',NULL,'0','0',1,NULL);
insert into stagiaire values('658941A','Bacon','Nicole',NULL,'1','0',2,'44754628400012');
insert into stagiaire values('556541A', 'Bouvier','Annie',NULL,'0','0',3,NULL);
insert into stagiaire values('356541A', 'David','Olivier',NULL,'0','0',2,NULL);
insert into stagiaire values('256541A', 'Denis','Jean-Baptiste',NULL,'1','0',3,'44754628400014');
insert into stagiaire values('456541A', 'Derrien', 'Alain',NULL,'0','0',2,NULL);
insert into stagiaire values('556041A', 'Fraoua', 'Mohamed',NULL,'0','0',1,NULL);
insert into stagiaire values('686541A','Gauchi', 'Jean-Pierre',NULL,'1','0',2,'44754628400015');
insert into stagiaire values('756541A', 'Goelzer', 'Anne',NULL,'0','0',2,NULL);
insert into stagiaire values('856541A', 'Huet', 'Sylvie',NULL,'1','0',2, '44754628400045');
insert into stagiaire values('956541A', 'Jacob', 'Christine',NULL,'0','0',1,NULL);
insert into stagiaire values('626541A', 'Kervrann', 'Charles',NULL,'1','0',3,'44754628400044');
insert into stagiaire values('666541A', 'Kiêu' ,'Kiên',NULL,'0','0',3,NULL);
insert into stagiaire values('688541A','Kobilinsky' ,'André',NULL,'0','0',2,NULL);
insert into stagiaire values('699941A', 'Laredo' ,'Catherine',NULL,'1','0',3,'44754628400016');
insert into stagiaire values('665401A','Monod' ,'Hervé',NULL,'1','0',2,'44754628400012');
insert into stagiaire values('236541A','Monvert', 'Eric',NULL,'1','0',2,'44754628400019');
insert into stagiaire values('246541A','Pons' ,'Odile',NULL,'0','0',1,NULL);
insert into stagiaire values('406541A','Pophillat', 'Patricia',NULL,'1','0',3, '44754628400045');
insert into stagiaire values('401541A','Reno','Valérie',NULL,'0','0',2,NULL);
insert into stagiaire values('409541A','Rospars', 'Jean-Pierre',NULL,'1','0',1,'44754628400017');
insert into stagiaire values('568541A','Schaeffer' ,'Brigitte',NULL,'0','0',1,NULL);
insert into stagiaire values('874541A','Touzeau','Suzanne',NULL,'0','0',3,NULL);
insert into stagiaire values('156541A','Trubuil', 'Alain',NULL,'1','0',1,'44754628400041');
insert into stagiaire values('123541A','Vergu', 'Elisabeta',NULL,'1','0',3,'44754628400048');
insert into stagiaire values('187541a','Vigneron' ,'Antoine',NULL,'1','0',2, '44754628400013');
insert into stagiaire values('180541A','Wang', 'Juhui',NULL,'0','0',1,NULL);

commit;

