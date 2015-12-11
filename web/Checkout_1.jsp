<%-- 
    Document   : Checkout_1
    Created on : Dec 1, 2013, 9:30:37 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.Category"%>
<%@page import="HibernateClasses.Container"%>
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
        <title>The Phone Arcade - Checkout</title>

        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            if (request.getSession().getAttribute("user") == null) {
                response.sendRedirect("SignIn.jsp?msg=Please login and continue");
            } else {
                UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
                
                Session s1 = PoolManager.getSessionFactory().openSession();
                
                Container con = (Container) s1.load(Container.class, Integer.parseInt(request.getParameter("cid")));
                
                if(con.getTotalAmount()==0.0){
                    response.sendRedirect("Home.jsp");
                } else{

                
        %>

        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js"></script>
        <link rel="stylesheet" type="text/css" media="screen" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/base/jquery-ui.css">
            <script type="text/javascript">
                $(function() {
                    $('.date-picker').datepicker({
                        changeMonth: true,
                        changeYear: true,
                        showButtonPanel: true,
                        dateFormat: 'MM yy',
                        onClose: function(dateText, inst) {
                            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                            $(this).datepicker('setDate', new Date(year, month, 1));
                        }
                    });
                });
            </script>
            
            <style>
                .ui-datepicker-calendar {
                    display: none;
                }
            </style>

        <script type="text/javascript">


            function validate(myform) {

                var cardnoame = /^(?:3[47][0-9]{13})$/;
                var cardnovisa = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
                var cardnomaster = /^(?:5[1-5][0-9]{14})$/;

                var firstname = myform["firstname"].value;
                var lastname = myform["lastname"].value;
                var billaddress = myform["billaddress"].value;
                var email = myform["email"].value;
                var mobile = myform["mobile"].value;
                var cardtype = myform["cardtype"].value;
                var cardnumber = myform["cardnumber"].value;
                var expdate = myform["expdate"].value;
                var csc = myform["csc"].value;

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

                if (billaddress == "") {
                    myboolean = false;
                    document.getElementById('msg_billaddress').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your billing address</font>';
                    document.getElementById("idbilladdress").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_billaddress').innerHTML = '<br>';
                    document.getElementById("idbilladdress").style.border = '';
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

                if (cardtype == "") {
                    myboolean = false;
                    document.getElementById('msg_cardtype').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select your credit card type</font>';
                    document.getElementById("idcardtype").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_cardtype').innerHTML = '<br>';
                    document.getElementById("idcardtype").style.border = '';
                }

                if (cardnumber == "") {
                    myboolean = false;
                    document.getElementById('msg_cardnumber').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter your credit card number</font>';
                    document.getElementById("idcardnumber").style.border = 'red solid 1px';
                }
                else {
                    if (cardtype == "Visa") {
                        if (!cardnumber.match(cardnovisa)) {
                            myboolean = false;
                            document.getElementById('msg_cardnumber').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid credit card number</font>';
                            document.getElementById("idcardnumber").style.border = 'red solid 1px';
                        }
                    }
                    else if (cardtype == "Master Card") {
                        if (!cardnumber.match(cardnomaster)) {
                            myboolean = false;
                            document.getElementById('msg_cardnumber').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid credit card number</font>';
                            document.getElementById("idcardnumber").style.border = 'red solid 1px';
                        }
                    }
                    else if (cardtype == "American Express") {
                        if (!cardnumber.match(cardnoame)) {
                            myboolean = false;
                            document.getElementById('msg_cardnumber').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid credit card number</font>';
                            document.getElementById("idcardnumber").style.border = 'red solid 1px';
                        }
                    }
                    else {
                        document.getElementById('msg_cardnumber').innerHTML = '<br>';
                        document.getElementById("idcardnumber").style.border = '';
                    }
                }

                if (expdate == "") {
                    myboolean = false;
                    document.getElementById('msg_expdate').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter the expiry date</font>';
                    document.getElementById("startDate").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_expdate').innerHTML = '<br>';
                    document.getElementById("startDate").style.border = '';
                }

                if (csc == "") {
                    myboolean = false;
                    document.getElementById('msg_csc').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter the card security code</font>';
                    document.getElementById("idcsc").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_csc').innerHTML = '<br>';
                    document.getElementById("idcsc").style.border = '';
                }

                if (myboolean == true) {
                    document.form("testform").submit();
                }
            }


            function removeBorder(ab) {

                if (ab == "firstname") {
                    document.getElementById('msg_firstname').innerHTML = '<br>';
                    document.getElementById("idfirstname").style.border = '';
                } else if (ab == "lastname") {
                    document.getElementById('msg_lastname').innerHTML = '<br>';
                    document.getElementById("idlastname").style.border = '';
                } else if (ab == "billaddress") {
                    document.getElementById('msg_billaddress').innerHTML = '<br>';
                    document.getElementById("idbilladdress").style.border = '';
                } else if (ab == "deladdress") {
                    document.getElementById('msg_deladdress').innerHTML = '<br>';
                    document.getElementById("iddeladdress").style.border = '';
                } else if (ab == "mobile") {
                    document.getElementById('msg_mobile').innerHTML = '<br>';
                    document.getElementById("idmobile").style.border = '';
                } else if (ab == "email") {
                    document.getElementById('msg_email').innerHTML = '<br>';
                    document.getElementById("idemail").style.border = '';
                } else if (ab == "cardtype") {
                    document.getElementById('msg_cardtype').innerHTML = '<br>';
                    document.getElementById("idcardtype").style.border = '';
                } else if (ab == "cardnumber") {
                    document.getElementById('msg_cardnumber').innerHTML = '<br>';
                    document.getElementById("idcardnumber").style.border = '';
                } else if (ab == "expdate") {
                    document.getElementById('msg_expdate').innerHTML = '<br>';
                    document.getElementById("idexpdate").style.border = '';
                } else if (ab == "csc") {
                    document.getElementById('msg_csc').innerHTML = '<br>';
                    document.getElementById("idcsc").style.border = '';
                }

            }

        </script>

    </head>
    <body>

    <center>

        <img src="HomeImages/header.gif" />
        
        <br><br>
        <div class="content sign">

            <form action="Payment" method="POST" onsubmit="validate(this);
                return false;" id="testform">

                <input type="hidden" name="containerid" value="<%=con.getIdc()%>" />

                <table align="center" border="0">
                    <tr>
                        <td colspan="4">
                            <div class="content"><a href="Home.jsp" class="alink">Home</a> > <a href="MyCart.jsp" class="alink">My Cart</a> > Checkout<br><br></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align='center'><h2 style="text-shadow: 5px 5px 5px #999999;">Checkout - Review Order</h2></td>
                    </tr>
                    <tr>
                        <td colspan="4"><h3>Your Information</h3></td>
                    </tr>
                    <tr>
                        <td width="140">First Name</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="firstname" value="<%=ul.getUser().getFirstName()%>" style="width: 250px" id="idfirstname" class="text" onclick="removeBorder('firstname')" onkeypress="removeBorder('firstname')" readonly="readonly"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_firstname" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Last Name</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="lastname" value="<%=ul.getUser().getLastName()%>" style="width: 250px" id="idlastname" class="text" onclick="removeBorder('lastname')" onkeypress="removeBorder('lastname')" readonly="readonly"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_lastname" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Mobile</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="mobile" value="<%=ul.getUser().getMobile()%>" style="width: 250px" id="idmobile" class="text" onclick="removeBorder('mobile')" onkeypress="removeBorder('mobile')" readonly="readonly"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_mobile" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td width="140">Email</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="email" value="<%=ul.getEmail()%>" style="width: 250px" id="idemail" class="text" onclick="removeBorder('email')" onkeypress="removeBorder('email')" readonly="readonly"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_email" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td colspan="4"><h3>Billing Address</h3></td>
                    </tr>
                    <tr>
                        <td width="140">Address<br><br>(You can change your billing address if necessary)</td>
                        <td width="5">:</td>
                        <td width="255">
                            <textarea name="billaddress" rows="5" cols="20" style="width: 247px" id="idbilladdress" class="text" onclick="removeBorder('billaddress')" onkeypress="removeBorder('billaddress')"><%=ul.getUser().getAddress()%></textarea>
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_billaddress" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td colspan="4"><h3>Credit Card Information</h3></td>
                    </tr>
                    <tr>
                        <td width="140">Credit Card Type</td>
                        <td width="5">:</td>
                        <td width="255">
                            <select name="cardtype" style="width: 262px" id="idcardtype" class="text" onclick="removeBorder('cardtype')">
                                <option value="">---Select Card Type---</option>
                                <option value="Visa">Visa</option>
                                <option value="Master Card">Master Card</option>
                                <option value="American Express">American Express</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_cardtype" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Credit Card Number</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="cardnumber" value="" style="width: 250px" id="idcardnumber" class="text" onclick="removeBorder('cardnumber')" onkeypress="removeBorder('cardnumber')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_cardnumber" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Expiration Date</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="expdate" value="" style="width: 250px" class="text date-picker" onclick="removeBorder('expdate')" onkeypress="removeBorder('expdate')" id="startDate"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_expdate" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td width="140">Card Security Code</td>
                        <td width="5">:</td>
                        <td width="255"><input type="text" name="csc" value="" style="width: 250px" id="idcsc" class="text" onclick="removeBorder('csc')" onkeypress="removeBorder('csc')"/></td>
                        <td>&nbsp;&nbsp;<img src="HomeImages/csc.gif" height="32px" width="auto" style="float: inside"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_csc" style="color: red"><br></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center"><hr><h2>Your Total : LKR. <%=con.getTotalAmount()%>0</h2></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center"><br><input type="submit" value="PROCESS MY ORDER" class="button-search" style="width: 200px;"/><br><br></td>
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
    <%}}%>
</body>
</html>

