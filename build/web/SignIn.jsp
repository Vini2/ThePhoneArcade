<%-- 
    Document   : SignIn
    Created on : Oct 3, 2013, 12:03:16 AM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Phone Arcade - Sign In</title>

        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <link rel="stylesheet" href="css/style4.css" type="text/css"/>

    </head>
    <body>

    <center>
        <img src="HomeImages/header.gif" />
        <h2>Sign In</h2>
        <br>
        <div class="sign">
            <form action="SignInServlet" method="POST">

                <img src="images/signin.png" height="180px" width="auto"/>

                <h4>
                    <font color="red">

                    <%
                        if (request.getParameter("msg") != null) {
                            if (request.getParameter("msg").equals("Error1")) {
                    %>
                    Incorrect email address or password.
                    <%} else if (request.getParameter("msg").equals("Error2")) {%>
                    Invalid password. Your account has been suspended. Please contact the Administrator.
                    <%}else if (request.getParameter("msg").equals("Error0")) {%>
                    Please enter a valid email address.
                    <%}else if (request.getParameter("msg").equals("Error3")) {%>
                    Your account is not active.
                    <%} else{
                        out.write(request.getParameter("msg"));
                    }}%>

                    </font>
                </h4>
                <table border="0">

                    <tr>
                        <td>Email</td>
                        <td>:</td>
                        <td><input type="text" name="email" value="" style="width: 250px" class="text"/></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td>:</td>
                        <td><input type="password" name="password" value="" style="width: 250px" class="text"/></td>
                    </tr>
                    <tr>
                        <td><br>Forgot your <a href="ForgotPassword.jsp" class="alink">password</a>?</td>
                    </tr>

                    <tr>
                        <td colspan="3" align="left"><br><font size="-1">To protect your privacy, remember to sign out when you<br>are done shopping.<br><br></font></td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right"><input type="submit" value="SIGN IN" class="button-search"/><br><br></td>
                    </tr>
                </table>

            </form>

<!--            Not a member yet? <a href="SignUp.jsp" class="alink">Sign Up</a><br><br>-->
            
                            
                            <a href="SignUp.jsp" class="a-btn">
                                <span class="a-btn-text">Not a member yet?</span> 
                                <span class="a-btn-slide-text">SIGN UP</span>
                                <span class="a-btn-icon-right"><span></span></span>
                            </a>

                            <br><br><br><br>

            <a href="Home.jsp" class="alink">Home</a>
        </div>
        <br><br>
        <div class="content">
            Copyright 2013 | The Phone Arcade |  All rights reserved&nbsp;
            Use of this Web site constitutes acceptance of the TPA <a href="PrivacyPolicy.jsp" title="Privacy Policy" class="alink">Privacy Policy</a> and <a href="TermsAndConditions.jsp" title="Terms and Conditions" class="alink">Terms and Conditions</a>.</div>
        <br><br>
    </center>






</body>
</html>
