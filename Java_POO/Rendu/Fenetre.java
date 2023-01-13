import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import java.util.ArrayList;

public class Fenetre extends JFrame {

    ////////////JPanels////////////
    JPanel General = new JPanel();
    JPanel Grille = new JPanel();
    JPanel Infos = new JPanel();
    ///////////////////////////////

    ////////////Menu///////////////
    JMenuBar Menu = new JMenuBar();
    JMenu Options = new JMenu("Options");
    JMenu Aide = new JMenu("Aide");

    ///////////////////////////////

    //////////Grille///////////////
    ArrayList<JButton> ListButton = new ArrayList<JButton>();
    public Fenetre()
    {
        //Initialisation
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
        this.setUndecorated(false);
        this.setTitle("QuineLoto");
        this.setVisible(true);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        this.setContentPane(General);
        General.setLayout(new BorderLayout());
        General.setBorder(new EmptyBorder(100,200,200,200));
        ///////////////////////////

        //Ajout du menu
        Menu.add(Options);
        Menu.add(Aide);
        this.setJMenuBar(Menu);
        ///////////////////////////

        //Création et Ajout de la grille
        GridLayout grid = new GridLayout(9,11);
        grid.setHgap(2);
        grid.setVgap(2);
        Grille.setLayout(grid);
        Grille.setSize(500,500);
        General.add(Grille,BorderLayout.CENTER);
        for(int i = 1 ; i<=90; i++)
        {
            JButton button = new JButton(Integer.toString(i));
            button.setSize(20,20);
            ListButton.add(button);
            Grille.add(button);
        }
        //////////////////////////

        // Creation et Placement des informations du jeu
        Infos.setLayout(new BorderLayout());
        General.add(Infos, BorderLayout.NORTH);

        JPanel LeftInfos = new JPanel();
        JPanel RightInfos = new JPanel();
        Infos.add(LeftInfos, BorderLayout.WEST);
        Infos.add(RightInfos, BorderLayout.EAST);

        JLabel LastChoose = new JLabel("Dernier Sorti ");
        JLabel LastNumber = new JLabel("test");
        LastNumber.setPreferredSize(new Dimension(50,50));
        LastNumber.setOpaque(true);
        LastNumber.setBackground(Color.white);


        JLabel Current = new JLabel("En cours :");
        JLabel CurrentNumber = new JLabel("test");
        CurrentNumber.setPreferredSize(new Dimension(50,50));
        CurrentNumber.setBackground(Color.white);
        CurrentNumber.setOpaque(true);
        JButton Cancel = new JButton("Annuler");

        LeftInfos.add(LastChoose);LeftInfos.add(LastNumber);

        RightInfos.add(Current); RightInfos.add(Cancel); RightInfos.add(CurrentNumber);

        //////////////////////////////

    }
}
