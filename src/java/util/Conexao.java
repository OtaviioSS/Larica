package util;

import java.sql.*;
import com.mysql.jdbc.Driver;

/**
 *
 * @author hugov
 */
public class Conexao {

    public Connection conectar() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            //localhost
            return DriverManager.getConnection("jdbc:mysql://localhost/projeto?useTimezone=true&serverTimezone=UTC&user=root&password=");
            
            //Web
            //return DriverManager.getConnection("jdbc:mysql://node58233-larica.jelastic.saveincloud.net//larica?useTimezone=true&serverTimezone=UTC&user=root&password=ONHear10692");
            
            
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
