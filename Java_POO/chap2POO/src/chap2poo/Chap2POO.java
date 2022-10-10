package chap2poo;
import chap2poo.Exemple2;


//Exemple 1 
/*public class Chap2POO {

    public static void main(String[] args) {
        // TODO code application logic here
        
        Exemple1 test = new Exemple1(2,3);
        System.out.println(test.GetX());
        System.out.println(test.GetY());
        
    }
    
}*/

//Exemple2
public class Chap2POO {
    public static void main(String[] args) {
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
   }
}

