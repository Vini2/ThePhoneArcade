<%-- 
    Document   : ResetPassword
    Created on : Nov 6, 2013, 9:42:09 PM
    Author     : Asus
--%>

<%@page import="Servlets.SecurityEncDec"%>
<%@page import="Servlets.Security"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Phone Arcade - Reset Password</title>
        
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        %>
        
        <link rel="stylesheet" href="css/style.css" type="text/css"/>

        <script type="text/javascript">

            function validate(myform) {

                var password = myform["password"].value;
                var confirmpassword = myform["confirmpassword"].value;

                var myboolean = new Boolean();

                myboolean = true;

                if (password == "") {
                    myboolean = false;
                    document.getElementById('msg_password').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your new password</font>';
                    document.getElementById("idpassword").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_password').innerHTML = '<br>';
                    document.getElementById("idpassword").style.border = '';
                }

                if (confirmpassword == "") {
                    myboolean = false;
                    document.getElementById('msg_confirmpassword').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please confirm your password</font>';
                    document.getElementById("idconfirmpassword").style.border = 'red solid 1px';
                }
                else if (confirmpassword != password) {
                    myboolean = false;
                    document.getElementById('msg_confirmpassword').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Password mismatch. Check your password</font>';
                    document.getElementById("idconfirmpassword").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_confirmpassword').innerHTML = '<br>';
                    document.getElementById("idconfirmpassword").style.border = '';
                }

                if (myboolean == true) {
                    signUp(myform);
                }
            }


            function signUp(frm1) {

                var a;

                var email = frm1["email"].value;
                var time = frm1["time"].value;
                var password = frm1["password"].value;
                var confirmpassword = frm1["confirmpassword"].value;

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
                            document.getElementById('loading').innerHTML ='Please wait... <img src="images/loader_transparent.gif" height="25px" width="auto"/>';
                        }
                        else if (a.readyState === 4) {
                            var res = a.responseText;
                            document.getElementById('loading').innerHTML ='';

                            if (res == 'password_null') {
                                document.getElementById('msg_password').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a password</font>';
                                document.getElementById("idpassword").style.border = 'red solid 1px';
                            } else if (res == 'confirmpassword_null') {
                                document.getElementById('msg_confirmpassword').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please confirm your password</font>';
                                document.getElementById("idconfirmpassword").style.border = 'red solid 1px';
                            } else if (res == 'confirmpassword_mismatch') {
                                document.getElementById('msg_confirmpassword').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Check your password</font>';
                                document.getElementById("idconfirmpassword").style.border = 'red solid 1px';
                            } else if (res == 'email_invalid') {
                                alert('Invalid email address. Please check the link.');
                            } else {
                                alert(res);
                                frm1["email"].value = '';
                                frm1["password"].value = '';
                                frm1["confirmpassword"].value = '';
                                window.location = "SignIn.jsp";
                            }
                        }
                    }

                    a.open("POST", "ResetPasswordServlet", true);
                    a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    a.send("email=" + email + "&time=" + time + "&password=" + password + "&confirmpassword=" + confirmpassword);

                }
            }
            
            function removeBorder(ab) {

                if (ab == "password") {
                    document.getElementById('msg_password').innerHTML = '<br>';
                    document.getElementById("idpassword").style.border = '';
                } else if (ab == "confirmpassword") {
                    document.getElementById('msg_confirmpassword').innerHTML = '<br>';
                    document.getElementById("idconfirmpassword").style.border = '';
                }

            }

        </script>

    </head>
    <body>

    <center>
        <img src="HomeImages/header.gif" />
        <h2>Reset Password</h2>
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
                    Please enter your new password<br><br><br>
                </div>
                <table border="0">

                    <input type="hidden" name="email" value="<%=request.getParameter("e")%>" style="width: 250px" />
                    <input type="hidden" name="time" value="<%=request.getParameter("t")%>" style="width: 250px" />
                    <tr>
                        <td><br></td>
                    </tr>
                    <tr>
                        <td>New Password</td>
                        <td>:</td>
                        <td><input type="password" name="password" value="" style="width: 250px" id="idpassword" class="text" onclick="removeBorder('password')" onkeypress="removeBorder('password')"/></td>
                    </tr>
                    <tr>
                        <td colspan="3" id="msg_password" style="color: red" align="right"><br></td>
                    </tr>
                    <tr>
                        <td>Re-enter New Password</td>
                        <td>:</td>
                        <td><input type="password" name="confirmpassword" value="" style="width: 250px" id="idconfirmpassword" class="text" onclick="removeBorder('confirmpassword')" onkeypress="removeBorder('confirmpassword')"/></td>
                    </tr>
                    <tr>
                        <td colspan="3" id="msg_confirmpassword" style="color: red" align="right"><br></td>
                    </tr>
                    <tr>
                        <td colspan="1"><div class="content" id="loading"></div></td>
                        <td colspan="2" align="right"><br><input type="submit" value="SUBMIT" class="button-search"/><br><br></td>
                    </tr>
                </table>

            </form>

        </div>
        <br><br>
        <div class="content">
            Copyright 2013 | The Phone Arcade |  All rights reserved&nbsp;
            Use of this Web site constitutes acceptance of the TPA <a href="PrivacyPolicy.jsp" title="Privacy Policy" class="alink">Privacy Policy</a> and <a href="TermsAndConditions.jsp" title="Terms and Conditions" class="alink">Terms and Conditions</a>.</div>
        <br><br>
    </center>

</body>
</html>
