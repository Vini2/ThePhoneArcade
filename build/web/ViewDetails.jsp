<%-- 
    Document   : ViewDetails
    Created on : Oct 23, 2013, 10:57:10 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.Category"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="HibernateClasses.Description"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.Images"%>
<%@page import="java.util.List"%>
<%@page import="HibernateClasses.UserLogin"%>
<%@page import="HibernateClasses.Product"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="HibernateClasses.PoolManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <%
            Session s = PoolManager.getSessionFactory().openSession();
            Product pr = (Product) s.load(Product.class, Integer.parseInt(request.getParameter("pid")));

        %>

        <title>The Phone Arcade - Details - <%=pr.getMake().getMakeName() + pr.getName()%></title>

        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        %>

        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <link href="css/modern-menu-my.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/jquery.modern-menu.min.js" type="text/javascript"></script>

        <%
            Session s1 = PoolManager.getSessionFactory().openSession();
            Criteria cc = s1.createCriteria(Category.class);
            cc.add(Restrictions.eq("categoryName", "Accessory"));
            Category catl = (Category)cc.uniqueResult();
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
                    <td colspan="5">

                        <div class="content">

                            <table width="950" border="0" align="center" >

                                <tr>
                                    <td colspan="5"><div class="content"><br><a href="Home.jsp" class="alink">Home</a> > <a href="<%=pr.getMake().getMakeName()%>.jsp" class="alink"><%=pr.getMake().getMakeName()%></a> > <%=pr.getMake().getMakeName() + " " + pr.getName()%><br><br></div></td>
                                </tr>
                                
                                <tr>
                                    <td colspan="5"><div class="proname"><h2><%=pr.getMake().getMakeName() + " " + pr.getName()%></h2></div></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="wishlistcartmsg">
                                            <%
                                                if (request.getParameter("msg") != null) {
                                                    out.write(request.getParameter("msg"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <%
                                        Criteria c1 = s.createCriteria(Images.class);
                                        c1.add(Restrictions.eq("product", pr));
                                        List<Images> li = c1.list();

                                    %>
                                    <td colspan="5" align="center">
                                        <div class="phoneimages">
                                            <%for (Images i : li) {%>

                                            <img src="<%=i.getImagePath()%>" height="400" width="auto"/> &nbsp;

                                            <%}%>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><p><%=pr.getGeneralDescription()%></p></td>
                                </tr>
                                <tr>
                                    <td colspan="5"><h3>Specifications</h3><hr></td>
                                </tr>
                            </table>

                            <div class="specstable">

                                <table width="950" border="0" align="center" cellpadding="10" >
                                    <tr>

                                        <%
                                            Criteria c2 = s.createCriteria(Description.class);
                                            c2.add(Restrictions.eq("product", pr));
                                            Description d = (Description) c2.uniqueResult();

                                        %>

                                        <th rowspan="6" width="150">GENERAL</th>
                                        <td width="120" class="specstabletitle">2G Network</td>
                                        <td><%=d.getGeneral2gNetwork()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">3G Network</td>
                                        <td><%=d.getGeneral3gNetwork()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">4G Network</td>
                                        <td><%=d.getGeneral4gNetwork()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">SIM</td>
                                        <td><%=d.getGeneralSim()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Announced</td>
                                        <td><%=d.getGeneralAnnounced()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Status</td>
                                        <td><%=d.getGeneralStatus()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="2">BODY</th>
                                        <td class="specstabletitle">Dimensions</td>
                                        <td><%=d.getBodyDimensions()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Weight</td>
                                        <td><%=d.getBodyWeight()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="4">DISPLAY</th>
                                        <td class="specstabletitle">Type</td>
                                        <td><%=d.getDisplayType()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Size</td>
                                        <td><%=d.getDisplaySize()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Multi-touch</td>
                                        <td><%=d.getDisplayMultitouch()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Protection</td>
                                        <td><%=d.getDisplayProtection()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="3">SOUND</th>
                                        <td class="specstabletitle">Alert types</td>
                                        <td><%=d.getSoundAlertType()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Loudspeaker</td>
                                        <td><%=d.getSoundLoudspeaker()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">3.5mm jack</td>
                                        <td><%=d.getSound35mmJack()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="2">MEMORY</th>
                                        <td class="specstabletitle">Card slot</td>
                                        <td><%=d.getMemoryCardSlot()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Internal</td>
                                        <td><%=d.getMemoryInternal()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="8">DATA</th>
                                        <td class="specstabletitle">GPRS</td>
                                        <td><%=d.getDataGprs()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">EDGE</td>
                                        <td><%=d.getDataEdge()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Speed</td>
                                        <td><%=d.getDataSpeed()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">WLAN</td>
                                        <td><%=d.getDataWlan()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Bluetooth</td>
                                        <td><%=d.getDataBluetooth()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">NFC</td>
                                        <td><%=d.getDataNfc()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Infrared port</td>
                                        <td><%=d.getDataInfraredPort()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">USB</td>
                                        <td><%=d.getDataUsb()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="4">CAMERA</th>
                                        <td class="specstabletitle">Primary</td>
                                        <td><%=d.getCameraPrimary()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Features</td>
                                        <td><%=d.getCameraFeatures()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Video</td>
                                        <td><%=d.getCameraVideo()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Secondary</td>
                                        <td><%=d.getCameraSecondary()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="11">FEATURES</th>
                                        <td class="specstabletitle">OS</td>
                                        <td><%=d.getFeaturesOs()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Chipset</td>
                                        <td><%=d.getFeaturesChipset()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">CPU</td>
                                        <td><%=d.getFeaturesCpu()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">GPU</td>
                                        <td><%=d.getFeaturesGpu()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Sensors</td>
                                        <td><%=d.getFeaturesSensors()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Messaging</td>
                                        <td><%=d.getFeaturesMessaging()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Browser</td>
                                        <td><%=d.getFeaturesBrowser()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Radio</td>
                                        <td><%=d.getFeaturesRadio()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">GPS</td>
                                        <td><%=d.getFeaturesGps()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Java</td>
                                        <td><%=d.getFeaturesJava()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Colors</td>
                                        <td><%=d.getFeaturesColours()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="4">BATTERY</th>
                                        <td class="specstabletitle">Type</td>
                                        <td><%=d.getBatteryType()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Stand-by</td>
                                        <td><%=d.getBatteryStandby()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Talk time</td>
                                        <td><%=d.getBatteryTalktime()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Music play</td>
                                        <td><%=d.getBatteryMusicPlay()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="2">MISC</th>
                                        <td class="specstabletitle">SAR US</td>
                                        <td><%=d.getMiscSarUs()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">SAR EU</td>
                                        <td><%=d.getMiscSarEu()%></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" rowspan="5">TESTS</th>
                                        <td class="specstabletitle">Display</td>
                                        <td><%=d.getTestsDisplay()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Loudspeaker</td>
                                        <td><%=d.getTestsLoudspeaker()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Audio quality</td>
                                        <td><%=d.getTestsAudioQuality()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Camera</td>
                                        <td><%=d.getTestsCamera()%></td>
                                    </tr>
                                    <tr>
                                        <td class="specstabletitle">Battery life</td>
                                        <td><%=d.getTestsBatteryLife()%></td>
                                    </tr>

                                </table>

                            </div>

                            <table width="950" border="0" align="center" >
                                <tr>
                                    <td colspan="2"><hr></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        Disclaimer: We can not guarantee that the information on this page is 100% correct.
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br><br><br>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left"><div class="price">Price : LKR <%=pr.getCustomerPrice()%>0</div></td>
                                    <td align="right">
                                        <%if (request.getSession().getAttribute("user") != null) {
                                                UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
                                        %>
                                        <% if (ul.getUser().getUserType().getTypeName().equals("Buyer")) {%>
                                        <a href="AddToWishlistServlet?pid=<%=pr.getIdproduct()%>"><input type="submit" value="ADD TO WISHLIST" class="button-search" style="width: 200px"/></a><br><br>
                                            <%}%>    
                                            <%if (pr.getAvailableQty() > 10) {%>
                                            <% if (ul.getUser().getUserType().getTypeName().equals("Buyer")) {%>
                                        <form action="AddToCartServlet" method="POST">

                                            <%
                                                double dd = pr.getAvailableQty();
                                                int qty1 = (int) dd;
                                            %>
                                            <input type="hidden" name="pid" value="<%=pr.getIdproduct()%>" />
                                            Quantity : <input type="text" name="qty" value="1" style="width: 30px" class="text"/> / <%=qty1 - 10%>&nbsp;&nbsp;&nbsp;
                                            <input type="submit" value="ADD TO CART" class="button-search" style="width: 200px"/>

                                        </form>
                                        <%}%>
                                        <%} else {%>
                                        <div class="stock">Out of stock</div>
                                        <%}
                                        } else {%>
                                        <a href="SignIn.jsp"><input type="submit" value="SIGN IN TO PURCHASE" class="button-search"/></a>
                                               
                                            <%}%>

                                    </td>
                                </tr>

                            </table>

                        </div>
                    </td>
                </tr>

                <tr>
                    <td colspan="5" height="100">
                    </td>
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