<%-- 
    Document   : ForgotPassword
    Created on : Nov 6, 2013, 9:51:02 PM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Phone Arcade - Forgot Password</title>
        <link rel="stylesheet" href="css/style.css" type="text/css"/>

        <script type="text/javascript">

            function validate(myform) {

                var email = myform["email"].value;

                var myboolean = new Boolean();

                myboolean = true;

                if (email == "") {
                    myboolean = false;
                    document.getElementById('msg_email').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter the email address of your account</font>';
                    document.getElementById("idemail").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_email').innerHTML = '<br>';
                    document.getElementById("idemail").style.border = '';
                }

                if (myboolean == true) {
                    signUp(myform);
                }
            }


            function signUp(frm1) {

                var a;

                var email = frm1["email"].value;


                if (window.XMLHttpRequest) {
                    a = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    a = new ActiveXObject("Microsoft.XMLHTTP");
                } else {
                    alert("Browser does not support AJAX");
                }

                if (a != null) {
                    a.onreadystatechange = function() {
                        if(a.readyState < 4){
                            document.getElementById('loading').innerHTML ='Sending... <img src="images/loader_transparent.gif" height="25px" width="auto"/>';
                        }
                        else if (a.readyState === 4) {
                            var res = a.responseText;
                            
                            document.getElementById('loading').innerHTML ='';

                            if (res == 'success') {
                                frm1["email"].value = "";
                                alert("An email with necessary instructions was sent successfully...!");
                            } else if (res == 'email_null') {
                                document.getElementById('msg_email').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter the email address off your account</font>';
                                document.getElementById("idemail").style.border = 'red solid 1px';
                            } else if (res == 'email_invalid') {
                                document.getElementById('msg_email').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid email address</font>';
                                document.getElementById("idemail").style.border = 'red solid 1px';
                            } else {
                                alert(res);
                            }
                        }
                    }

                    a.open("POST", "ForgotPasswordSendEmailServlet", true);
                    a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    a.send("email=" + email);

                }
            }

            function removeBorder() {

                document.getElementById('msg_email').innerHTML = '<br>';
                document.getElementById("idemail").style.border = '';


            }

        </script>

    </head>
    <body>

    <center>
        <img src="HomeImages/header.gif" />
        <h2>Forgot Your Password?</h2>
        <h4>or <a href="SignIn.jsp" class="alink">Sign In</a></h4>
        <br>
        <div class="sign">
            <form action="" onsubmit="validate(this);
                return false;" method="POST" id="testform">

                <h4>
                    <font color="red">

                    <%
                        if (request.getParameter("msg") != null) {
                            out.write(request.getParameter("msg"));
                        }
                    %>

                    </font>
                </h4>
                <div class="content">
                    Please enter your email address. We will send you an email with instructions to reset your password.<br><br><br>
                </div>
                <table border="0">

                    <tr>
                        <td width="100px">Email</td>
                        <td>:</td>
                        <td><input type="text" name="email" value="" style="width: 250px" id="idemail" class="text" onclick="removeBorder()" onkeypress="removeBorder()"/></td>
                    </tr>
                    <tr>
                        <td colspan="3" id="msg_email" style="color: red" align="right"><br></td>
                    </tr>
                    <tr>
                        <td colspan="1"><div class="content" id="loading"></div></td>
                        <td colspan="2" align="right"><br><input type="submit" value="SUBMIT" class="button-search"/><br><br></td>
                    </tr>
                </table>

            </form>
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
