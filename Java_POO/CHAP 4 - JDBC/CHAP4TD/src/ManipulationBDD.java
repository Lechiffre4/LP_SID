import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.*;

public class ManipulationBDD {

    public void select() throws SQLException {
        //Installation drivers
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

        //Connexion à la base de données
        Connection connection = DriverManager.getConnection
                ("jdbc:oracle:thin:@iutdoua-ora.univ-lyon1.fr:1521:cdb1", "p2210384", "676650");

        //Creation du statement
        Statement stmt=connection.createStatement();
        ResultSet rs = stmt.executeQuery("select * from Minibus order by NUMB");
        System.out.println("---------------");
        System.out.println("| ID | Capacité |");
        System.out.println("---------------");
        while (rs.next()) {
            System.out.println("| " + rs.getInt(1) + " | " + rs.getString(2)+" |");
            System.out.println("---------------");
        }
        System.out.println("\n \n");
        connection.close();
    }

    public void insert(int id, int capacity) throws SQLException {
        //Installation drivers
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

        //Connexion à la base de données
        Connection connection = DriverManager.getConnection
                ("jdbc:oracle:thin:@iutdoua-ora.univ-lyon1.fr:1521:cdb1", "p2210384", "676650");

        //Creation du statement
        Statement stmt=connection.createStatement();
        int rs = stmt.executeUpdate("Insert into MINIBUS(NumB, Capacite) values ("+id+", "+capacity+")");
        System.out.println(rs + " Lignée(s) ajoutée(s)\n\n");
        connection.close();
    }

    public void modify(int id, int capacity) throws SQLException {
        //Installation drivers
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

        //Connexion à la base de données
        Connection connection = DriverManager.getConnection
                ("jdbc:oracle:thin:@iutdoua-ora.univ-lyon1.fr:1521:cdb1", "p2210384", "676650");

        //Creation du statement
        Statement stmt=connection.createStatement();
        int rs = stmt.executeUpdate("Update MINIBUS set CAPACITE = "+capacity+" where NUMB = "+id);

        System.out.println(rs + " Lignée(s) modifiée(s)\n\n");
        connection.close();
    }

}
