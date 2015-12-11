<%-- 
    Document   : BuyerHistory
    Created on : Nov 19, 2013, 3:55:38 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.SystemStatus"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="HibernateClasses.Category"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="HibernateClasses.ProductInContainer"%>
<%@page import="HibernateClasses.Container"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.ContainerType"%>
<%@page import="java.util.List"%>
<%@page import="HibernateClasses.Product"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="HibernateClasses.PoolManager"%>
<%@page import="HibernateClasses.UserLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Phone Arcade - Purchase History</title>



        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            if (request.getSession().getAttribute("user") == null) {
                response.sendRedirect("SignIn.jsp?msg=Please login and continue");
            } else {
                UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
        %>

        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <link href="css/modern-menu-my.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/jquery.modern-menu.min.js" type="text/javascript"></script>
        <script src="js/jqFancyTransitions.1.8.js" type="text/javascript"></script>
        
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
        <!--<script src="http://code.jquery.com/jquery-1.9.1.js"></script>-->
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        

        <%
            Session s1 = PoolManager.getSessionFactory().openSession();
            Criteria cc = s1.createCriteria(Category.class);
            cc.add(Restrictions.eq("categoryName", "Accessory"));
            Category catl = (Category) cc.uniqueResult();
        %>

        
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
            $(function() {

            <%
                Criteria c = s1.createCriteria(Product.class);
                c.add(Restrictions.eq("status", "Available"));
                c.add(Restrictions.not(Restrictions.eq("category", catl)));
                c.addOrder(Order.asc("make"));
                List<Product> lp1 = c.list();
            %>
                var availableTags = [

            <%
                for (Product p : lp1) {
            %>
                "<%=p.getMake().getMakeName() + " " + p.getName()%>",
            <%}%>
                ];
                        $("#tags").autocomplete({
                    source: availableTags
                });
            });</script>

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
        <div id="tab">
            <table width="1000" height="2000" border="0" cellpadding="0">
                <tr>
                    <td colspan="3" height="100">
                        <img src="HomeImages/header.gif" />
                    </td>
                    <td colspan="2" height="100" align="right">
                        <font style="font-family:'Arial'; font-size:12px">

                        Welcome <%=ul.getUser().getFirstName()%>&nbsp;<br>
                        <% if (ul.getUser().getUserType().getTypeName().equals("Buyer")) {%>
                        <a href="MyWishlist.jsp" class="alink">My Wishlist</a>&nbsp;&nbsp;|&nbsp;
                        <a href="MyCart.jsp" class="alink">My Cart</a>&nbsp;&nbsp;|&nbsp;
                        <a href="BuyerHistory.jsp" class="alink">History</a>&nbsp;&nbsp;|&nbsp;
                        <a href="SignOutServlet" class="alink">Sign Out</a>&nbsp;<br><br>
                        <%}%>
                        <br><br>


                        </font>
                    </td>
                </tr>

                <tr>
                    <td height="40" colspan="5" width="498">
                        <div>
                            <ul class="modern-menu theme6">
                                <li><a href="Home.jsp"><span>HOME</span></a></li>
                                <li><a href="#"><span>MOBILE DEVICESˇ</span></a>
                                    <ul><li><a href="Samsung.jsp"><span>Samsung</span></a></li>
                                        <li><a href="Nokia.jsp"><span>Nokia</span></a></li>
                                        <li><a href="Sony.jsp"><span>Sony</span></a></li>
                                        <li><a href="LG.jsp"><span>LG</span></a></li>
                                        <li><a href="Micromax.jsp"><span>Micromax</span></a></li>
                                        <li><a href="E-tel.jsp"><span>E-tel</span></a></li>
                                        <li><a href="MobileDevicesOther.jsp"><span>Other</span></a></li></ul></li>
                                <li><a href="MobilePhoneAccessories.jsp"><span>ACCESSORIESˇ</span></a>
                                    <ul><li><a href="Accessories.jsp?type=Battery"><span>Batteries</span></a></li>
                                        <li><a href="Accessories.jsp?type=Charger"><span>Chargers</span></a></li>
                                        <li><a href="Accessories.jsp?type=Cover"><span>Covers</span></a></li>
                                        <li><a href="Accessories.jsp?type=Headset"><span>Headsets</span></a></li>
                                        <li><a href="Accessories.jsp?type=ScreenGuard"><span>Screen Guards</span></a></li>
                                        <li><a href="Accessories.jsp?type=Other"><span>Other</span></a></li></ul></li>
                                <li><a href="#"><span>SERVICESˇ</span></a>
                                    <ul><li><a href="Repairs.jsp"><span>Repairs</span></a></li></ul></li>
                                <li><a href="#"><span>ABOUT TPAˇ</span></a>
                                    <ul><li><a href="AboutUs.jsp"><span>About Us</span></a></li>
                                        <li><a href="ContactUs.jsp"><span>Contact Us</span></a></li></ul></li>
                                <ul class="mm-group mm-right">
                                    <li class="mm-icon"><a href="https://www.facebook.com/"><span class="mm-facebook"><img src="theme/facebook.png"/></span></a></li>
                                    <li class="mm-icon"><a href="https://twitter.com/"><span class="mm-twitter"><img src="theme/twitter.png"/></span></a></li>
                                    <li class="mm-icon"><a href="https://plus.google.com"><span class="mm-googleplus"><img src="theme/googleplus.png"/></span></a></li>
                                    <li class="mm-icon"><a href="https://www.linkedin.com"><span class="mm-linkedin"><img src="theme/linkedin.png"/></span></a></li></ul></ul>
                            <hr>
                        </div>
                        <script type="text/javascript">$(".modern-menu").modernMenu();</script>
                    </td>
                </tr>

                <tr>
                    <td align="center"  colspan="5" height="100px">
                        <div class="content">
                            <h2 style="text-shadow: 5px 5px 5px #999999;">Purchase History</h2><br><br>

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
                            <form action="BuyerGetDate" method="POST">

                                From : 
                                <input type="text" name="startDate" value="" id="id_date" class="text" />&nbsp;&nbsp;&nbsp;&nbsp;
                                To :
                                <input type="text" name="endDate" value="" id="id_date1" class="text" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="submit" value="VIEW" class="button-search" style="width: 100px"/>
                            </form>
                        </div>

                        <br>


                        <%if (request.getParameter("msg") != null) {%>
                        <div class="content" style="color: red">Please select a time period</div>
                        <%}%>
                    </td>
                </tr>
                <%
                    if (request.getParameter("y1") != null) {

                        Date sdate = new Date(Integer.parseInt(request.getParameter("y1")), Integer.parseInt(request.getParameter("m1")), Integer.parseInt(request.getParameter("d1")));
                        Date edate = new Date(Integer.parseInt(request.getParameter("y2")), Integer.parseInt(request.getParameter("m2")), Integer.parseInt(request.getParameter("d2")));

                        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

                        String sdateformats = formatter.format(sdate);
                        String edateformats = formatter.format(edate);

                %>

                <tr>
                    <td align="center"  colspan="5" height="100px">
                        <div class="content"><h3>Purchase History from <%=sdateformats%> to <%=edateformats%></h3></div>

                        <br>

                        <%

                            int index = 0;

                            if (request.getParameter("index") != null) {
                                index = Integer.parseInt(request.getParameter("index"));
                            }
                            double checkout_total = 0.0;

                            Criteria c2 = s1.createCriteria(SystemStatus.class);
                            c2.add(Restrictions.eq("statusName", "Purchased"));
                            SystemStatus ss = (SystemStatus) c2.uniqueResult();

                            Criteria c3 = s1.createCriteria(ContainerType.class);
                            c3.add(Restrictions.eq("typeName", "Cart"));
                            ContainerType ct = (ContainerType) c3.uniqueResult();

                            Criteria c4 = s1.createCriteria(Container.class);
                            c4.add(Restrictions.and(Restrictions.eq("user", ul.getUser()), Restrictions.eq("containerType", ct)));
                            Container con = (Container) c4.uniqueResult();

                            Criteria c5 = s1.createCriteria(ProductInContainer.class);
                            c5.add(Restrictions.between("addedDate", sdate, edate));
                            c5.add(Restrictions.eq("systemStatus", ss));
                            c5.add(Restrictions.eq("container", con));

                            int l = c5.list().size();

                            c5.setFirstResult(index);
                            c5.setMaxResults(10);

                            List<ProductInContainer> list = c5.list();

                            if (l > 0) {
                        %>
                        <div class="wishlist">
                            <table border="0" align="center" width="800" cellpadding="10px">


                                <tr class="content">
                                    <th></th>
                                    <th></th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Purchased Date</th>
                                </tr>
                                <tr>
                                    <td colspan="7"><hr></td>
                                </tr>

                                <%
                                    for (ProductInContainer pc : list) {

                                        String formats = formatter.format(pc.getAddedDate());

                                        checkout_total += pc.getAmount();
                                        double d = pc.getQty();
                                        int qty1 = (int) d;

                                %>

                                <tr>
                                    <td align="center">
                                        <img src="<%=pc.getProduct().getImagePath()%>" height="200" width="auto"/>
                                    </td>
                                    <td width="250">
                                        <h3><%=pc.getProduct().getMake().getMakeName() + " " + pc.getProduct().getName()%></h3>
                                    </td>
                                    <td width="120" align="center">
                                        <div class="content">LKR <%=pc.getProduct().getCustomerPrice()%>0</div>
                                    </td>
                                    <td width="70" align="center">
                                        <div class="content"><%=qty1%></div>
                                    </td>
                                    <td width="180">
                                        <h4>LKR <%=pc.getAmount()%>0</h4>
                                    </td>
                                    <td align="center" width="120">
                                        <div class="content"><%=formats%></div>
                                    </td>
                                </tr>
                                <tr width="200">
                                    <td colspan="7"><hr></td>
                                </tr>

                                <% }%>

                            </table>
                            <% if (index > 0) {%>
                            <a href="BuyerHistory.jsp?index=<%= index - 10%>&y1=<%=request.getParameter("y1")%>&m1=<%=request.getParameter("m1")%>&d1=<%=request.getParameter("d1")%>&y2=<%=request.getParameter("y2")%>&m2=<%=request.getParameter("m2")%>&d2=<%=request.getParameter("d2")%>">
                                <input type="submit" value="<< Back" class="button-search"/>
                            </a>
                            <% }%>

                            <% if (index < l - 10) {%>
                            <a href="BuyerHistory.jsp?index=<%= index + 10%>&y1=<%=request.getParameter("y1")%>&m1=<%=request.getParameter("m1")%>&d1=<%=request.getParameter("d1")%>&y2=<%=request.getParameter("y2")%>&m2=<%=request.getParameter("m2")%>&d2=<%=request.getParameter("d2")%>">
                                <input type="submit" value="Next >>" class="button-search"/>
                            </a>
                            <% }%>
                        </div>
                        <%} else {%>
                        
                        <div class="content">
                            No results found for your search<br><br>
                            <img src="images/noSearchResults.jpg"/>
                        </div>
                        <br><br>

                        <%}%>



                        <%}%>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="200">
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="200">
                        <hr>
                        <div id="footer">
                            <div class="detailstab">
                                <h3>Mobile Phones</h3>
                                <ul>
                                    <li><a href="Samsung.jsp" title="Samsung">Samsung</a></li>
                                    <li><a href="Nokia.jsp" title="Nokia">Nokia</a></li>
                                    <li><a href="Sony.jsp" title="SONY">Sony</a></li>
                                    <li><a href="LG.jsp" title="LG">LG</a></li>
                                    <li><a href="Micromax.jsp" title="Micromax">Micromax</a></li>
                                    <li><a href="E-tel.jsp" title="E-tel">E-tel</a></li>
                                </ul>
                            </div>
                            <div class="detailstab">
                                <h3>Accessories</h3>
                                <ul>
                                    <li><a href="Accessories.jsp?type=Battery" title="Batteries">Batteries</a></li>
                                    <li><a href="Accessories.jsp?type=Charger" title="Chargers">Chargers</a></li>
                                    <li><a href="Accessories.jsp?type=Cover" title="Cases">Cases</a></li>
                                    <li><a href="Accessories.jsp?type=Headset" title="Headsets">Headsets</a></li>
                                    <li><a href="Accessories.jsp?type=ScreenGuard" title="Screen Guards">Screen Guards</a></li>
                                </ul>
                            </div>
                            <div class="detailstab">
                                <h3>Help & Support</h3>
                                <ul>
                                    <li><a href="TermsAndConditions.jsp" title="Terms and Conditions">Terms and Conditions</a></li>
                                    <li><a href="PrivacyPolicy.jsp" title="Privacy Policy">Privacy Policy</a></li>
                                </ul>
                            </div>
                            <div class="detailstab">
                                <h3>About TPA</h3>
                                <ul>
                                    <li><a href="AboutUs.jsp" title="About Us">About Us</a></li>
                                    <li><a href="ContactUs.jsp" title="Contact Us">Contact Us</a></li>
                                    <li><div class="about">info.thephonearcadek@gmail.com</div></li>
                                    <li><div class="about">+94 (034) 2221068</div></li>
                                    <li><div class="about">+94 (034) 4902250</div></li>
                                </ul>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="5"><hr /></td>
                </tr>
                <tr>
                    <td colspan="3" height="50"><div class="content">Copyright 2013 | The Phone Arcade |  All rights reserved</div></td>
                    <td height="50" align="right" colspan="2">
                        <img src="HomeImages/Visa.jpg" height="40" width="auto"/>
                        <img src="HomeImages/MasterCard.jpg" height="40" width="auto"/>
                        <img src="HomeImages/american-express.jpg" height="40" width="auto"/>
                        <img src="HomeImages/paypal_logo.jpg" height="40" width="auto"/>
                    </td>
                </tr>
            </table>
        </div>
    </center>
    <%}%>
</body>
</html>



