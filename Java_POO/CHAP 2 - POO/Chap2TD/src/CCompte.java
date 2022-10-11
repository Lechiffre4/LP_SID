

public class CCompte
{
    //Données membre de la classe. Elles sont en protected pour que seul cette classe et la classe
    protected int numCompte;
    protected float solde;



    //constructeur de la classe CCompte initialisant les deux données membres numCompte et solde
    CCompte()
    {
        //Ici je génère un nombre aléatoire avec la bibliothèque Math ( c'est pas obligatoire, j'avais juste envie de le faire)
        numCompte = (int)(Math.random()*(99999-1+1)+1);  ;
        solde = 0;
    }

    //Affiche toutes les informations sur le compte
    void AfficherInfos()
    {
        System.out.println("Le numero de compte est : " + numCompte );
        System.out.println("Le solde du compte est  : " + solde + "€");
    }

    //Les deux fonctions/méthodes qui suivent n'était pas nécessaire mais affiche respectivement le numéro du compte et le solde du compte
    int AfficherNumCompte()
    {
        return numCompte;
    }

    float AfficherSolde()
    {
        return solde;
    }

    //Cette fonction prend en paramètre la somme d'argent a ajouter au compte et affiche la somme créditée
    void CrediterCompte(float money)
    {
        solde += money;
        System.out.println( money + "€ crédité");
    }

    //Cette fonction prend en paramètre la somme d'argent a retirer du compte et affiche la somme débité
    void DebiterCompte(float money)
    {
        solde -= money;
        System.out.println(money + "€ débité");
    }
}
