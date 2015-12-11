<%-- 
    Document   : SignUp
    Created on : Oct 2, 2013, 8:59:55 PM
    Author     : Asus
--%>

<%@page import="captchas.CaptchasDotNet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Phone Arcade - Sign Up</title>

        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <link rel="stylesheet" href="css/style4.css" type="text/css"/>

        <script type="text/javascript">

            function validate(myform) {


                var firstname = myform["firstname"].value;
                var lastname = myform["lastname"].value;
                var gender = myform["gender"].value;
                var address = myform["address"].value;
                var email = myform["email"].value;
                var mobile = myform["mobile"].value;
                var password = myform["password"].value;
                var confirmpassword = myform["confirmpassword"].value;
                var captcha = myform["captcha"].value;

                var myboolean = new Boolean();

                myboolean = true;

                if (firstname == "") {
                    myboolean = false;
                    document.getElementById('msg_firstname').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter first name</font>';
                    document.getElementById("idfirstname").style.border = 'red solid 1px';

                }
                else {
                    document.getElementById('msg_firstname').innerHTML = '<br>';
                    document.getElementById("idfirstname").style.border = '';
                }

                if (lastname == "") {
                    myboolean = false;
                    document.getElementById('msg_lastname').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter last name</font>';
                    document.getElementById("idlastname").style.border = 'red solid 1px';

                }
                else {
                    document.getElementById('msg_lastname').innerHTML = '<br>';
                    document.getElementById("idlastname").style.border = '';
                }

                if (gender == "") {
                    myboolean = false;
                    document.getElementById('msg_gender').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select gender</font>';
                    document.getElementById("idgender").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_gender').innerHTML = '<br>';
                    document.getElementById("idgender").style.border = '';
                }

                if (address == "") {
                    myboolean = false;
                    document.getElementById('msg_address').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter address</font>';
                    document.getElementById("idaddress").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_address').innerHTML = '<br>';
                    document.getElementById("idaddress").style.border = '';
                }

                if (mobile == "") {
                    myboolean = false;
                    document.getElementById('msg_mobile').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter mobile no</font>';
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

                if (email == "") {
                    myboolean = false;
                    document.getElementById('msg_email').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter an email address</font>';
                    document.getElementById("idemail").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_email').innerHTML = '<br>';
                    document.getElementById("idemail").style.border = '';
                }

                if (password == "") {
                    myboolean = false;
                    document.getElementById('msg_password').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a password</font>';
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
                    document.getElementById('msg_confirmpassword').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Check your password</font>';
                    document.getElementById("idconfirmpassword").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_confirmpassword').innerHTML = '<br>';
                    document.getElementById("idconfirmpassword").style.border = '';
                }

                if (captcha == "") {
                    myboolean = false;
                    document.getElementById('msg_captcha').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter the captcha code</font>';
                    document.getElementById("idcaptcha").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_captcha').innerHTML = '<br>';
                    document.getElementById("idcaptcha").style.border = '';
                }

                if (myboolean == true) {
                    signUp(myform);
                }
            }


            function signUp(frm1) {

                var a;

                var firstname = frm1["firstname"].value;
                var lastname = frm1["lastname"].value;
                var gender = frm1["gender"].value;
                var address = frm1["address"].value;
                var email = frm1["email"].value;
                var mobile = frm1["mobile"].value;
                var password = frm1["password"].value;
                var confirmpassword = frm1["confirmpassword"].value;
                var captcha = frm1["captcha"].value;


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

                            if (res == 'The email address entered already exists.') {
                                document.getElementById('msg_email').innerHTML = 'The email address entered already exists';
                                document.getElementById("idemail").style.border = 'red solid 1px';
                            } else if (res == 'firstname_null') {
                                document.getElementById('msg_firstname').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter first name</font>';
                                document.getElementById("idfirstname").style.border = 'red solid 1px';
                            } else if (res == 'lastname_null') {
                                document.getElementById('msg_lastname').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter last name</font>';
                                document.getElementById("idlastname").style.border = 'red solid 1px';
                            } else if (res == 'gender_null') {
                                document.getElementById('msg_gender').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select gender</font>';
                                document.getElementById("idgender").style.border = 'red solid 1px';
                            } else if (res == 'address_null') {
                                document.getElementById('msg_address').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter address</font>';
                                document.getElementById("idaddress").style.border = 'red solid 1px';
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
                            } else if (res == 'password_null') {
                                document.getElementById('msg_password').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a password</font>';
                                document.getElementById("idpassword").style.border = 'red solid 1px';
                            } else if (res == 'confirmpassword_null') {
                                document.getElementById('msg_confirmpassword').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please confirm your password</font>';
                                document.getElementById("idconfirmpassword").style.border = 'red solid 1px';
                            } else if (res == 'confirmpassword_mismatch') {
                                document.getElementById('msg_confirmpassword').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Check your password</font>';
                                document.getElementById("idconfirmpassword").style.border = 'red solid 1px';
                            } else if (res == 'captcha_null') {
                                document.getElementById('msg_captcha').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter the captcha code</font>';
                                document.getElementById("idcaptcha").style.border = 'red solid 1px';
                            } else if (res == 'success') {

                                frm1["firstname"].value = "";
                                frm1["lastname"].value = "";
                                frm1["gender"].value = "";
                                frm1["address"].value = "";
                                frm1["email"].value = "";
                                frm1["mobile"].value = "";
                                frm1["password"].value = "";
                                frm1["confirmpassword"].value = "";
                                frm1["captcha"].value = "";
                                alert("Registration Successful...! Please check your mail.");
                            } else {
                                document.getElementById('msg_captcha').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;' + res + '</font>';
                                document.getElementById("idcaptcha").style.border = 'red solid 1px';
                            }
                        }
                    }

                    a.open("POST", "SignUpServlet", true);
                    a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    a.send("firstname=" + firstname + "&lastname=" + lastname + "&gender=" + gender + "&address=" + address + "&email=" + email + "&mobile=" + mobile + "&password=" + password + "&confirmpassword=" + confirmpassword + "&captcha=" + captcha);

                }
            }

            function removeBorder(ab) {

                if (ab == "firstname") {
                    document.getElementById('msg_firstname').innerHTML = '<br>';
                    document.getElementById("idfirstname").style.border = '';
                } else if (ab == "lastname") {
                    document.getElementById('msg_lastname').innerHTML = '<br>';
                    document.getElementById("idlastname").style.border = '';
                } else if (ab == "gender") {
                    document.getElementById('msg_gender').innerHTML = '<br>';
                    document.getElementById("idgender").style.border = '';
                } else if (ab == "address") {
                    document.getElementById('msg_address').innerHTML = '<br>';
                    document.getElementById("idaddress").style.border = '';
                } else if (ab == "mobile") {
                    document.getElementById('msg_mobile').innerHTML = '<br>';
                    document.getElementById("idmobile").style.border = '';
                } else if (ab == "email") {
                    document.getElementById('msg_email').innerHTML = '<br>';
                    document.getElementById("idemail").style.border = '';
                } else if (ab == "password") {
                    document.getElementById('msg_password').innerHTML = '<br>';
                    document.getElementById("idpassword").style.border = '';
                } else if (ab == "confirmpassword") {
                    document.getElementById('msg_confirmpassword').innerHTML = '<br>';
                    document.getElementById("idconfirmpassword").style.border = '';
                } else if (ab == "captcha") {
                    document.getElementById('msg_captcha').innerHTML = '<br>';
                    document.getElementById("idcaptcha").style.border = '';
                }

            }


        </script>

    </head>
    <body>


    <center>
        <img src="HomeImages/header.gif" />
        <h2>Sign Up</h2>
        <h4>Get Started - Create your personal account</h4>

        <div class="sign">

            <form action="" onsubmit="validate(this);
                return false;" method="POST" id="testform">
                <table border="0">

                    <tr>
                        <td width="140">First Name</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="firstname" value="" style="width: 250px" id="idfirstname" class="text" onclick="removeBorder('firstname')" onkeypress="removeBorder('firstname')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_firstname" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Last Name</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="lastname" value="" style="width: 250px" id="idlastname" class="text" onclick="removeBorder('lastname')" onkeypress="removeBorder('lastname')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_lastname" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Gender</td>
                        <td width="5">:</td>
                        <td width="255"><select name="gender" style="width: 262px" id="idgender" class="text" onclick="removeBorder('gender')">
                                <option value="">---Select Gender---</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_gender" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Address</td>
                        <td width="5">:</td>
                        <td width="255"><textarea name="address" rows="5" cols="20" style="width: 247px" id="idaddress" class="text" onclick="removeBorder('address')" onkeypress="removeBorder('address')"></textarea></td>

                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_address" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Mobile</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="mobile" value="" style="width: 250px" id="idmobile" class="text" onclick="removeBorder('mobile')" onkeypress="removeBorder('mobile')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_mobile" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td width="140">Email</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="email" value="" style="width: 250px" id="idemail" class="text" onclick="removeBorder('email')" onkeypress="removeBorder('email')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_email" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td width="140">Password</td>
                        <td width="5">:</td>
                        <td width="255"><input type="password" name="password" value="" style="width: 250px" id="idpassword" class="text" onclick="removeBorder('password')" onkeypress="removeBorder('password')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" width="255" id="msg_password" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td width="140">Confirm Password</td>
                        <td width="5">:</td>
                        <td width="255"><input type="password" name="confirmpassword" value="" style="width: 250px" id="idconfirmpassword" class="text" onclick="removeBorder('confirmpassword')" onkeypress="removeBorder('confirmpassword')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_confirmpassword" style="color: red;"><br></td>
                    </tr>

                    <tr>
                        <td width="140">Enter Captcha</td>
                        <td width="5">:</td>
                        <td width="255">
                            <input type="text" name="captcha" value="" style="width: 250px" id="idcaptcha" class="text" onclick="removeBorder('captcha')" onkeypress="removeBorder('captcha')"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_captcha" style="color: red;"><br></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td width="5"></td>
                        <td width="255">
                            <%
// Construct the captchas object (Default Values)
                                CaptchasDotNet captchas = new captchas.CaptchasDotNet(
                                        request.getSession(true), // Ensure session
                                        "vinimal", // client
                                        "OL6JPLRXtN8p7Banl9AQGvtQzgexQMASc3oBYizB" // secret
                                        );

                            %>
                            <%= captchas.image()%><br>
                            <a href="<%= captchas.audioUrl()%>" class="alink">Phonetic spelling (mp3)</a>&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>


                    <tr>
                        <td colspan="3">
                            <br><br>By clicking <b>SIGN UP</b> I agree that :<br>
                            - I'm older than 16 years<br>
                            - I have read and accepted the <a href="TermsAndConditions.jsp" class="alink">Terms and Conditions</a> and <a href="PrivacyPolicy.jsp" class="alink">Privacy Policy</a><br>
                            <br>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"><div class="content" id="loading"></div></td>
                        <td colspan="2" align="right"><input type="submit" value="SIGN UP" class="button-search"/><br><br></td>
                    </tr>

                </table>

            </form>

            <!--            Already signed up? <a href="SignIn.jsp" class="alink">Sign In</a>&nbsp;&nbsp;&nbsp;&nbsp;<br><br>-->

            <a href="SignIn.jsp" class="a-btn">
                <span class="a-btn-text">Already a member?</span> 
                <span class="a-btn-slide-text">SIGN IN</span>
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
