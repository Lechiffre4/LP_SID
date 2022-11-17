import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

public class BoutonAction extends JButton {
    private String nom;
    static int[] operation = new int[3];
    static int ind = 0;
    public BoutonAction(String nom){
        super(nom);
        this.nom=nom;
    }

    public String getNom(){
        return (this.nom);
    }

    public static void setOperation(int val)
    {
        operation[ind] = val;
        ind= ind+1;
        if(ind == 3){
            ind =0;
        };
    }

    public static int[] getOperation()
    {
        return operation;
    }

}

