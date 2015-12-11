<%-- 
    Document   : Admin-AddNewAdmin
    Created on : Nov 4, 2013, 4:35:27 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.UserLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TPA - Admin Panel</title>

        <link rel="stylesheet" href="css/newAdmin.css" />

        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
            if (ul == null) {
                response.sendRedirect("SignIn.jsp?msg=Please login and continue");
            } else if (!ul.getUser().getUserType().getTypeName().equals("Admin")) {
                response.sendRedirect("SignIn.jsp?msg=Restricted... Only administrators allowed");
            } else {
        %>

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


                if (window.XMLHttpRequest) {
                    a = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    a = new ActiveXObject("Microsoft.XMLHTTP");
                } else {
                    alert("Browser does not support AJAX");
                }

                if (a != null) {
                    a.onreadystatechange = function() {
                        if (a.readyState === 4) {
                            var res = a.responseText;


                            if (res == 'The email address entered already exists.') {
                                document.getElementById('msg_email').innerHTML = 'The email entered already exists';
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
                            }
                            else {

                                frm1["firstname"].value = "";
                                frm1["lastname"].value = "";
                                frm1["gender"].value = "";
                                frm1["address"].value = "";
                                frm1["email"].value = "";
                                frm1["mobile"].value = "";
                                frm1["password"].value = "";
                                frm1["confirmpassword"].value = "";
                                alert(res);
                            }
                        }
                    }

                    a.open("POST", "AdminAddNewAdmin", true);
                    a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    a.send("firstname=" + firstname + "&lastname=" + lastname + "&gender=" + gender + "&address=" + address + "&email=" + email + "&f=" + email + "&mobile=" + mobile + "&password=" + password + "&confirmpassword=" + confirmpassword);

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
                }

            }


        </script>

    </head>
    <body>


    <center>

        <table border="0" width="100%">
            <tr>
                <td><a href="AdminPanel.jsp" title="Admin Panel"><img src="AdminImages/tpa head.gif" /></a></td>
                <td align="right">
                    <font style="font-family:'Arial'; font-size:12px">
                    <a href="Home.jsp" class="alink">Home</a>&nbsp;&nbsp;<br>
                    <a href="AdminSignOut" class="alink">Sign Out</a>&nbsp;&nbsp;
                    </font>
                </td>
            </tr>
        </table>
        <hr>

        <div class="content"><h2>Add New Administrator</h2></div>

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
                        <td width="255"><textarea name="address" rows="3" cols="20" style="width: 247px" id="idaddress" class="text" onclick="removeBorder('address')" onkeypress="removeBorder('address')"></textarea></td>

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
                        <td colspan="3" align="right"><input type="submit" value="ADD ADMIN" class="button1"/><br></td>
                    </tr>

                </table>

            </form>
        </div>

    </center>
    <%}%>
</body>
</html>
