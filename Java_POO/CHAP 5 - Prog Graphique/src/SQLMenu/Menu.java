package SQLMenu;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Menu extends JFrame{


    static CardLayout cardLayout = new CardLayout();
    static JPanel mainPanel = new JPanel(cardLayout);

    Home home = new Home();
    Display display = new Display();
    Update update = new Update();
    Create create = new Create();
    Delete delete = new Delete();



    public Menu() {
        mainPanel.add(home, "home");
        mainPanel.add(display,"display");
        mainPanel.add(update,"update");
        mainPanel.add(create,"create");
        mainPanel.add(delete,"delete");


        add(mainPanel);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        pack();
        setLocationByPlatform(true);
        setVisible(true);

    }

    public static void  SwitchPage(String page)
    {
        cardLayout.show(mainPanel,page);
    }

}

