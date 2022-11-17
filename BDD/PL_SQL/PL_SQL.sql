create procedure savetransfert(pnumadh ADHERENT.no_adherent%type, pmontent adherent.credits%type)
is
--déclaration
v_x CHAR(1);
BEGIN
    SELECT 'x' INTO v_x FROM ADHERENT where NO_ADHERENT = pnumadh FOR UPDATE OF CREDITS;
    UPDATE ADHERENT set CREDITS = credits + pmontent where NO_ADHERENT = pnumadh;
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error : L''adhérent numéro '||pnumadh||' n''existe pas');
        RAISE;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR de code : '||SQLCODE||' Message d''erreur : '||SQLERRM);
end;


CREATE OR REPLACE TRIGGER PAYPARTICIPATION
AFTER UPDATE OF payee
    on PARTICIPE
    for each row


    when(new.PAYEE = 'V' and old.PAYEE = 'F')
    BEGIN
        UPDATE ADHERENT SET CREDITS = CREDITS - (SELECT MT_PARTICIPATION from SORTIE where SORTIE.NO_SORTIE = :new.NO_SORTIE)
        WHERE NO_ADHERENT = :new.NO_ADHERENT;
    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR de code : '||SQLCODE||' Message d''erreur : '||SQLERRM);

    end;

UPDATE PARTICIPE set PAYEE = 'V' where NO_ADHERENT =2;
SELECT * FROM ADHERENT;












    CREATE OR REPLACE function affectPackage(pnumsortie SORTIE.NO_SORTIE%type)
    RETURN SORTIE.NO_SORTIE%type
    is
        v_idPaquetage SORTIE.NO_SORTIE%type := 0;
        v_caution PAQUETAGE.CAUTION%type := 0;
        v_credits ADHERENT.CREDITS%type := 0;

        v_idSortie SORTIE.NO_SORTIE%type := 0;

    BEGIN
        SELECT NO_SORTIE into v_idSortie from SORTIE where pnumsortie = NO_SORTIE;

        FOR enr in (SELECT NO_ADHERENT from PARTICIPE where PAYEE = 'V' and NO_SORTIE = pnumsortie)
        LOOP

            SELECT no_paquetage into v_idPaquetage from UTILISE
            WHERE NO_PAQUETAGE not in (SELECT NO_PAQUETAGE from PRET WHERE DATE_RETOUR is null) and NO_SORTIE = pnumsortie
            order by NO_PAQUETAGE
            FETCH FIRST 1 row only;

            SELECT CAUTION into v_caution from PAQUETAGE where NO_PAQUETAGE = v_idPaquetage;
            SELECT CREDITS into v_credits from ADHERENT where NO_ADHERENT = enr.NO_ADHERENT;

            IF v_caution>=v_credits THEN
                dbms_output.put_line('Problème de caution pour le parquetage '|| v_idPaquetage || 'et l''adhérent ' || enr.NO_ADHERENT );
            ELSE
                insert into PRET(date_pret, no_paquetage, no_adherent) values (sysdate, v_idPaquetage,enr.NO_ADHERENT);
                UPDATE ADHERENT set CREDITS = v_credits - v_caution where NO_ADHERENT = enr.NO_ADHERENT;
            end if;
        end loop;

        commit;
        RETURN 0;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Pas assez de paquetages');
            commit;
            return -2;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR de code : '||SQLCODE||' Message d''erreur : '||SQLERRM);
                rollback;
                return -1;
    end;

SELECT * FROM ADHERENT
join PARTICIPE P on ADHERENT.NO_ADHERENT = P.NO_ADHERENT;


