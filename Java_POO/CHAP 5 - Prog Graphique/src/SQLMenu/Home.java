package SQLMenu;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class Home extends JPanel implements ActionListener {

    String[] choices = {"display", "update","create","delete"};
    JComboBox listBox = new JComboBox(choices);
    Home()
    {
        this.setLayout(new BorderLayout());
        JLabel Title = new JLabel("SQLMenu", SwingConstants.CENTER);
        JButton Submit = new JButton("Submit");
        Submit.addActionListener(this);

        listBox.setSize(100,200);
        this.add(Title, BorderLayout.NORTH);
        this.add(listBox, BorderLayout.CENTER);
        this.add(Submit, BorderLayout.SOUTH);
    }


    @Override
    public void actionPerformed(ActionEvent e) {
        Menu.SwitchPage((String)listBox.getSelectedItem());
    }
}
