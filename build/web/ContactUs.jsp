<%-- 
    Document   : ContactUs
    Created on : Oct 16, 2013, 4:38:05 PM
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
        <title>The Phone Arcade - Contact Us</title>

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

        <script type="text/javascript">

            function validate(myform) {

                var name = myform["name"].value;
                var email = myform["email"].value;
                var mobile = myform["mobile"].value;
                var subject = myform["subject"].value;
                var message = myform["message"].value;

                var myboolean = new Boolean();

                myboolean = true;

                if (name == "") {
                    myboolean = false;
                    document.getElementById('msg_name').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your name</font>';
                    document.getElementById("idname").style.border = 'red solid 1px';

                }
                else {
                    document.getElementById('msg_name').innerHTML = '<br>';
                    document.getElementById("idname").style.border = '';
                }

                if (email == "") {
                    myboolean = false;
                    document.getElementById('msg_email').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your email address</font>';
                    document.getElementById("idemail").style.border = 'red solid 1px';

                }
                else {
                    document.getElementById('msg_email').innerHTML = '<br>';
                    document.getElementById("idemail").style.border = '';
                }

                if (mobile == "") {
                    myboolean = false;
                    document.getElementById('msg_mobile').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your mobile no</font>';
                    document.getElementById("idmobile").style.border = 'red solid 1px';
                }
                else if (isNaN(mobile)) {
                    myboolean = false;
                    document.getElementById('msg_mobile').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid mobile no</font>';
                    document.getElementById("idmobile").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_mobile').innerHTML = '<br>';
                    document.getElementById("idmobile").style.border = '';
                }

                if (subject == "") {
                    myboolean = false;
                    document.getElementById('msg_subject').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select a subject</font>';
                    document.getElementById("idsubject").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_subject').innerHTML = '<br>';
                    document.getElementById("idsubject").style.border = '';
                }

                if (message == "") {
                    myboolean = false;
                    document.getElementById('msg_message').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your message</font>';
                    document.getElementById("idmessage").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_message').innerHTML = '<br>';
                    document.getElementById("idmessage").style.border = '';
                }

                if (myboolean == true) {
                    signUp(myform);
                }
            }


            function signUp(frm1) {

                var a;

                var name = frm1["name"].value;
                var email = frm1["email"].value;
                var mobile = frm1["mobile"].value;
                var subject = frm1["subject"].value;
                var message = frm1["message"].value;


                if (window.XMLHttpRequest) {
                    a = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    a = new ActiveXObject("Microsoft.XMLHTTP");
                } else {
                    alert("Browser does not support AJAX");
                }

                if (a != null) {
                    a.onreadystatechange = function() {
                        if (a.readyState < 4) {
                            document.getElementById('loading').innerHTML = 'Please wait... <img src="images/loader_transparent.gif" height="25px" width="auto"/>';
                        }
                        else if (a.readyState === 4) {
                            var res = a.responseText;

                            document.getElementById('loading').innerHTML = '';

                            if (res == 'success') {
                                frm1["name"].value = "";
                                frm1["email"].value = "";
                                frm1["mobile"].value = "";
                                frm1["subject"].value = "";
                                frm1["message"].value = "";
                                alert("Your email was sent successfully");
                            } else if (res == 'name_null') {
                                document.getElementById('msg_name').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your name</font>';
                                document.getElementById("idname").style.border = 'red solid 1px';
                            } else if (res == 'email_null') {
                                document.getElementById('msg_email').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter an email address</font>';
                                document.getElementById("idemail").style.border = 'red solid 1px';
                            } else if (res == 'email_invalid') {
                                document.getElementById('msg_email').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid email address</font>';
                                document.getElementById("idemail").style.border = 'red solid 1px';
                            } else if (res == 'mobile_null') {
                                document.getElementById('msg_mobile').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter mobile no</font>';
                                document.getElementById("idmobile").style.border = 'red solid 1px';
                            } else if (res == 'mobile_invalid') {
                                document.getElementById('msg_mobile').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid mobile no</font>';
                                document.getElementById("idmobile").style.border = 'red solid 1px';
                            } else if (res == 'sub_null') {
                                document.getElementById('msg_subject').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select a subject</font>';
                                document.getElementById("idsubject").style.border = 'red solid 1px';
                            } else if (res == 'message_null') {
                                document.getElementById('msg_message').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your message</font>';
                                document.getElementById("idmessage").style.border = 'red solid 1px';
                            } else {
                                alert(res);
                            }
                        }
                    }

                    a.open("POST", "SendEmailServlet", true);
                    a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    a.send("name=" + name + "&email=" + email + "&mobile=" + mobile + "&subject=" + subject + "&message=" + message);

                }
            }

            function removeBorder(ab) {

                if (ab == "name") {
                    document.getElementById('msg_name').innerHTML = '<br>';
                    document.getElementById("idname").style.border = '';
                } else if (ab == "email") {
                    document.getElementById('msg_email').innerHTML = '<br>';
                    document.getElementById("idemail").style.border = '';
                } else if (ab == "mobile") {
                    document.getElementById('msg_mobile').innerHTML = '<br>';
                    document.getElementById("idmobile").style.border = '';
                } else if (ab == "subject") {
                    document.getElementById('msg_subject').innerHTML = '<br>';
                    document.getElementById("idsubject").style.border = '';
                } else if (ab == "message") {
                    document.getElementById('msg_message').innerHTML = '<br>';
                    document.getElementById("idmessage").style.border = '';
                }

            }


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
                    <td colspan="5" height="500" align="center">

                        <form action="" onsubmit="validate(this);
                                return false;" method="POST" id="testform">

                            <h2 style="text-shadow: 5px 5px 5px #999999;">Contact Us</h2>
                            <h4>By Email</h4>

                            <div class="content sign">

                                <table border="0" align="center">
                                    <tr>
                                        <td>Name</td>
                                        <td>:</td>
                                        <td><input type="text" name="name" value="" id="idname" style="width: 310px" class="text" onkeypress="removeBorder('name')" onclick="removeBorder('name')"/></td>
                                    </tr>
                                    <tr>
                                        <td width="145"></td>
                                        <td colspan="3" id="msg_name" style="color: red"><br></td>
                                    </tr>
                                    <tr>
                                        <td>Email</td>
                                        <td>:</td>
                                        <td><input type="text" name="email" value="" id="idemail" style="width: 310px" class="text" onkeypress="removeBorder('email')" onclick="removeBorder('email')"/></td>
                                    </tr>
                                    <tr>
                                        <td width="145"></td>
                                        <td colspan="3" id="msg_email" style="color: red"><br></td>
                                    </tr>
                                    <tr>
                                        <td>Mobile Number</td>
                                        <td>:</td>
                                        <td><input type="text" name="mobile" value="" id="idmobile" style="width: 310px" class="text" onkeypress="removeBorder('mobile')" onclick="removeBorder('mobile')"/></td>
                                    </tr>
                                    <tr>
                                        <td width="145"></td>
                                        <td colspan="3" id="msg_mobile" style="color: red"><br></td>
                                    </tr>
                                    <tr>
                                        <td>Subject</td>
                                        <td>:</td>
                                        <td><select name="subject" id="idsubject" style="width: 322px" class="text" onkeypress="removeBorder('subject')" onclick="removeBorder('subject')">
                                                <option value="">---Select Subject---</option>
                                                <option value="General Enquiry">General Enquiry</option>
                                                <option value="Account Activation">Account Activation</option>
                                                <option value="Product Details">Product Details</option>
                                                <option value="Payments">Payments</option>
                                            </select></td>
                                    </tr>
                                    <tr>
                                        <td width="145"></td>
                                        <td colspan="3" id="msg_subject" style="color: red"><br></td>
                                    </tr>
                                    <tr>
                                        <td>Message</td>
                                        <td>:</td>
                                        <td><textarea name="message" rows="15" cols="20" id="idmessage" style="width: 310px" class="text" onkeypress="removeBorder('message')" onclick="removeBorder('message')"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td width="145"></td>
                                        <td colspan="3" id="msg_message" style="color: red"><br></td>
                                    </tr>
                                    <tr>
                                        <td colspan="1"><div class="content" id="loading"></div></td>
                                        <td colspan="2" align="right"><input type="submit" value="SEND" class="button-search"/></td>
                                    </tr>
                                </table>

                            </div>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" align="center">
                        <br>
                        <div class="branch content" style="width: 550px;">
                            <table border="0" cellpadding="10px">
                                <tr>
                                    <td colspan="3"><h3>Head Office</h3></td>
                                </tr>
                                <tr>
                                    <td>Address</td>
                                    <td>:</td>
                                    <td>
                                        The Phone Arcade,<br>
                                        No 109,<br>
                                        Kalutara South,<br>
                                        Sri Lanka.
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3"><br></td>
                                </tr>
                                <tr>
                                    <td>Hot Line</td>
                                    <td>:</td>
                                    <td>
                                        +94 (034) 2221068<br>
                                        +94 (034) 4902250
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3"><br></td>
                                </tr>
                            </table>

                        </div>
                        <br><br>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="100">
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
