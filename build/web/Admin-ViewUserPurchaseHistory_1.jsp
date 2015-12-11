<%-- 
    Document   : Admin-ViewUserPurchaseHistory_1
    Created on : Nov 4, 2013, 3:53:22 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.UserLogin"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="java.util.List"%>
<%@page import="HibernateClasses.ProductInContainer"%>
<%@page import="HibernateClasses.ProductInContainer"%>
<%@page import="HibernateClasses.Container"%>
<%@page import="HibernateClasses.ContainerType"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.User"%>
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

        <%
            int index = 0;

            if (request.getParameter("index") != null) {
                index = Integer.parseInt(request.getParameter("index"));
            }

            Session s = PoolManager.getSessionFactory().openSession();

            Criteria c1 = s.createCriteria(User.class);
            c1.add(Restrictions.eq("iduser", Integer.parseInt(request.getParameter("uid"))));
            User u = (User) c1.uniqueResult();
        %>

        <div class="content"><h2>Purchase History of <%=u.getFirstName() + " " + u.getLastName()%></h2></div>

        <%
            Criteria c2 = s.createCriteria(ContainerType.class);
            c2.add(Restrictions.eq("typeName", "Cart"));
            ContainerType ct = (ContainerType) c2.uniqueResult();

            Criteria c3 = s.createCriteria(Container.class);
            c3.add(Restrictions.eq("containerType", ct));
            c3.add(Restrictions.eq("user", u));
            Container con = (Container) c3.uniqueResult();

            Criteria c4 = s.createCriteria(ProductInContainer.class);
            c4.add(Restrictions.eq("container", con));
            c4.addOrder(Order.desc("addedDate"));

            int l = c4.list().size();

            c4.setFirstResult(index);
            c4.setMaxResults(10);

            List<ProductInContainer> lpc = c4.list();

        %>

        <div class="details">
            <table border="0" width="1200">
                <tr>
                    <th width="50">ID</th>
                    <th width="150">Product Name</th>
                    <th width="150">Customer Price</th>
                    <th width="150">Quantity</th>
                    <th width="150">Total Amount</th>
                    <th width="150">Image</th>

                </tr>

                <%
                    for (ProductInContainer pc : lpc) {

                %>

                <tr>
                    <td width="50" align="center"><%=pc.getPcId()%></td>
                    <td width="250"><%=pc.getProduct().getMake().getMakeName() + " " + pc.getProduct().getName()%></td>
                    <td width="150">LKR <%=pc.getProduct().getCustomerPrice()%></td>
                    <td width="150"><%=pc.getQty()%></td>
                    <td width="150">LKR <%=pc.getAmount()%>0</td>
                    <td width="150" align="center"><img src="<%=pc.getProduct().getImagePath()%>" height="100" width="auto"/></td>

                </tr>
                <%}%>
                <tr><td colspan="7" align="center">

                        <% if (index > 0) {%>
                        <a href="Admin-ViewUserPurchaseHistory_1.jsp?index=<%= index - 10%>">
                            <input type="submit" value="<< Back" class="button1"/>
                        </a>
                        <% }%>

                        <% if (index < l - 10) {%>
                        <a href="Admin-ViewUserPurchaseHistory_1.jsp?index=<%= index + 10%>">
                            <input type="submit" value="Next >>" class="button1"/>
                        </a>
                        <% }%>

                    </td></tr>
            </table>
        </div>
    </center>
    <%}%>
</body>
</html>
