public class Exemple2 {
    private int x;
    private int y;
    static int nbpoint;
    Exemple2()
    {
        this.x=0;         this.y=0;
        nbpoint++;
    }
    Exemple2 (int abs, int ord)
    {
        this.x = abs;         this.y = ord;
        nbpoint++;
    }
    void deplace (int dx, int dy)
    {
        this.x = this.x + dx;         this.y = this.y + dy;
    }
    void affiche()
    {         System.out.println("Les coordonn�es sont : (" + this.x +";" + this.y +")");     }
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
        System.out.println("Il y a " + nbpoint +" point(s) cr��(s)");
    }
}
