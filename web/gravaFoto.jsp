
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert an Image into MySQL Database</title>
    </head>
    <body>
        <h1>Insert an Image into MySQL Database!</h1>
        <% try {
//                Connection conn = null;
//                PreparedStatement pstmt = null;
                ResultSet rs = null;
//            String url = "jdbc:mysql://192.168.43.81:3306/test";//Here the "test" is the Database name
                String url = "jdbc:mysql://localhost:3306/test";//Here the "test" is the Database name
//                FileInputStream fis = null;

//                Class.forName("com.mysql.jdbc.Driver").newInstance();

                InputStream inputStream = null; // input stream of the upload file

                // obtains the upload file part in this multipart request
                Part filePart = request.getPart("foto");
                if (filePart != null) {
                    // prints out some information for debugging
                    System.out.println(filePart.getName());
                    System.out.println(filePart.getSize());
                    System.out.println(filePart.getContentType());

                    // obtains input stream of the upload file
                    inputStream = filePart.getInputStream();
                }

                Connection conn = null; // connection to the database
                String message = null;  // message will be sent back to client

                try {
                    // connects to the database
                    DriverManager.registerDriver(new com.mysql.jdbc.Driver());
                    conn = DriverManager.getConnection(url, "root", "1234");

                    // constructs SQL statement
                    String sql = "INSERT INTO image (image) values (?)";
                    PreparedStatement statement = conn.prepareStatement(sql);

                    if (inputStream != null) {
                        // fetches input stream of the upload file for the blob column
                        statement.setBlob(3, inputStream);
                    }

                    // sends the statement to the database server
                    int row = statement.executeUpdate();
                    if (row > 0) {
                        message = "File uploaded and saved into database";
                    }
                } catch (SQLException ex) {
                    message = "ERROR: " + ex.getMessage();
                    ex.printStackTrace();
                } finally {
                    if (conn != null) {
                        // closes the database connection
                        try {
                            conn.close();
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }
                    // sets the message in request scope
                    request.setAttribute("Message", message);

                    // forwards to the message page
                    getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
                }

//                File image = new File(request.getParameter("foto"));
//                pstmt = conn.prepareStatement("insert into image(image) " + "values(?)");
//                fis = new FileInputStream(image);
//                pstmt.setBinaryStream(1, (InputStream) fis, (int) (image.length()));
//
//                int count = pstmt.executeUpdate();
//                if (count > 0) {
//                    System.out.println("The image has been inserted successfully");
//                } else {
//                    System.out.println("The image did not insert successfully");
//                }
//                Statement stm = conn.createStatement();
//                rs = stm.executeQuery("SELECT * FROM image");%>
        <table id="tab" style="border:1px"><%
            while (rs.next()) {
            %>
            <tr style="background-color:  antiquewhite">
                <td>
                    <%
// pegando o conteudo do campo foto (BLOB, binario)
                        Blob blob = rs.getBlob("image");
//                        byte[] imgData = blob.getBytes(1, (int) image.length());

                        response.setContentType("image/gif");

                        OutputStream o = response.getOutputStream();

//                        o.write(imgData);
                        o.flush();

                    %>
                </td>
            </tr>
            <%}%>
        </table>      
        <%
//                if (rs != null) {
//                    rs.close();
//                    rs = null;
//                }
//                if (pstmt != null) {
//                    pstmt.close();
//                    pstmt = null;
//                }
//                if (conn != null) {
//                    conn.close();
//                    conn = null;
//                }
//            } catch (Exception ex) {
//                ex.printStackTrace();
//            }
        %>


    </body>
</html>