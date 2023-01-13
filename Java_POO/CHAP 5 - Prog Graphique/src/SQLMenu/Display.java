package SQLMenu;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Display extends JPanel implements ActionListener {

    JLabel Title = new JLabel("Display", SwingConstants.CENTER);
    JButton homebtn = new JButton("Back to home");
    JButton GetInfos = new JButton("Search Minibus");

    JLabel Output = new JLabel();


    Display()
    {
        this.setLayout(new GridLayout(4,1));
        this.add(Title);
        this.add(Output);

        this.add(GetInfos);
        this.add(homebtn);
        homebtn.addActionListener(this);
        GetInfos.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource()== homebtn)
        {
            Menu.SwitchPage("home");
        }
        if(e.getSource()==GetInfos)
        {

        }
    }
}
