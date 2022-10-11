import java.util.Scanner;

public class tableau {
    private double tab[] = new double[10];
    tableau(int nbelem) throws vect_crea
    {
        double elem;
        Scanner sc = new Scanner(System.in);
        if (nbelem <0)
        {
            vect_crea v=new vect_crea (nbelem);
            throw (v);
        }
        else
        {
            for(int i=0 ;i<nbelem ;i++)
            {
                System.out.println("Elément à l’indice " + i +" ?") ;
                elem = sc.nextDouble();
                tab[i]=elem;
            }
        }
    }
    public double  elemindi (int i)throws vect_lim
    {
        if (i<0 || i>=tab.length)
        {
            vect_lim l=new vect_lim (i);
            throw (l);
        }
        return tab[i];
    }
}