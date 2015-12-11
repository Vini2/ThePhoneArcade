<%-- 
    Document   : Admin-ManageUserAccounts
    Created on : Nov 4, 2013, 6:01:54 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.UserLogin"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.UserType"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="HibernateClasses.User"%>
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

        <div class="content"><h2>Manage User Accounts</h2></div>

        <div class="details">
            <table border="0">

                <tr>
                    <th width="80">User ID</th>
                    <th width="150">Full Name</th>
                    <th width="100">Gender</th>
                    <th width="150">Address</th>
                    <th width="150">Mobile</th>
                    <th width="150">Registered Date </th>
                    <th width="100">Status</th>
                    <th width="150"></th>
<!--                    <th width="100"></th>-->

                </tr>


                <%

                    int index = 0;

                    if (request.getParameter("index") != null) {
                        index = Integer.parseInt(request.getParameter("index"));
                    }

                    Session s = PoolManager.getSessionFactory().openSession();

                    Criteria c = s.createCriteria(UserType.class);
                    c.add(Restrictions.eq("typeName", "Buyer"));
                    UserType ut = (UserType) c.uniqueResult();

                    Criteria c1 = s.createCriteria(User.class);
                    c1.add(Restrictions.eq("userType", ut));
                    c1.addOrder(Order.asc("iduser"));

                    int l = c1.list().size();

                    c1.setFirstResult(index);
                    c1.setMaxResults(10);

                    List<User> list = c1.list();

                    for (User u : list) {
                %>



                <tr>
                    <td width="80"><%=u.getIduser()%></td>
                    <td width="250"><%=u.getFirstName() + " " + u.getLastName()%></td>
                    <td width="100"><%=u.getGender()%></td>
                    <td width="150"><%=u.getAddress()%></td>
                    <td width="150"><%=u.getMobile()%></td>
                    <td width="150" align="center"><%=u.getRegisterDate()%></td>
                    <td width="100" align="center"><%=u.getSystemStatus().getStatusName()%></td>
                    <td width="150" align="center">
                        <%if (u.getSystemStatus().getStatusName().equals("Active")) {%>
                        <a href="AdminManageUserAccounts?sysid=Not Active&uid=<%=u.getIduser()%>">
                            <input type="submit" value="Deactivate" class="button1"/>
                        </a>
                        <%} else {%>
                        <a href="AdminManageUserAccounts?sysid=Active&uid=<%=u.getIduser()%>">
                            <input type="submit" value="Activate" class="button1"/>
                        </a>
                        <%}%>
                    </td>
<!--                    <td width="100" align="center">
                        <%if (!u.getSystemStatus().getStatusName().equals("Blacklisted")) {%>
                        <a href="AdminManageUserAccounts?sysid=Blacklisted&uid=<%=u.getIduser()%>">
                            <input type="submit" value="Blacklist" class="button1"/>
                        </a>
                        <%}%>
                    </td>-->

                </tr>



                <% }%>


                <tr><td colspan="9" align="center">

                        <% if (index > 0) {%>
                        <a href="Admin-ManageUserAccounts.jsp?index=<%= index - 10%>">
                            <input type="submit" value="<< Back" class="button1"/>
                        </a>
                        <% }%>

                        <% if (index < l - 10) {%>
                        <a href="Admin-ManageUserAccounts.jsp?index=<%= index + 10%>">
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
