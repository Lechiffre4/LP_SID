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