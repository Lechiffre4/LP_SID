
import java.util.Scanner;

public class CHAP4TD {
    public static void main(String[] args) {
        try{
            ManipulationBDD bdd = new ManipulationBDD();
            while(true) {
                //Début du menu
                System.out.println("===========MENU==========");
                System.out.println("1. Afficher les minibus");
                System.out.println("2. Ajouter un minibus");
                System.out.println("3. Modifier la capacité d'un minubus");
                System.out.println("4. Quit");
                System.out.println("========================= \n\n");

                System.out.println("Quel opération voulez vous faire : ");
                Scanner scan = new Scanner(System.in);
                int choix = scan.nextInt();
                System.out.println("\n \n");


                //Opérations
                if (choix == 1) {
                    bdd.select();

                } else if (choix == 2) {
                    System.out.println("Entrez l'ID du bus: ");
                    int idMinibus = scan.nextInt();
                    System.out.println("Entrez la capacité du bus: ");
                    int capacite = scan.nextInt();

                    bdd.insert(idMinibus, capacite);
                } else if (choix == 3) {
                    System.out.println("Entrez l'ID du bus: ");
                    int idMinibus = scan.nextInt();
                    System.out.println("Entrez la nouvelle capacité: ");
                    int nouvelleCapacite = scan.nextInt();
                    bdd.modify(idMinibus, nouvelleCapacite);
                }
                else{
                    System.out.println("Fermeture de l'application");
                    System.exit(0);
                }

            }
        }catch(Exception e)
        {
            System.out.println(e);
        }

    }

}
