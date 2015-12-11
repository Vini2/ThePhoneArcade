<%-- 
    Document   : Admin-ViewStock
    Created on : Nov 4, 2013, 5:47:13 PM
    Author     : Asus
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.Make"%>
<%@page import="HibernateClasses.UserLogin"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="HibernateClasses.Product"%>
<%@page import="org.hibernate.Criteria"%>
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

        <div class="content"><h2>View Stocks</h2></div>
        <br>

        <div class="content">

            <form method="POST" action="Admin-ViewStock.jsp">

                <table align="center" border="0">
                    <tr>
                        <td>Select Category</td>
                        <td>:</td>
                        <td>
                            <select name="make" style="width: 303px" id="idmake" class="text" >
                                <%
                                    Session s = PoolManager.getSessionFactory().openSession();
                                    Criteria c1 = s.createCriteria(Make.class);
                                    List<Make> lm = c1.list();
                                    for (Make m : lm) {
                                %>
                                <option value="<%=m.getMakeName()%>"><%=m.getMakeName()%></option>
                                <%}%>

                            </select>
                        </td>
                        <td>&nbsp;&nbsp;<input type="submit" value="LOAD" class="button1" style="width: 100px"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"></td>
                        <td colspan="2"><div id="make_msg" style="font-size: 12px; color: red"></div></td>
                    </tr>
                </table>
            </form>
        </div>
        <br><br>

        <%
            if (request.getParameter("make") != null) {


        %>

        <div class="details">
            <table border="0">

                <tr>
                    <th width="150">Product ID</th>
                    <th width="150">Product Name</th>
                    <th width="150">Category</th>
                    <th width="150">Image</th>
                    <th width="150">Available Quantity</th>
                    <th width="150"></th>
                </tr>


                <%
                    Criteria c2 = s.createCriteria(Make.class);
                    c2.add(Restrictions.eq("makeName", request.getParameter("make")));
                    Make m = (Make) c2.uniqueResult();

                    Criteria c = s.createCriteria(Product.class);
                    c.add(Restrictions.eq("make", m));
                    c.addOrder(Order.asc("availableQty"));

                    List<Product> list = c.list();

                    for (Product p : list) {



                        double d = p.getAvailableQty();
                        int qty1 = (int) d;

                %>



                <tr>
                    <td width="150"><%=p.getIdproduct()%></td>
                    <td width="250"><%=p.getMake().getMakeName() + " " + p.getName()%></td>
                    <td width="150"><%=p.getCategory().getCategoryName()%></td>
                    <td width="150" align="center"><img src="<%=p.getImagePath()%>" height="100" width="auto"/></td>
                    <td width="150" align="center"><%=qty1%></td>
                    <td style="color: red" align="center">
                        <%if (p.getAvailableQty() <= 10) {%>
                        <div class="content" style="color: red"><b>LOW STOCK</b></div>
                        <%}%>
                    </td>
                </tr>

                <%}%>

            </table>
        </div>
        <%}%>
    </center>
    <br><br>
    <hr>
    <%}%>
</body>
</html>
