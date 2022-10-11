/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package chap1lesbases;

import java.util.Scanner;

/**
 *
 * @author p2210384
 */
public class Chap1lesbases {

   public static void main(String[] args) {
        // Déclaration des variables
        int choix=0;
        Scanner sc = new Scanner(System.in);
        float nb1,nb2,res;
        String op;
        double tab[] = new double[10];
        double elem;
        int ind;

        
        while(choix!=4)
        {
                // Menu
            System.out.println("Que souhaitez-vous faire ?") ;
            System.out.println("Pour faire des calculs taper 1") ;
            System.out.println("Pour saisir le contenu d’un tableau à une dimension taper 2") ;
            System.out.println("Pour afficher le contenu du tableau à une dimension taper 3") ;
            System.out.println("Pour sortir taper 4") ;

            choix = sc.nextInt();
        
            switch(choix)
            {
                case 1:
                    System.out.println("Saisir le premier nombre") ;
                    nb1 = sc.nextFloat();
                    System.out.println("Saisir le deuxième nombre") ;
                    nb2 = sc.nextFloat();
                    System.out.println("Saisir l’opération que vous souhaitez faire ( *, - , +, /)")	;
                    sc.nextLine();
                    op = sc.nextLine();
                    System.out.println("operateur"+op)	;
                    res=0;
                    if (op.equals("*"))
                            { res=nb1*nb2 ;}
                    else if (op.equals("-"))
                            { res=nb1-nb2 ;}
                    else if (op.equals("+"))
                            { res=nb1+nb2 ;}
                    else if (op.equals("/"))
                            { res=nb1/nb2 ;}
                    System.out.println(nb1 + " " + op + " " + nb2 + " = " + res) ;
                    break;
                    
                case 2:
                    System.out.println("Votre tableau contiendra 10 éléments");
                    for(int i=0 ;i<10 ;i++)
                    {
                        System.out.println("Elément à l’indice " + i +" ?") ;
                        elem = sc.nextDouble();
                        tab[i]=elem;
                    }
                    break;
                    
                case 3:
                    System.out.println("Contenu de votre tableau :");
                    ind=0;
                    while(ind<tab.length)
                    {
                        System.out.println("Elément à l’indice " + ind  +" : " + tab[ind]) ;
                        ind++;
                    }
                    break;
            }
        }
    }

    
}
