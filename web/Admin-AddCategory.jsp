<%-- 
    Document   : Admin-AddCategory
    Created on : Oct 31, 2013, 8:21:04 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.UserLogin"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="HibernateClasses.Category"%>
<%@page import="HibernateClasses.PoolManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TPA - Admin Panel</title>

        <link rel="stylesheet" href="css/newAdmin.css" />

        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
            if (ul == null) {
                response.sendRedirect("SignIn.jsp?msg=Please login and continue");
            } else if (!ul.getUser().getUserType().getTypeName().equals("Admin")) {
                response.sendRedirect("SignIn.jsp?msg=Restricted... Only administrators allowed");
            } else {
        %>



    </head>
    <body>
    <center>

        <table border="0" width="100%">
            <tr>
                <td><a href="AdminPanel.jsp" title="Admin Panel"><img src="AdminImages/tpa head.gif" /></a></td>
                <td align="right">
                    <font style="font-family:'Arial'; font-size:12px">
                    <a href="Home.jsp" class="alink">Home</a>&nbsp;&nbsp;<br>
                    <a href="AdminSignOut" class="alink">Sign Out</a>&nbsp;&nbsp;
                    </font>
                </td>
            </tr>
        </table>
        <hr>

        <div class="content"><h2>Add New Category</h2></div>

        <form method="POST" action="AdminAddCategory">
            <div class="register">
                <table border="0">
                    <tr>
                        <td colspan="3"><b>Available Categories</b></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td colspan="3">
                            <ul>
                                <%
                                    Session s = PoolManager.getSessionFactory().openSession();
                                    Criteria c = s.createCriteria(Category.class);
                                    List<Category> lc = c.list();

                                    for (Category c1 : lc) {
                                %>
                                <li><%=c1.getCategoryName()%></li>
                                    <%}%>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3"><br></td>
                    </tr>
                    <tr>
                        <td>Category</td>
                        <td>:</td>
                        <td><input type="text" name="category" value="" style="width: 250px" id="idcategory" class="text"/></td>
                    </tr>

                    <tr>
                        <td colspan="3" align="right"><br><input type="submit" value="ADD CATEGORY" class="button1"/></td>
                    </tr>
                </table>
            </div>
        </form>

        <br>

        <div class="content" style="color: #660000">
            <%
                if (request.getParameter("msg") != null) {
                    if (request.getParameter("msg").equals("Error1")) {
            %>
            Please enter a category name.
            <%} else if (request.getParameter("msg").equals("Error2")) {%>
            Category entered already exists.
            <%} else if (request.getParameter("msg").equals("Success")) {%>
            Category added successfully...!
            <%}
                        }%>
        </div>

        <br>

    </center>

    <%}%>
</body>
</html>

