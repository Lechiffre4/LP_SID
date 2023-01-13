package SQLMenu;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Create extends JPanel implements ActionListener {

    JLabel Title = new JLabel("Create", SwingConstants.CENTER);
    JButton homebtn = new JButton("Back to home");

    JLabel instruction = new JLabel("Enter the informations to create a new minibus");
    JTextField inputID = new JTextField("Enter the ID");
    JTextField inputCapacity = new JTextField("Enter the capacity");
    JPanel Input = new JPanel(new BorderLayout());

    JButton Submit = new JButton("Submit");
    Create()
    {

        this.setLayout(new GridLayout(4,1));
        this.add(Title);
        this.add(Input);

        Input.add(instruction, BorderLayout.NORTH);
        Input.add(inputID,BorderLayout.WEST);
        Input.add(inputCapacity, BorderLayout.EAST);

        this.add(Submit);
        this.add(homebtn);

        homebtn.addActionListener(this);
        Submit.addActionListener(this);

    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource()== homebtn)
        {
            Menu.SwitchPage("home");
        }
        if(e.getSource()==Submit)
        {

        }
    }
}
