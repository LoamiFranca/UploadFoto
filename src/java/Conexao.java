
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author gabriel
 */
public class Conexao {
    static Connection con=null;
/**
*
Construtor
*/
public Conexao() {
super();
}
//cria conexao com o banco de dados
public static Connection createConnection(String banco) throws Exception {try {
// instanciando o driver
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection
("jdbc:mysql://localhost:3306/"+banco, "root", "1234");
//("jdbc:mysql://192.168.43.81:3306/"+banco, "root", "");
}catch (ClassNotFoundException e) {
throw new Exception("Driver nao encontrado");
}catch (SQLException e) {
throw new Exception("Erro com o banco de dados");
}
return con;
}
// fecha a conexao

}
    

