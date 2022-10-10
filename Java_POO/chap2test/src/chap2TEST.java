
public class chap2TEST {

    /* EXEMPLE1
    public static void main(String[] args) {

        Exemple1 test = new Exemple1(2,3);
        System.out.println(test.GetX());
        System.out.println(test.GetY());

    }*/

    //Exemple2
    /*public static void main(String[] args) {
            int valx;
            Exemple2 c=new Exemple2();
            c.GetNbpoint();
            Exemple2 d=new Exemple2(5,2);
            d.GetNbpoint();
            c.affiche();
            c.deplace(-2, 4);
            c.affiche();
            d.affiche();
            c.SetX(10);
            valx=c.GetX();
            System.out.println(valx);
        }*/


    //Exemple 3
    public static void main(String[] args) {

        Chien fido=new Chien();
        System.out.println("Fido a "+ fido.GetAge()+ " ans \n");
        fido.Crier();
        fido.BougerLaQueue();
        fido.Dormir();
        fido.SetAge(5);
        System.out.println("Fido a "+ fido.GetAge()+ " ans \n");


    }
}

