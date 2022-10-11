import java.util.Scanner;

public class Chap2TD {
    public static void main(String[] args) {
        //Creation d'un objet scanner permettant de récupérer le choix de l'utilisateur
        Scanner myObj = new Scanner(System.in);

        //Demande a l'utilisateur de choisir un type de compte
        System.out.println("Choisir un type de compte (0= Compte classique, 1= Compte épargne) : ");

        //récupère la valeur de l'utilisateur
        String choix = myObj.nextLine();


        //Le if/else-if/else vérifie la valeur entrée par l'utilisateur et lance le code associé
        if(choix.equals("0"))
        {
            /* Compte Classique */
            System.out.println("----------------Creation d'un compte classique---------------\n");
            //création d'une instance de CCompte et appel de différentes fonctions de la classe
            CCompte Clasic = new CCompte();
            Clasic.AfficherInfos();
            Clasic.CrediterCompte(300);
            Clasic.AfficherInfos();
            Clasic.DebiterCompte(100);
            Clasic.AfficherInfos();
            System.out.println("----------------------------------------------------------\n\n");

        }
        else if (choix.equals("1"))
        {
            /* Compte Epargne */
            System.out.println("----------------Creation d'un compte Epargne---------------\n");
            //création d'une instance de CCompteEpargne et appel de différentes fonctions de la classe
            CCompteEpargne Epargne = new CCompteEpargne();
            Epargne.AfficherInfos();
            Epargne.CrediterCompte(300);
            Epargne.AfficherInfos();
            Epargne.DebiterCompte(100);
            Epargne.AfficherInfos();
            Epargne.ChangeTaux(3);
            Epargne.CalculInteret();
            Epargne.AfficherInfos();
            System.out.println("----------------------------------------------------------\n\n");
        }
        else{
            System.out.println("valeur incorrecte");
        }



    }
}
