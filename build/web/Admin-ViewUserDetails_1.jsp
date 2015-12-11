<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="HibernateClasses.User"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.UserType"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="HibernateClasses.PoolManager"%>
<%@page import="org.hibernate.Session"%>

<link rel="stylesheet" href="css/newAdmin.css" />

<div class="details">

    <table border="0" align="center">

        <tr>
            <th width="100">User ID</th>
            <th width="150">Full Name</th>
            <th width="150">Gender</th>
            <th width="150">Address</th>
            <th width="150">Mobile</th>
            <th width="150">Registered Date </th>
            <th width="150">Status</th>

        </tr>


        <%

            Session s = PoolManager.getSessionFactory().openSession();

            Criteria c = s.createCriteria(UserType.class);
            c.add(Restrictions.eq("typeName", "Buyer"));
            UserType ut = (UserType) c.uniqueResult();

            Criteria c1 = s.createCriteria(User.class);
            c1.add(Restrictions.eq("userType", ut));
                    
            if(request.getParameter("searchmethod").equals("firstname")){
                c1.add(Restrictions.like("firstName", "%" + request.getParameter("key") + "%"));
            }
                    
            else if(request.getParameter("searchmethod").equals("lastname")){
                c1.add(Restrictions.like("lastName", "%" + request.getParameter("key") + "%"));
            }
                    
            c1.addOrder(Order.asc("iduser"));

            List<User> list = c1.list();

            for (User u : list) {
        %>



        <tr>
            <td width="100"><%=u.getIduser()%></td>
            <td width="250"><%=u.getFirstName() + " " + u.getLastName()%></td>
            <td width="150"><%=u.getGender()%></td>
            <td width="150"><%=u.getAddress()%></td>
            <td width="150"><%=u.getMobile()%></td>
            <td width="150" align="center"><%=u.getRegisterDate()%></td>
            <td width="150" align="center"><%=u.getSystemStatus().getStatusName()%></td>


        </tr>



        <% }%>


    </table>
</div>