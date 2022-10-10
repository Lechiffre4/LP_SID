public class CCompte
{
    //Données membre de la classe. Elles sont en protected pour que seul cette classe et la classe
    protected int numCompte;
    protected float solde;



    //constructeur de la classe CCompte initialisant les deux données membres numCompte et solde
    CCompte()
    {
        numCompte = 0;
        solde = 0;
    }

    void AfficherInfos()
    {
        System.out.println("Le numero de compte est : " + numCompte );
        System.out.println("Le solde du compte est  : " + solde + "€");
    }

    int AfficherNumCompte()
    {
        return numCompte;
    }

    float AfficherSolde()
    {
        return solde;
    }

    void CrediterCompte(float money)
    {
        solde += money;
        System.out.println( money + "€ crédité");
    }

    void DebiterCompte(float money)
    {
        solde -= money;
        System.out.println(money + "€ débité");
    }


}
