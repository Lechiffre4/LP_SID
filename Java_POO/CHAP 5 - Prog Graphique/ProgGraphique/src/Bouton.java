import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.JButton;

public class Bouton extends JButton implements MouseListener{
    private String nom;

    public Bouton(String nom)
    {
        super(nom);
        this.nom=nom;
        this.addMouseListener(this);
    }



    public void mouseClicked(MouseEvent e)
    {
        System.out.println("clic de la souris "+this.nom);
    }
    public void mousePressed(MouseEvent e) {
        System.out.println("clic gauche de la souris"+this.nom);
    }

    public void mouseReleased(MouseEvent e) {
        System.out.println("relache du clic de la souris"+this.nom);
    }

    public void mouseEntered(MouseEvent e) {
        System.out.println("survol de la souris"+this.nom);
    }

    public void mouseExited(MouseEvent e) {}

}