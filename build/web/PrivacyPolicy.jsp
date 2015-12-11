<%-- 
    Document   : PrivacyPolicy
    Created on : Nov 5, 2013, 8:59:42 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.Category"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="java.util.List"%>
<%@page import="HibernateClasses.Product"%>
<%@page import="HibernateClasses.PoolManager"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="HibernateClasses.UserLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Phone Arcade - Privacy Policy</title>

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
        <script src="js/jqFancyTransitions.1.8.js" type="text/javascript"></script>

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
            <table width="1000" height="1500" border="0" cellpadding="0">

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
                        <%} else{%>
                        <a href="AdminPanel.jsp" class="alink">Administrator Panel</a>&nbsp;<br><br>
                        <%}} else {%>
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
                    <td colspan="5" height="500">
                        <div class="content policy">
                            
                            <center><h2 style="text-shadow: 5px 5px 5px #999999;">Privacy Policy</h2></center><br>

                            <!-- START PRIVACY POLICY CODE -->
                            <div style="font-family: arial;"><span style="font-size: small;"><strong>What information do we collect?</strong> </span><br /><br /><span style="font-size: small;">We collect information from you when you register on our site, place an order or fill out a form. </span><br /><br /><span style="font-size: small;">When ordering or registering on our site, as appropriate, you may be asked to enter your: name, e-mail address, mailing address, phone number or credit card information.</span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>What do we use your information for?</strong> </span><br /><br /><span style="font-size: small;">Any of the information we collect from you may be used in one of the following ways: </span><br /><br /><span style="font-size: small;">   1) To personalize your experience</span><span style="font-size: small;"> </span><span style="font-size: small;">(your information helps us to better respond to your individual needs)</span><br /><br /><span style="font-size: small;">   2) To improve our website</span><span style="font-size: small;"> </span><span style="font-size: small;">(we continually strive to improve our website offerings based on the information and feedback we receive from you)</span><br /><br /><span style="font-size: small;">   3) To improve customer service</span><span style="font-size: small;"> </span><span style="font-size: small;">(your information helps us to more effectively respond to your customer service requests and support needs)</span><br /><br /><span style="font-size: small;">   4) To process transactions</span><br />
                                <blockquote><span style="font-size: small;">Your information, whether public or private, will not be sold, exchanged, transferred, or given to any other company for any reason whatsoever, without your consent, other than for the express purpose of delivering the purchased product or service requested.</span></blockquote>
                                <span style="font-size: small;">   5) To send periodic emails</span><br />
                                <blockquote><span style="font-size: small;">The email address you provide for order processing, will only be used  to send you information and updates pertaining to your order.</span></blockquote>
                                <br /><br /><span style="font-size: small;"><strong>How do we protect your information?</strong> </span><br /><br /><span style="font-size: small;">We implement a variety of security measures to maintain the safety of your personal information when you place an order or enter, submit, or access your personal information. </span><br /> <br /><span style="font-size: small;">We offer the use of a secure server. All supplied sensitive/credit information is transmitted via Secure Socket Layer (SSL) technology and then encrypted into our Payment gateway providers database only to be accessible by those authorized with special access rights to such systems, and are required to?keep the information confidential.</span><br /><br /><span style="font-size: small;">After a transaction, your private information (credit cards, social security numbers, financials, etc.) will not be kept on file for more than 60 days.</span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>Do we use cookies?</strong> </span><br /><br /><span style="font-size: small;">We do not use cookies.</span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>Do we disclose any information to outside parties?</strong> </span><br /><br /><span style="font-size: small;">We do not sell, trade, or otherwise transfer to outside parties your personally identifiable information. This does not include trusted third parties who assist us in operating our website, conducting our business, or servicing you, so long as those parties agree to keep this information confidential. We may also release your information when we believe release is appropriate to comply with the law, enforce our site policies, or protect ours or others rights, property, or safety. However, non-personally identifiable visitor information may be provided to other parties for marketing, advertising, or other uses.</span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>Childrens' Online Privacy Protection Act Compliance</strong> </span><br /><br /><span style="font-size: small;">We are in compliance with the requirements of COPPA (Childrens Online Privacy Protection Act), we do not collect any information from anyone under 13 years of age. Our website, products and services are all directed to people who are at least 13 years old or older.</span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>Online Privacy Policy Only</strong> </span><br /><br /><span style="font-size: small;">This online privacy policy applies only to information collected through our website and not to information collected offline.</span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>Terms and Conditions</strong> </span><br /><br /><span style="font-size: small;">Please also visit our Terms and Conditions section establishing the use, disclaimers, and limitations of liability governing the use of our website at <br><a href="TermsAndConditions.jsp" class="alink">Terms And Conditions</a></span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>Your Consent</strong> </span><br /><br /><span style="font-size: small;">By using our site, you consent to our web site privacy policy.</span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>Changes to our Privacy Policy</strong> </span><br /><br /><span style="font-size: small;">If we decide to change our privacy policy, we will post those changes on this page. </span></div><br />
                            <div style="font-family: arial;"><br /><span style="font-size: small;"><strong>Contacting Us</strong> </span><br /><br /><span style="font-size: small;">If there are any questions regarding this privacy policy you may contact us using the information below. </span><br /><br /></div>
                            <div style="font-family: arial;"><span style="font-size: small;">No. 109,</span><br /><span style="font-size: small;">Kalutara South, 12000,</span><br /><span style="font-size: small;">Sri Lanka.</span><br /><span style="font-size: small;">info.thephonearcadek@gmail.com</span></div><br />
                            <div style="font-family: arial;"><span style="font-size: small;">+94 (034) 2221068</span><br /><br /></div><br />
                            <!-- END PRIVACY POLICY CODE -->

                        </div>
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

</body>
</html>

