<%-- 
    Document   : Admin-ViewSalesHistory
    Created on : Nov 19, 2013, 3:12:42 PM
    Author     : Asus
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.SystemStatus"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="HibernateClasses.ProductInContainer"%>
<%@page import="HibernateClasses.PoolManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="HibernateClasses.UserLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TPA - Admin Panel</title>

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

        <link rel="stylesheet" href="css/newAdmin.css" />

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        
        <script>
            $(function() {
                $("#id_date").datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    numberOfMonths: 1,
                    onClose: function(selectedDate) {
                        $("#id_date1").datepicker("option", "minDate", selectedDate);
                        $("#id_date").datepicker("option", "dateFormat", "dd/mm/yy");
                        $("#id_date1").datepicker("option", "dateFormat", "dd/mm/yy");
                    }
                });
                $("#id_date1").datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    numberOfMonths: 1,
                    onClose: function(selectedDate) {
                        $("#id_date").datepicker("option", "maxDate", selectedDate);
                        $("#id_date").datepicker("option", "dateFormat", "dd/mm/yy");
                        $("#id_date1").datepicker("option", "dateFormat", "dd/mm/yy");
                    }
                });
            });

            $(document).ready(function() {
                $("#id_date").datepicker({
                    minDate: 0,
                    maxDate: "+60D",
                    numberOfMonths: 1,
                    onSelect: function(selected) {
                        $("#id_date1").datepicker("option", "minDate", selected)
                    }
                });
                $("#id_date1").datepicker({
                    minDate: 0,
                    maxDate: "+60D",
                    numberOfMonths: 1,
                    onSelect: function(selected) {
                        $("#id_date").datepicker("option", "maxDate", selected)
                    }
                });
            });
        </script>

        <script type="text/javascript">

            function period() {

                var p = document.getElementById('idperiod').value;

                if (p == 'Yesterday') {
            <%
                Calendar sdate1 = Calendar.getInstance();
                sdate1.add(Calendar.DATE, - 1);
                Calendar edate1 = Calendar.getInstance();

            %>
                    var sdate1 = <%=sdate1.get(Calendar.DATE)%> + "/" +<%=(sdate1.get(Calendar.MONTH) + 1)%> + "/" +<%=sdate1.get(Calendar.YEAR)%>;
                    var edate1 = <%=edate1.get(Calendar.DATE)%> + "/" +<%=(edate1.get(Calendar.MONTH) + 1)%> + "/" +<%=edate1.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
//                    document.getElementById("id_date").disabled= true;
//                    document.getElementById("id_date1").disabled= true;
                }


                else if (p == 'Today') {
            <%
                Calendar sdate2 = Calendar.getInstance();
                Calendar edate2 = Calendar.getInstance();
                edate2.add(Calendar.DATE, +1);

            %>
                    var sdate1 = <%=sdate2.get(Calendar.DATE)%> + "/" +<%=(sdate2.get(Calendar.MONTH) + 1)%> + "/" +<%=sdate2.get(Calendar.YEAR)%>;
                    var edate1 = <%=edate2.get(Calendar.DATE)%> + "/" +<%=(edate2.get(Calendar.MONTH) + 1)%> + "/" +<%=edate2.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }


                else if (p == 'This Week') {
            <%
                Calendar today = Calendar.getInstance();
                int dyofweek = today.get(Calendar.DAY_OF_WEEK);
                dyofweek--;
                today.add(Calendar.DATE, -dyofweek);
            %>
                    var sdate1 = <%=today.get(Calendar.DATE)%> + "/" +<%=(today.get(Calendar.MONTH) + 1)%> + "/" +<%=today.get(Calendar.YEAR)%>;
            <%
                today.add(Calendar.DATE, +7);

            %>
                    var edate1 = <%=today.get(Calendar.DATE)%> + "/" +<%=(today.get(Calendar.MONTH) + 1)%> + "/" +<%=today.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }


                else if (p == 'Last Week') {
            <%
                Calendar today1 = Calendar.getInstance();
                int week = today1.get(Calendar.DAY_OF_WEEK);
                int lastweek = week + 6;
                today1.add(Calendar.DATE, -lastweek);
            %>
                    var sdate1 = <%=today1.get(Calendar.DATE)%> + "/" +<%=(today1.get(Calendar.MONTH) + 1)%> + "/" +<%=today1.get(Calendar.YEAR)%>;
            <%
                today1.add(Calendar.DATE, +7);

            %>

                    var edate1 = <%=today1.get(Calendar.DATE)%> + "/" +<%=(today1.get(Calendar.MONTH) + 1)%> + "/" +<%=today1.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }


                else if (p == 'This Month') {
            <%
                Calendar today2 = Calendar.getInstance();
                int thismonth = today2.get(Calendar.DAY_OF_MONTH);
                thismonth--;
                today2.add(Calendar.DATE, -thismonth);
            %>
                    var sdate1 = <%=today2.get(Calendar.DATE)%> + "/" +<%=(today2.get(Calendar.MONTH) + 1)%> + "/" +<%=today2.get(Calendar.YEAR)%>;
            <%
                today2.add(Calendar.MONTH, +1);
                today2.add(Calendar.DATE, 0);
            %>

                    var edate1 = <%=today2.get(Calendar.DATE)%> + "/" +<%=(today2.get(Calendar.MONTH) + 1)%> + "/" +<%=today2.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }


                else if (p == 'Last Month') {
            <%
                Calendar today3 = Calendar.getInstance();
                int thismonth1 = today3.get(Calendar.DAY_OF_MONTH);
                thismonth1--;
                today3.add(Calendar.DATE, -thismonth1);
                today3.add(Calendar.MONTH, - 1);
            %>
                    var sdate1 = <%=today3.get(Calendar.DATE)%> + "/" +<%=(today3.get(Calendar.MONTH) + 1)%> + "/" +<%=today3.get(Calendar.YEAR)%>;
            <%
                today3.add(Calendar.MONTH, +1);
                today3.add(Calendar.DATE, 0);
            %>

                    var edate1 = <%=today3.get(Calendar.DATE)%> + "/" +<%=(today3.get(Calendar.MONTH) + 1)%> + "/" +<%=today3.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }


                else if (p == 'Last 3 Months') {
            <%
                Calendar today4 = Calendar.getInstance();
                int thismonth2 = today4.get(Calendar.DAY_OF_MONTH);
                thismonth2--;
                today4.add(Calendar.DATE, -thismonth2);
                today4.add(Calendar.MONTH, - 3);
            %>
                    var sdate1 = <%=today4.get(Calendar.DATE)%> + "/" +<%=(today4.get(Calendar.MONTH) + 1)%> + "/" +<%=today4.get(Calendar.YEAR)%>;
            <%
                today4.add(Calendar.MONTH, +3);
                today4.add(Calendar.DATE, 0);
            %>

                    var edate1 = <%=today4.get(Calendar.DATE)%> + "/" +<%=(today4.get(Calendar.MONTH) + 1)%> + "/" +<%=today4.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }


                else if (p == 'This Year') {
            <%
                Calendar today5 = Calendar.getInstance();
                int thismonth3 = today5.get(Calendar.DAY_OF_MONTH);
                int months = today5.get(Calendar.MONTH);
                thismonth3--;
                today5.add(Calendar.DATE, -thismonth3);
                today5.add(Calendar.MONTH, -months);
            %>
                    var sdate1 = <%=today5.get(Calendar.DATE)%> + "/" +<%=(today5.get(Calendar.MONTH) + 1)%> + "/" +<%=today5.get(Calendar.YEAR)%>;
            <%
                today5.add(Calendar.MONTH, +12);
                today5.add(Calendar.DATE, 0);
            %>

                    var edate1 = <%=today5.get(Calendar.DATE)%> + "/" +<%=(today5.get(Calendar.MONTH) + 1)%> + "/" +<%=today5.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }


                else if (p == 'Last Year') {
            <%
                Calendar today6 = Calendar.getInstance();
                int thismonth4 = today6.get(Calendar.DAY_OF_MONTH);
                int months1 = today6.get(Calendar.MONTH);
                thismonth4--;
                today6.add(Calendar.DATE, -thismonth4);
                today6.add(Calendar.MONTH, -months1);
                today6.add(Calendar.YEAR, - 1);
            %>
                    var sdate1 = <%=today6.get(Calendar.DATE)%> + "/" +<%=(today6.get(Calendar.MONTH) + 1)%> + "/" +<%=today6.get(Calendar.YEAR)%>;
            <%
                today6.add(Calendar.MONTH, +12);
                today6.add(Calendar.DATE, 0);
            %>

                    var edate1 = <%=today6.get(Calendar.DATE)%> + "/" +<%=(today6.get(Calendar.MONTH) + 1)%> + "/" +<%=today6.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }


                else if (p == 'Last 3 Years') {
            <%
                Calendar today7 = Calendar.getInstance();
                int thismonth5 = today7.get(Calendar.DAY_OF_MONTH);
                int months2 = today7.get(Calendar.MONTH);
                thismonth5--;
                today7.add(Calendar.DATE, -thismonth5);
                today7.add(Calendar.MONTH, -months2);
                today7.add(Calendar.YEAR, -3);
            %>
                    var sdate1 = <%=today7.get(Calendar.DATE)%> + "/" +<%=(today7.get(Calendar.MONTH) + 1)%> + "/" +<%=today7.get(Calendar.YEAR)%>;
            <%
                today7.add(Calendar.DATE, 0);
                today7.add(Calendar.YEAR, +3);
            %>

                    var edate1 = <%=today7.get(Calendar.DATE)%> + "/" +<%=(today7.get(Calendar.MONTH) + 1)%> + "/" +<%=today7.get(Calendar.YEAR)%>;
                    document.getElementById('id_date').value = sdate1;
                    document.getElementById('id_date1').value = edate1;
                }
            }

        </script>

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

        <div class="content"><h2>View Sales History</h2></div>
        <br>

        <div class="content">

            Select a Time Period : 
            <select name="period" id="idperiod" onchange="period()" class="text" style="width: 210px;">
                <option value="">---Select Time Period---</option>
                <option value="Today">Today</option>
                <option value="Yesterday">Yesterday</option>
                <option value="This Week">This Week</option>
                <option value="Last Week">Last Week</option>
                <option value="This Month">This Month</option>
                <option value="Last Month">Last Month</option>
                <option value="Last 3 Months">Last 3 Months</option>
                <option value="This Year">This Year</option>
                <option value="Last Year">Last Year</option>
                <option value="Last 3 Years">Last 3 Years</option>
            </select>

            <br><br>
            <form action="getDate" method="POST">

                From : 
                <input type="text" name="startDate" value="" id="id_date" class="text" />&nbsp;&nbsp;&nbsp;&nbsp;
                To :
                <input type="text" name="endDate" value="" id="id_date1" class="text" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="submit" value="VIEW" class="button1" style="width: 100px"/>
            </form>
        </div>

        <br>


        <%if (request.getParameter("msg") != null) {%>
        <div class="content" style="color: red">Please select a time period or enter a valid date range</div>
        <%}%>


        <%
            if (request.getParameter("y1") != null) {

                Date sdate = new Date(Integer.parseInt(request.getParameter("y1")), Integer.parseInt(request.getParameter("m1")), Integer.parseInt(request.getParameter("d1")));
                Date edate = new Date(Integer.parseInt(request.getParameter("y2")), Integer.parseInt(request.getParameter("m2")), Integer.parseInt(request.getParameter("d2")));

                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

                String sdateformats = formatter.format(sdate);
                String edateformats = formatter.format(edate);

        %>


        <div class="content"><h3>Sales History from <%=sdateformats%> to <%=edateformats%></h3></div>

        <br>

        <div class="details">



            <%
                int index = 0;

                if (request.getParameter("index") != null) {
                    index = Integer.parseInt(request.getParameter("index"));
                }

                double tot = 0.0;

                Session s = PoolManager.getSessionFactory().openSession();
                Criteria c2 = s.createCriteria(SystemStatus.class);
                c2.add(Restrictions.eq("statusName", "Purchased"));
                SystemStatus ss = (SystemStatus) c2.uniqueResult();

                Criteria c = s.createCriteria(ProductInContainer.class);
                c.add(Restrictions.between("addedDate", sdate, edate));
                c.add(Restrictions.eq("systemStatus", ss));
                c.addOrder(Order.desc("addedDate"));

                List<ProductInContainer> list0 = c.list();
                for (ProductInContainer pc0 : list0) {
                    tot = tot + pc0.getAmount();
                }

                int l = c.list().size();

                c.setFirstResult(index);
                c.setMaxResults(10);

                List<ProductInContainer> list = c.list();

                int i1 = list.size();

                if (i1 > 0) {
            %>

            <table border="0" align="center">

                <tr>
                    <th width="80">Ref ID</th>
                    <th width="250">Product Name</th>
                    <th width="100">Category</th>
                    <th width="150">Customer Price</th>
                    <th width="80">Quantity</th>
                    <th width="150">Total amount</th>
                    <th width="150">Image</th>
                    <th width="100">Purchased Date</th>
                    <th width="150">Purchased by</th>

                </tr>

                <%
                    for (ProductInContainer pc : list) {

                        double d = pc.getQty();
                        int qty = (int) d;

                        String formats = formatter.format(pc.getAddedDate());


                %>

                <tr>
                    <td><%=pc.getProduct().getIdproduct()%></td>
                    <td><%=pc.getProduct().getMake().getMakeName() + " " + pc.getProduct().getName()%></td>
                    <td><%=pc.getProduct().getCategory().getCategoryName()%></td>
                    <td>LKR. <%=pc.getProduct().getCustomerPrice()%>0</td>
                    <td align="center"><%=qty%></td>
                    <td>LKR. <%=pc.getAmount()%>0</td>
                    <td align="center"><img src="<%=pc.getProduct().getImagePath()%>" height="100" width="auto"/></td>
                    <td align="center"><%=formats%></td>
                    <td><%=pc.getContainer().getUser().getFirstName() + " " + pc.getContainer().getUser().getLastName()%></td>

                </tr>

                <% }%>

                <tr><td colspan="9" align="center">

                        <% if (index > 0) {%>
                        <a href="Admin-ViewSalesHistory.jsp?index=<%= index - 10%>&y1=<%=request.getParameter("y1")%>&m1=<%=request.getParameter("m1")%>&d1=<%=request.getParameter("d1")%>&y2=<%=request.getParameter("y2")%>&m2=<%=request.getParameter("m2")%>&d2=<%=request.getParameter("d2")%>">
                            <input type="submit" value="<< Back" class="button1"/>
                        </a>
                        <% }%>

                        <% if (index < l - 10) {%>
                        <a href="Admin-ViewSalesHistory.jsp?index=<%= index + 10%>&y1=<%=request.getParameter("y1")%>&m1=<%=request.getParameter("m1")%>&d1=<%=request.getParameter("d1")%>&y2=<%=request.getParameter("y2")%>&m2=<%=request.getParameter("m2")%>&d2=<%=request.getParameter("d2")%>">
                            <input type="submit" value="Next >>" class="button1"/>
                        </a>
                        <% }%>

                    </td></tr>
                <tr>
                    <td colspan="9" align="center"><hr><h3>Total Sales between <%=sdateformats%> and <%=edateformats%> : <h2>LKR. <%=tot%>0</h2></h3><hr></td>
                </tr>
            </table>
            <%
                } else {%>
            <div class="content"><img src="images/no result.jpg" height="50px" width="auto"/>&nbsp;&nbsp;&nbsp;No results found for your search</div><br><br>
                <%}%>

        </div>
        <br><br><br>
        <%}%>
    </center>
    <%}%>
</body>
</html>

