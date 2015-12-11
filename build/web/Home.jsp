<%-- 
    Document   : Home
    Created on : Oct 27, 2013, 11:03:05 AM
    Author     : Asus
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="HibernateClasses.Category"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.UserLogin"%>
<%@page import="java.util.List"%>
<%@page import="HibernateClasses.Product"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="HibernateClasses.PoolManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Phone Arcade - Home</title>

        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        %>

        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <link href="css/modern-menu-my.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <link rel="stylesheet" type="text/css" href="css/style1.css" />

        <script src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/jquery.modern-menu.min.js" type="text/javascript"></script>

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
                        <%
                            if (request.getSession().getAttribute("user") != null) {
                                UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
                                if (ul.getUser().getUserType().getTypeName().equals("Buyer")) {%>

                        Welcome <%=ul.getUser().getFirstName()%>&nbsp;<br>
                        <a href="MyWishlist.jsp" class="alink">My Wishlist</a>&nbsp;&nbsp;|&nbsp;
                        <a href="MyCart.jsp" class="alink">My Cart</a>&nbsp;&nbsp;|&nbsp;
                        <a href="BuyerHistory.jsp" class="alink">History</a>&nbsp;&nbsp;|&nbsp;
                        <a href="SignOutServlet" class="alink">Sign Out</a>&nbsp;<br><br>
                        <%} else {%>
                        <a href="AdminPanel.jsp" class="alink">Administrator Panel</a>&nbsp;<br><br>
                        <%}
                        } else {%>
                        <a href="SignIn.jsp" class="alink">Sign In</a>&nbsp;&nbsp;|&nbsp;
                        <a href="SignUp.jsp" class="alink">Sign Up</a>&nbsp;<br><br><br>
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
                    <td colspan="5" align="right" height="30">

                    </td>
                </tr>

                <tr>
                    <td colspan="5" height="300" align="center">

                        <script type="text/javascript" src="HomeGallery/js/swfobject.js"></script>
                        <script type="text/javascript" src="HomeGallery/js/flashgallery.js"></script>
                        <script type="text/javascript">
                            jQuery.flashgallery('HomeGallery/HomeGallery.swf', 'HomeGallery/config.xml', {width: '900px', height: '400px', background: 'transparent'});
                        </script>

                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="200">
                        <br><br>
                        <div class="homeslide">
                            <img src="HomeImages/h2_color.png"/><br>
                            <p align="justify" class="content">With a handful of smartphones, tablets and devices, not to mention copious amounts of mid- to low-range models, some with multiple variants, it is quite easy to get lost in the the world of modern-day mobile devices. Samsung, who is probably one of the greatest offenders, probably knows this too well and has put out an infographic that spells out in easy-to-understand images and marketing lingo the features of its latest masterpieces, the Galaxy Note 3 smartphone and the Galaxy Gear companion smartwatch.</p>

                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="50">
                        <br><br>
                        <div><h2>New Arrivals - Phones</h2></div>
                        <hr>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="200">

                        <%

                            Criteria c1 = s1.createCriteria(Category.class);
                            c1.add(Restrictions.eq("categoryName", "Phone"));
                            Category cat1 = (Category) c1.uniqueResult();

                            Criteria c3 = s1.createCriteria(Product.class);
                            c3.add(Restrictions.eq("status", "Available"));
                            c3.add(Restrictions.eq("category", cat1));
                            c3.addOrder(Order.desc("idproduct"));
                            c3.setMaxResults(4);

                            List<Product> lpp = c3.list();

                            for (Product p : lpp) {

                        %>


                        <div class="resultstab">

                            <table width="200" height="300" border="0" align="center">
                                <tr>
                                    <td>
                                <center><img src="<%=p.getImagePath()%>" height="200" width="auto"/></center>
                                </td>
                                </tr>
                                <tr>
                                    <td align="center" height="40"><%=p.getMake().getMakeName() + " " + p.getName()%></td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <a href="ViewDetails.jsp?pid=<%=p.getIdproduct()%>"><input type="submit" value="VIEW" class="button-search" style="width: 100px"/></a>

                                    </td>
                                </tr>

                            </table>

                        </div>
                        <%}%>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="50">
                        <br><div><h2>New Arrivals - Tablets</h2></div>
                        <hr>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="200">

                        <%
                            Criteria c2 = s1.createCriteria(Category.class);
                            c2.add(Restrictions.eq("categoryName", "Tablet"));
                            Category cat2 = (Category) c2.uniqueResult();

                            Criteria c4 = s1.createCriteria(Product.class);
                            c4.add(Restrictions.eq("status", "Available"));
                            c4.add(Restrictions.eq("category", cat2));
                            c4.addOrder(Order.desc("idproduct"));
                            c4.setMaxResults(4);

                            List<Product> lpt = c4.list();

                            for (Product p : lpt) {

                        %>


                        <div class="resultstab">

                            <table width="200" height="300" border="0" align="center">
                                <tr>
                                    <td>
                                <center><img src="<%=p.getImagePath()%>" height="200" width="auto"/></center>
                                </td>
                                </tr>
                                <tr>
                                    <td align="center" height="40"><%=p.getMake().getMakeName() + " " + p.getName()%></td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <a href="ViewDetails.jsp?pid=<%=p.getIdproduct()%>"><input type="submit" value="VIEW" class="button-search" style="width: 100px"/></a>

                                    </td>
                                </tr>

                            </table>

                        </div>
                        <%}%>
                    </td>
                </tr>
                <tr>
                    <td colspan="5"></td>
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
</body>
</html>

