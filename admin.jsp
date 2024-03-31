<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Connection Test</title>
</head>
<body>
    <%
        String driver = "com.mysql.cj.jdbc.Driver";
        String user = "administrator";
        String password = "Niti#@123";
        String url = "jdbc:mysql://localhost:3306/MyDB?useSSL=false&allowPublicKeyRetrieval=true";
        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, user, password);
            if (con != null) {
                out.print("<h3 style='color:green;text-align:center;'>WELCOME TO BOOK HEAVEN.</h3>");
                out.print("<hr>");         
                String sqlAllBooks = "SELECT * FROM books";
                PreparedStatement pstAllBooks = con.prepareStatement(sqlAllBooks);
                ResultSet rsAllBooks = pstAllBooks.executeQuery();
                out.print("<center><table border='1'>");
                out.print("<thead><tr><th>BookCode</th><th>BookName</th><th>Author</th><th>Price</th></tr></thead>");
                out.print("<tbody>");
                while (rsAllBooks.next()) {
                    out.print("<tr><td>" + rsAllBooks.getInt(1) + "</td><td>" + rsAllBooks.getString(2) + "</td>"+ "<td>" + rsAllBooks.getString(3) + "</td><td>" + rsAllBooks.getDouble(4) + "</td></tr>");
                }
                out.print("</tbody>");
                out.print("</table></center>");
                String sqlCountBooks = "SELECT COUNT(*) FROM books";
                PreparedStatement pstCountBooks = con.prepareStatement(sqlCountBooks);
                ResultSet rsCountBooks = pstCountBooks.executeQuery();
                rsCountBooks.next(); 
                out.print("<h3>Total Books: " + rsCountBooks.getInt(1) + "</h3>");
                String sqlAvgPrice = "SELECT AVG(PRICE) FROM books";
                PreparedStatement pstAvgPrice = con.prepareStatement(sqlAvgPrice);
                ResultSet rsAvgPrice = pstAvgPrice.executeQuery();
                rsAvgPrice.next();
                out.print("<h3>Average Price: " + rsAvgPrice.getDouble(1) + "</h3>");

                String sqlHighPriceBook = "SELECT TITLE, PRICE FROM books WHERE PRICE = (SELECT MAX(PRICE) FROM books)";
                PreparedStatement pstHighPriceBook = con.prepareStatement(sqlHighPriceBook);
                ResultSet rsHighPriceBook = pstHighPriceBook.executeQuery();
                if (rsHighPriceBook.next()) {
                    out.print("<h3>HIGH COST BOOK : " + rsHighPriceBook.getString(1) + " PRICE : "+ rsHighPriceBook.getDouble(2) + "</h3>");
                }
                con.close(); 
            } else {
                out.print("<h3 style='color:yellow'>Unable to connect to database.</h3>");
            }
        } catch (Exception e) {
            out.print("<h3 style='color:red'>Unable to connect to database.</h3>");
            out.print("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    %>
</body>
</html>
