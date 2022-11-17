import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Fenetre extends JFrame implements ActionListener {
    JLabel TextResult = new JLabel("");
    //panel
    JPanel General = new JPanel();
    JPanel Result = new JPanel();
    JPanel pan = new JPanel();
    JPanel Op = new JPanel();

    //Buttons
    BoutonAction btn1 = new BoutonAction("1");

    BoutonAction btn2 = new BoutonAction("2");
    BoutonAction btn3 = new BoutonAction("3");
    BoutonAction btn4 = new BoutonAction("4");
    BoutonAction btn5 = new BoutonAction("5");
    BoutonAction btn6 = new BoutonAction("6");
    BoutonAction btn7 = new BoutonAction("7");
    BoutonAction btn8 = new BoutonAction("8");
    BoutonAction btn9 = new BoutonAction("9");
    BoutonAction btn0 = new BoutonAction("0");
    BoutonAction btnEqual = new BoutonAction("=");



    BoutonAction btnPlus = new BoutonAction("+");
    BoutonAction btnMoins = new BoutonAction("-");
    BoutonAction btnFois = new BoutonAction("*");
    BoutonAction btnDivide = new BoutonAction("/");


    public Fenetre()
    {
        this.setSize(300,150);
        this.setTitle("Calculatrice");
        this.setVisible(true);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);


        this.setContentPane(General);
        General.setLayout(new BorderLayout());


        //Text
        General.add(Result,BorderLayout.NORTH);
        Result.add(TextResult);


        //Numbers
        pan.setLayout(new GridLayout(4,3));
        pan.setSize(300,200);
        General.add(pan, BorderLayout.CENTER);
        pan.add(btn1);
        pan.add(btn2);
        pan.add(btn3);
        pan.add(btn4);
        pan.add(btn5);
        pan.add(btn6);
        pan.add(btn7);
        pan.add(btn8);
        pan.add(btn9);
        pan.add(btn0);
        pan.add(btnEqual);

        //Operation
        General.add(Op,BorderLayout.EAST);
        Op.setLayout(new GridLayout(4,1));
        Op.setSize(250,200);
        Op.add(btnPlus);
        Op.add(btnMoins);
        Op.add(btnDivide);
        Op.add(btnFois);

        btn1.addActionListener(this);
        btn2.addActionListener(this);
        btn3.addActionListener(this);
        btn4.addActionListener(this);
        btn5.addActionListener(this);
        btn6.addActionListener(this);
        btn7.addActionListener(this);
        btn8.addActionListener(this);
        btn9.addActionListener(this);
        btn0.addActionListener(this);
        btnEqual.addActionListener(this);

        btnPlus.addActionListener(this);
        btnMoins.addActionListener(this);
        btnFois.addActionListener(this);
        btnDivide.addActionListener(this);
    }


    public void actionPerformed(ActionEvent arg0)
    {

        //Chiffres
        if(arg0.getSource() == btn1)
        {
            btn1.setOperation(1);

        }
        if(arg0.getSource() == btn2)
        {
            btn2.setOperation(2);
        }
        if(arg0.getSource() == btn3)
        {
            btn3.setOperation(3);

        }
        if(arg0.getSource() == btn4)
        {
            btn4.setOperation(4);

        }
        if(arg0.getSource() == btn5)
        {
            btn5.setOperation(5);

        }
        if(arg0.getSource() == btn6)
        {
            btn6.setOperation(6);

        }
        if(arg0.getSource() == btn6)
        {
            btn6.setOperation(6);

        }
        if(arg0.getSource() == btn7)
        {
            btn7.setOperation(7);

        }
        if(arg0.getSource() == btn8)
        {
            btn8.setOperation(8);

        }
        if(arg0.getSource() == btn9)
        {
            btn9.setOperation(9);

        }
        if(arg0.getSource() == btn0)
        {
            btn0.setOperation(0);

        }



        //Operations
        if(arg0.getSource() == btnPlus)
        {
            btnPlus.setOperation(100);
        }
        if(arg0.getSource() == btnMoins)
        {
            btnMoins.setOperation(101);
        }
        if(arg0.getSource() == btnFois)
        {
            btnFois.setOperation(102);
        }
        if(arg0.getSource() == btnDivide)
        {
            btnDivide.setOperation(103);
        }


        if(arg0.getSource() == btnEqual)
        {
            int[] op = btnEqual.getOperation();

            if(op[1] == 100)
            {
                int calc = op[0]+op[2];
                TextResult.setText(op[0] + " + " + op[2]+" = " + calc);
            }
            if(op[1] == 101)
            {
                int calc = op[0]-op[2];
                TextResult.setText(op[0] + " - " + op[2]+" = " + calc);
            }
            if(op[1] == 102)
            {
                int calc = op[0]*op[2];
                TextResult.setText(op[0] + " * " + op[2]+" = " + calc);
            }
            if(op[1] == 103)
            {
                float calc = (float)op[0]/ (float)op[2];
                TextResult.setText(op[0] + " / " + op[2]+" = " + calc);
            }

        }
    }
}
