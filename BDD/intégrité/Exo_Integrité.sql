CREATE OR REPLACE TRIGGER VerifDispoSalle_Stag
    BEFORE UPDATE OF salle,datecontrole or INSERT on CONTROLE
    FOR EACH ROW
    -- Vérifie que la salle ainsi que tous les étudiant sont disponible à la date du contrôle
    DECLARE

    BEGIN
        INSERT INTO TEMP_CONTROLE values (:new.CODEMODULE,:new.DATECONTROLE,:new.SALLE);
    end;


CREATE OR REPLACE TRIGGER VerifDispoSalle_Stag2
    AFTER  UPDATE of salle,datecontrole or insert on CONTROLE
    /* Trigger qui se déclanche suite au premier*/
    DECLARE
        V_nb number(1);


    BEGIN
        FOR enr in ( SELECT * FROM TEMP_CONTROLE) LOOP

            --Vérification salle dispo
            SELECT COUNT(*) into V_nb FROM CONTROLE WHERE SALLE = enr.SALLE AND DATECONTROLE = enr.DATECONTROLE;
            if (V_nb > 1 ) then
                RAISE_APPLICATION_ERROR(-20000, 'Erreur, la salle n''est pas dispo');
            end if;

            --Vérification stagiaire disponibles
            SELECT count(datecontrole)
            INTO V_nb
            from controle
            where codemodule in
            (   select codemodule
                from cours
                where NUMCYCLE
                in
                    (   select NUMCYCLE
                        from cours
                        where codemodule=enr.codemodule
                    )
            )
            and datecontrole = enr.datecontrole;
            if (V_nb > 1 ) then
                RAISE_APPLICATION_ERROR(-20001, 'Erreur, un étudiant n''est pas dispo');
            end if;

        end loop;
        DELETE FROM TEMP_CONTROLE;
    end;

INSERT INTO CONTROLE(DATECONTROLE,CODEMODULE,SALLE) VALUES (to_date('20201218','YYYYMMDD'), 'ARI','38');

SELECT c.CONSTRAINT_NAME,t.TRIGGER_NAME from DBA_CONSTRAINTS c
join USER_TRIGGERS t on c.OWNER = t.TABLE_OWNER
where OWNER ='P2210384' AND c.TABLE_NAME in ('CONTROLE','COURS','CYCLE','ENTREPRISE','MODULE','RESULTCONT','RESULTMODULE','STAGIAIRE','TEMP_CONTROLE','TEMP_NOTE');


SELECT * from  DBA_CONSTRAINTS where OWNER ='P2210384';




CREATE OR REPLACE TRIGGER CalculMoyenneTemp
    BEFORE UPDATE OF NOTE or INSERT on RESULTCONT
    FOR EACH ROW
    -- Insert les notes dans une table temporaire
    DECLARE

    BEGIN
        INSERT INTO TEMP_NOTE values (:new.NUMSTAGIAIRE,:new.CODEMODULE,:new.NOTE);
    end;

CREATE OR REPLACE TRIGGER CalculMoyenne
    AFTER UPDATE OF NOTE or INSERT on RESULTCONT
    -- Calcul la moyenne de l'etudiant pour un module
    DECLARE
        v_numstagiaire number;
        v_NoteModule number;
        v_moyenne number;
    BEGIN


        /* Calcul de la moyenne module */
        FOR enr in ( SELECT * FROM TEMP_NOTE) Loop
            SELECT AVG(tn.NOTE) INTO v_NoteModule FROM TEMP_NOTE tn;
            INSERT INTO RESULTMODULE VALUES (enr.NUMST,enr.CODEMOD,v_NoteModule);
        end loop;

        -- Calcul de MoyGen Stagiaire
        FOR enr in (Select * from STAGIAIRE) Loop
            SELECT AVG(SUM(RESULTMODULE.MOYMODULE * C2.COEFF)/SUM(C2.COEFF)) INTO v_moyenne FROM RESULTMODULE join COURS C2 on RESULTMODULE.CODEMODULE = C2.CODEMODULE group by NUMSTAGIAIRE;
            UPDATE STAGIAIRE SET MOYGENE = v_moyenne where STAGIAIRE.NUMSTAGIAIRE = enr.NUMSTAGIAIRE;
        end loop;

    end;



INSERT INTO RESULTCONT VALUES ('656541A','TIR',to_date('20230122','YYYYMMDD'),20);
commit;

SELECT AVG(SUM(RESULTMODULE.MOYMODULE * C2.COEFF)/SUM(C2.COEFF)) as moyenne FROM RESULTMODULE join COURS C2 on RESULTMODULE.CODEMODULE = C2.CODEMODULE
group by NUMSTAGIAIRE;


UPDATE STAGIAIRE SET MOYGENE = (SELECT AVG(SUM(RESULTMODULE.MOYMODULE * C2.COEFF)/SUM(C2.COEFF)) FROM RESULTMODULE join COURS C2 on RESULTMODULE.CODEMODULE = C2.CODEMODULE group by NUMSTAGIAIRE) where STAGIAIRE.NUMSTAGIAIRE ='656541A';
Commit;