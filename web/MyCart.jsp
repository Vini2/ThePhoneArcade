<%-- 
    Document   : MyCart
    Created on : Nov 3, 2013, 10:57:56 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.Category"%>
<%@page import="HibernateClasses.SystemStatus"%>
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
        <title>The Phone Arcade - My Cart</title>



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

        <%
            Session s1 = PoolManager.getSessionFactory().openSession();
            Criteria cc = s1.createCriteria(Category.class);
            cc.add(Restrictions.eq("categoryName", "Accessory"));
            Category catl = (Category) cc.uniqueResult();
        %>

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
            });
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
                        <div class="ui-widget">
                            <form action="Search" method="POST">
                                <input name="search" id="tags" class="searchtext"/><input type="submit" value="SEARCH" class="button-search" />
                            </form>
                        </div>
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
                    <td colspan="5" height="5"><div class="content"><br><a href="Home.jsp" class="alink">Home</a> > My Cart<br></div></td>
                </tr>
                <tr>
                    <td colspan="5" height="40" align="center">
                        <h2 style="text-shadow: 5px 5px 5px #999999;">My Cart</h2>
                        <div class="content" style="color: red">
                            <%
                                if (request.getParameter("msg") != null) {
                                    if (request.getParameter("msg").equals("Error1")) {
                            %>
                            The quantity you entered is greater than the available quantity. Please enter a valid quantity.
                            <%} else if (request.getParameter("msg").equals("Error2")) {
                            %>
                            Please enter a valid quantity.
                            <%}
                                }%>
                            <br><br>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td colspan="5" height="220" align="center">
                        <div class="wishlist">
                            <table width="800" align="center" cellpadding="10px" border="0">

                                <%
                                    double checkout_total = 0.0;

                                    Criteria c1 = s1.createCriteria(ContainerType.class);
                                    c1.add(Restrictions.eq("typeName", "Cart"));
                                    ContainerType ct = (ContainerType) c1.uniqueResult();

                                    Criteria c2 = s1.createCriteria(Container.class);
                                    c2.add(Restrictions.and(Restrictions.eq("user", ul.getUser()), Restrictions.eq("containerType", ct)));
                                    Container con = (Container) c2.uniqueResult();

                                    Criteria c4 = s1.createCriteria(SystemStatus.class);
                                    c4.add(Restrictions.eq("statusName", "InCart"));
                                    SystemStatus st = (SystemStatus) c4.uniqueResult();

                                    Criteria c3 = s1.createCriteria(ProductInContainer.class);
                                    c3.add(Restrictions.eq("container", con));
                                    c3.add(Restrictions.eq("systemStatus", st));
                                    c3.addOrder(Order.desc("addedDate"));
                                    List<ProductInContainer> lpc = c3.list();

                                    if (c3.list().size() == 0) {
                                %>
                                
                                <tr>
                                    <td colspan="6" align="center">
                                        <div class="content">
                                            Your cart is empty<br><br>
                                            <img src="images/Empty-Shopping-Cart.png" width="600px" height="auto"/><br><br>
                                        </div>
                                    </td>
                                </tr>
                                
                                <%} else{%>
                                
                                <tr>
                                    <td colspan="6"><hr></td>
                                </tr>
                                
                                <%
                                    }

                                    for (ProductInContainer pc : lpc) {
                                        checkout_total += pc.getAmount();
                                        double d = pc.getQty();
                                        int qty1 = (int) d;
                                %>
                                <tr>
                                    <td align="center">
                                        <img src="<%=pc.getProduct().getImagePath()%>" height="200" width="auto"/>
                                    </td>
                                    <td>
                                        <h3 width="250"><%=pc.getProduct().getMake().getMakeName() + " " + pc.getProduct().getName()%></h3>
                                    </td>
                                    <td width="120">
                                        <h4>LKR <%=pc.getProduct().getCustomerPrice()%>0</h4>
                                    </td>
                                    <td align="right" width="250">
                                        <form action="UpdateQtyInCartServlet" method="POST">
                                            <input type="hidden" name="pcid" value="<%=pc.getPcId()%>" />
                                            Qty : <input type="text" name="qty" value="<%=qty1%>" style="width: 30px" class="text"/>&nbsp;
                                            <%
                                                double dd = pc.getProduct().getAvailableQty() + pc.getQty();
                                                int qty2 = (int) dd;
                                            %>
                                            / <%=qty2 - 10%> &nbsp;
                                            <input type="submit" value="UPDATE" class="button-search" />
                                        </form>
                                    </td>
                                    <td>
                                        <a href="DeleteFromCartServlet?pcid=<%=pc.getPcId()%>"><input type="button" value="REMOVE" class="button-search" /></a>
                                    </td>

                                </tr>
                                <tr width="200">
                                    <td colspan="6"><hr></td>
                                </tr>
                                <%}%>

                                <%if (c3.list().size() > 0) {%>
                                <tr>
                                    <td colspan="3"><div class="price content">Total in Cart : LKR <%=checkout_total%>0</div></td>
                                    <td colspan="3" align="right">
                                        <a href="Checkout_1.jsp?cid=<%=con.getIdc()%>"><input type="submit" value="PROCEED TO CHECKOUT" class="button-search"/></a>
                                    </td>
                                </tr>
                                <%}%>

                            </table>
                        </div>
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


