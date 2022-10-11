/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package chap2poo;

public class Exemple1 {
    private int x;
    private int y;
    Exemple1()
    {
        x=0;
        y=0;
    }
    Exemple1 (int abs, int ord)
    {
        x = abs;
        y = ord;
    }
    void deplace (int dx, int dy)
    {
        x = x + dx;
        y = y + dy;
    }
    void affiche()
    {
        System.out.println("Les coordonnées sont : (" + x +";" + y +")");
    }
    void SetX(int val1)
    {
        x=val1;
    }
    void SetY(int val2)
    {
        y=val2;
    }
    int GetX()
    {
        return(x);
    }       
    int GetY()
    {
        return(y);
    }  

}
