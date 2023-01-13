
public class CPoint {
    private int x;
    private int y;
    static int nbpoint;

    CPoint() throws construct1
    {
        String text = "Constructeur 1";
        this.x=0;         this.y=0;
        nbpoint++;
        construct1 c1 = new construct1(text);
        throw c1;
    }
    CPoint (int abs, int ord) throws construct2
    {
        String text = "Constructeur 2";
        this.x = abs;         this.y = ord;
        nbpoint++;
        construct2 c2 = new construct2(text);
        throw c2;
    }

    CPoint(int abs) throws construct3
    {
        String Text = "Constructeur 3";
        if(abs == 0){
            construct3 c3 = new construct3(Text);
            throw c3;
        }
        this.x = abs; this.y = 0;
        nbpoint++;

    }
    void deplace (int dx, int dy)
    {
        this.x = this.x + dx;         this.y = this.y + dy;
    }
    void affiche()
    {         System.out.println("Les coordonnées sont : (" + this.x +";" + this.y +")");     }
    void SetX(int val1)
    {         this.x=val1;     }
    void SetY(int val2)
    {         this.y=val2;     }
    int GetX()
    {         return(this.x);     }
    int GetY()
    {         return(this.y);     }
    void GetNbpoint()
    {
        System.out.println("Il y a " + nbpoint +" point(s) créé(s)");
    }
}