import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.border.CompoundBorder;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

public class Fenetre extends JFrame implements ActionListener {

    ////////////JPanels////////////
    JPanel General = new JPanel();
    JPanel Grille = new JPanel();
    JPanel Infos = new JPanel();
    ///////////////////////////////

    ////////////Menu///////////////
    JMenuBar Menu = new JMenuBar();
    JMenu Options = new JMenu("Options");
    JMenuItem Restart = new JMenuItem("Restart");
    JMenuItem Quit = new JMenuItem("Quit");
    JMenu Aide = new JMenu("Aide");

    ///////////////////////////////

    ////////////Top informations//////////////////
    JLabel LastChoose = new JLabel("Dernier Sorti :");
    JLabel LastNumber = new JLabel("0", SwingConstants.CENTER);
    JLabel Current = new JLabel("En cours :", SwingConstants.RIGHT);
    JLabel CurrentNumber = new JLabel("0", SwingConstants.CENTER);
    JButton Cancel = new JButton("Annuler");
    JPanel LeftInfos = new JPanel();
    JPanel RightInfos = new JPanel();
    JPanel RightInfosColumn = new JPanel();
    //////////////////////////////////////////

    //////////////////////Grille///////////////////////
    ArrayList<JButton> ListButton = new ArrayList<JButton>();
    ///////////////////////////////////////////////////

    /////////////////////Actions/////////////////////
    JButton OldButton = null;
    JButton Currentbtn = null;
    ArrayList<JButton> historic = new ArrayList<JButton>();

    ////////////////////////////////////////////////
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
        Restart.addActionListener(this);
        Quit.addActionListener(this);
        Options.add(Restart);
        Options.add(Quit);
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
            button.addActionListener(this);
        }
        //////////////////////////

        // Creation et Placement des informations du jeu
        Infos.setLayout(new BorderLayout());
        General.add(Infos, BorderLayout.NORTH);


        Infos.add(LeftInfos, BorderLayout.WEST);
        Infos.add(RightInfos, BorderLayout.EAST);
        Infos.setBorder(new CompoundBorder(Infos.getBorder(), new EmptyBorder(0,50,20,50)));


        LastNumber.setPreferredSize(new Dimension(50,50));
        LastNumber.setOpaque(true);
        LastNumber.setBackground(Color.white);
        LastNumber.setBorder(BorderFactory.createLineBorder(Color.black, 1));
        LastNumber.setFont(new Font(LastNumber.getFont().getName(), Font.BOLD,15));


        CurrentNumber.setPreferredSize(new Dimension(75,75));
        CurrentNumber.setBackground(Color.white);
        CurrentNumber.setBorder(BorderFactory.createLineBorder(Color.black, 1));
        CurrentNumber.setOpaque(true);
        CurrentNumber.setFont(new Font(CurrentNumber.getFont().getName(), Font.BOLD,25));

        Cancel.addActionListener(this);

        RightInfosColumn.setLayout(new BorderLayout());

        LeftInfos.add(LastChoose);LeftInfos.add(LastNumber);

        RightInfos.add(RightInfosColumn); RightInfos.add(CurrentNumber);
        RightInfosColumn.add(Current, BorderLayout.SOUTH);RightInfosColumn.add(Cancel,BorderLayout.NORTH);

        Border border = Current.getBorder();
        Border margin = new EmptyBorder(25,0,0,0);
        Current.setBorder(new CompoundBorder(border, margin));

        //////////////////////////////

    }
    public void Restart(){
        CurrentNumber.setText("0");
        LastNumber.setText("0");
        Currentbtn = null;
        for ( JButton i : historic)
        {
            i.setEnabled(true);
            i.setBackground(null);

        }
        historic = new ArrayList<>();
    }

    public void Quit(){
        System.exit(0);
    }
    @Override
    public void actionPerformed(ActionEvent arg0) {
        System.out.println(arg0.getActionCommand());



        if(arg0.getActionCommand() == "Restart")
        {
            Restart();
        }
        if(arg0.getActionCommand() == "Quit")
        {
            Quit();
        }
        else
        {
            if (historic.size() == 0 && arg0.getActionCommand() != "Annuler")
            {
                Currentbtn = (JButton) arg0.getSource();
                Currentbtn.setBackground(Color.blue);
                CurrentNumber.setText(Currentbtn.getText());
                Currentbtn.setEnabled(false);
                historic.add(Currentbtn);
            }
            else if (arg0.getActionCommand() == "Annuler")
            {

                System.out.println(historic.size());
                Currentbtn.setEnabled(true);
                Currentbtn.setBackground(null);
                historic.remove(historic.size() - 1);
                Currentbtn = historic.get(historic.size() - 1);
                for (JButton i : historic) {
                    if (i == historic.get(historic.size() - 1)) {
                        i.setBackground(Color.blue);
                        CurrentNumber.setText(i.getText());
                        LastNumber.setText(historic.get(historic.size() - 2).getText());
                    }
                }

            }
            else
            {
                LastNumber.setText(Currentbtn.getText());
                Currentbtn = (JButton) arg0.getSource();
                Currentbtn.setBackground(Color.blue);
                CurrentNumber.setText(Currentbtn.getText());
                Currentbtn.setEnabled(false);
                for (JButton i : historic)
                {
                    i.setEnabled(false);
                    i.setBackground(Color.red);
                }
                historic.add(Currentbtn);

            }

        }


    }
}
