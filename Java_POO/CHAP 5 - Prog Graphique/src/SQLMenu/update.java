package SQLMenu;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Update extends JPanel implements ActionListener {

    JLabel Title = new JLabel("Update", SwingConstants.CENTER);
    JButton homebtn = new JButton("Back to home");

    JLabel instruction = new JLabel("Enter the informations to update a minibus");
    JTextField inputID = new JTextField("Enter the ID");
    JTextField inputCapacity = new JTextField("Enter the capacity");
    JPanel Input = new JPanel(new BorderLayout());

    JButton Submit = new JButton("Submit");
    Update()
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
