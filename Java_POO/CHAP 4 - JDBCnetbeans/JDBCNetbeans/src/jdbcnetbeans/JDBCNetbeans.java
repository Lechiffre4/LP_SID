/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jdbcnetbeans;
import java.sql.*;

/**
 *
 * @author p2210384
 */
public class JDBCNetbeans {

    public static void main(String[] args) throws SQLException{
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        
    }

}
