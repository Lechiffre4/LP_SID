public class CCompteEpargne extends CCompte
{
    //Ici, le taux de rémuneration est une données membre privée parce qu'il n'est pas nécessaire que d'autres parties du code en dehors de la classe y accèdent
    private float tauxRemuneration;

    //Constructeur de la classe  CCompte
    CCompteEpargne()
    {
        //la fonction super() permet d'appeler le constructeur de la classe mère "CCompte"
        super();

        // initialisation de la donnée membre tauxRemuneration
        tauxRemuneration = 0;
    }

    void AfficherInfos()
    {
        //Affichage des informations de la classe CCompteEpargne ( l'instruction "super" devant les variables numCompte et solde
        //permettre d'indiquer que ces variables proviennent de la classe mère)
        System.out.println("Le numero de compte est : " + super.numCompte);
        System.out.println("Le solde du compte est  : " + super.solde  + "€");
        System.out.println("Le taux de rémunération du compte est  : " + tauxRemuneration );
    }

    //Calcul l'interet du compte ( le calcul était dans l'énoncé) et l'affiche
    void CalculInteret()
    {
        float interet = super.solde * tauxRemuneration;
        System.out.println("Les interets gagnées à la fin de l'année seront : " + interet + "€");
    }

    //fonction permettant de modifier la valeur du taux d'interet ( c'est un accesseur )
    void ChangeTaux(float taux)
    {
        tauxRemuneration = taux;
    }

}
