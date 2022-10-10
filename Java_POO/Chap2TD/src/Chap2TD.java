public class Chap2TD {
    public static void main(String[] args) {

        /* Compte Classique */
        System.out.println("----------------Creation d'un compte classique---------------\n");
        CCompte Clasic = new CCompte();
        Clasic.AfficherInfos();
        Clasic.CrediterCompte(300);
        Clasic.AfficherInfos();
        Clasic.DebiterCompte(100);
        Clasic.AfficherInfos();
        System.out.println("----------------------------------------------------------\n\n" );

        /* Compte Epargne */
        System.out.println("----------------Creation d'un compte Epargne---------------\n");
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
}
