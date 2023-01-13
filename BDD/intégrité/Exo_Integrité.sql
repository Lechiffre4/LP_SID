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
    FOR EACH ROW
    -- Calcul la moyenne de l'etudiant pour un module
    DECLARE
        v_NoteModule number;
        v_moyenne number;
    BEGIN
        SELECT AVG(NOTE) INTO v_NoteModule FROM TEMP_NOTE where TEMP_NOTE.NUMST = NUMSTAGIAIRE;
        INSERT INTO RESULTMODULE VALUES (NUMSTAGIAIRE,CODEMODULE,v_NoteModule);


    end;
