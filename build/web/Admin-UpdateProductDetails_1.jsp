<%-- 
    Document   : Admin-UpdateProductDetails_1
    Created on : Nov 11, 2013, 10:59:41 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.UserLogin"%>
<%@page import="HibernateClasses.Product"%>
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

        <%
            Session s = PoolManager.getSessionFactory().openSession();
            Product p = (Product) s.load(Product.class, Integer.parseInt(request.getParameter("pid")));

        %>


        <div class="content"><h1>Update Product Details</h1></div>

        <form action="AdminUpdateProductDetails" method="POST">

            <div class="register">
                <input type="hidden" name="pid" value="<%=p.getIdproduct()%>" />
                <table border="0">
                    <tr>
                        <td>Make</td>
                        <td>:</td>
                        <td><%=p.getMake().getMakeName()%></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_make" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Category</td>
                        <td>:</td>
                        <td><%=p.getCategory().getCategoryName()%></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_category" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Name/Model</td>
                        <td>:</td>
                        <td><input type="text" name="name" value="<%=p.getName()%>" style="width: 250px" id="idname"  class="text" onclick="removeBorder('name')" onkeypress="removeBorder('name')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_name" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Description</td>
                        <td>:</td>
                        <td><textarea name="desc" rows="4" cols="20" style="width: 247px" id="iddesc"  class="text" onclick="removeBorder('desc')" onkeypress="removeBorder('desc')"><%=p.getGeneralDescription()%></textarea></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_desc" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Special Price</td>
                        <td>:</td>
                        <%
                            double d2 = p.getSpecialPrice();
                            int sprice = (int) d2;
                        %>
                        <td><input type="text" name="sprice" value="<%= sprice%>" style="width: 250px" id="idsprice" class="text" onclick="removeBorder('sprice')" onkeypress="removeBorder('sprice')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_sprice" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Customer Price</td>
                        <td>:</td>
                        <%
                            double d1 = p.getCustomerPrice();
                            int cprice = (int) d1;
                        %>
                        <td><input type="text" name="cprice" value="<%= cprice%>" style="width: 250px" id="idcprice"  class="text" onclick="removeBorder('cprice')" onkeypress="removeBorder('cprice')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_cprice" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Status</td>
                        <td>:</td>
                        <td>
                            <select name="status">
                                <%
                                    if (p.getStatus().equals("Available")) {
                                %>
                                <option value="Available" selected="">Available</option>
                                <option value="Unavailable">Unavailable</option>
                                <%} else {%>
                                <option value="Available">Available</option>
                                <option value="Unavailable" selected="">Unavailable</option>
                                <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_desc" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td colspan="3" align="right"><input type="submit" value="UPDATE" class="button1"/></td>
                    </tr>
                </table>

            </div>
        </form>


    </center>

    <%}%>
</body>
</html>

