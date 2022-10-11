import java.util.Scanner;

public class Chap3TP
{
    public static void main(String[] args)
    {
        try
        {
            CPoint c1 = new CPoint();
            CPoint c2 = new CPoint(1,2);
        }
        catch(construct1 err1)
        {
            System.out.println("exception constructeur 1 : On passe par le constructeur : "+err1.gettext());
            System.exit (-1);
        }
        catch(construct2 err2)
        {
            System.out.println("exception constructeur 2 : On passe par le constructeur : "+err2.gettext());
            System.exit (-1);
        }
    }
}
