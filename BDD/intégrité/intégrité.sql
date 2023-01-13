CREATE Table Stagiaire
(
    No_stagiaire char(7) constraint stagiaire_pk PRIMARY KEY,
    No_cycle number(2) not null ,
    Code_siret char(14),

    Nom_stagiaire varchar2(20) NOT NULL,
    Prenom_stagiaire varchar2(20) NOT NULL,
    Moyenne_generale number(4,2),
    Statut char(1),
    Code_admis char(1)  
);

CREATE Table Cycle
(
    No_cycle number(2) constraint cycle_pk PRIMARY KEY,
    
    Nom_cycle varchar2(70) NOT NULL,
    Niveau number(1) NOT NULL
);

Create Table Entreprise
(
    Code_siret char(14) constraint entreprise_pk PRIMARY KEY,
    
    Raison_sociale varchar2(30) NOT NULL
);

CREATE Table Module
(
    Code_module varchar2(3) constraint module_pk PRIMARY KEY,

    Libelle_module varchar2(60) NOT NULL,
    Nombre_heures number(2)NOT NULL
);

CREATE Table Controle
(
    Date_controle date,
    Code_module varchar2(3),
    
    Salle number(2) not null,
    constraint controle_pk PRIMARY KEY (Date_controle, Code_module)
);

CREATE Table Cours
(
    No_cycle number(2),
    Code_module varchar2(3),
    
    Coefficient number(4,2) not null,
    constraint cours_pk PRIMARY KEY (No_cycle, Code_module)

);

CREATE Table Resultat_module
(
    No_stagiaire char(7),
    Code_module varchar2(3),

    Moyenne_module number(4,2),
    constraint Resultat_module_pk PRIMARY KEY (No_stagiaire, Code_module)
);

CREATE Table Resultat_controle
(
    No_stagiaire char(7),
    Date_controle date,
    Code_module  varchar2(3),

    Note_controle number(4,2),
    constraint Resultat_controle_pk PRIMARY KEY (No_stagiaire,Date_controle, Code_module)

);




--Contraintes sur Stagiaire :
ALTER Table Stagiaire ADD CONSTRAINT stagiaire_cycle_fk FOREIGN KEY (No_cycle) REFERENCES Cycle(No_cycle);
ALTER TABLE Stagiaire ADD CONSTRAINT stagiaire_entreprise_fk FOREIGN KEY(CODE_SIRET) REFERENCES  Entreprise(Code_siret);
ALTER Table Stagiaire ADD CONSTRAINT num_stagiaire_size_check CHECK ( length(No_stagiaire) = 7 );
ALTER Table Stagiaire ADD CONSTRAINT num_stagiaire_validy_check CHECK ( REGEXP_LIKE(No_stagiaire, '[0-9]{6}[a-zA-Z]'));
ALTER TABLE Stagiaire ADD CONSTRAINT statut_stagiaire_check CHECK ( REGEXP_LIKE(Statut, '[0-1]'));
ALTER TABLE Stagiaire ADD CONSTRAINT statut_siret_check CHECK ((STATUT = 1 AND CODE_SIRET is not null) OR (STATUT=0 AND CODE_SIRET is null));

--Contraintes sur Entreprise :
ALTER TABLE Entreprise ADD CONSTRAINT siret_entreprise_check CHECK ( REGEXP_LIKE(CODE_SIRET, '[0-9]{14}'));

-- Contraintes sur Module :
ALTER TABLE Module ADD CONSTRAINT code_module_check CHECK ( length(CODE_MODULE) = 3);
ALTER TABLE Module ADD CONSTRAINT heures_check CHECK ( Nombre_heures in (33,66,90) );

--Contraintes sur Cycle :
ALTER TABLE Cycle ADD CONSTRAINT niveau_cycle_check CHECK ( REGEXP_LIKE(NIVEAU, '[1-3]'));

--Contraintes sur Cours
ALTER TABLE COURS ADD CONSTRAINT cycle_cours_fk FOREIGN KEY(No_cycle) REFERENCES Cycle(No_cycle);
ALTER TABLE COURS ADD CONSTRAINT module_cours_fk FOREIGN KEY(CODE_MODULE) REFERENCES MODULE(Code_module);

--Contraintes sur Resultat module
ALTER TABLE RESULTAT_MODULE ADD CONSTRAINT resultmodule_module_fk FOREIGN KEY(Code_module) REFERENCES MODULE(Code_module);
ALTER TABLE RESULTAT_MODULE ADD CONSTRAINT resultmodule_stagiaire_fk FOREIGN KEY(No_stagiaire) REFERENCES Stagiaire(No_stagiaire) ON DELETE CASCADE;

--Contraintes sur Controle
ALTER TABLE Controle ADD CONSTRAINT controle_module_fk FOREIGN KEY(Code_module) REFERENCES MODULE(Code_module);

--Contraintes sur Resultat controle
ALTER Table Resultat_controle ADD CONSTRAINT resultcontrole_controle_pk FOREIGN KEY (Code_module,DATE_CONTROLE) REFERENCES Controle(Code_module,DATE_CONTROLE) on delete cascade;
ALTER Table Resultat_controle ADD CONSTRAINT resultcontrole_stagiaire_pk FOREIGN KEY (No_stagiaire) REFERENCES Stagiaire(No_stagiaire) on delete cascade ;


