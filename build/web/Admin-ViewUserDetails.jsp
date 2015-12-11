<%-- 
    Document   : Admin-ViewUserDetails
    Created on : Nov 4, 2013, 3:27:17 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.UserLogin"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="HibernateClasses.UserType"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="HibernateClasses.User"%>
<%@page import="HibernateClasses.Product"%>
<%@page import="HibernateClasses.PoolManager"%>
<%@page import="org.hibernate.Session"%>
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

        <script>


            function show() {

                var a;

                var searchmethod = document.getElementById('idsearchmethod').value;
                var key = document.getElementById('idkey').value;

                myboolean = true;

                if (searchmethod == "") {
                    myboolean = false;
                    document.getElementById('msg_searchmethod').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select a search method</font>';
                    document.getElementById("idsearchmethod").style.border = 'red solid 1px';

                }
                else {
                    document.getElementById('msg_searchmethod').innerHTML = '<br>';
                    document.getElementById("idsearchmethod").style.border = '';
                }

                if (key == "") {
                    myboolean = false;

                }

                if (myboolean == true) {

                    if (window.XMLHttpRequest) {
                        a = new XMLHttpRequest();
                    } else if (window.ActiveXObject) {
                        a = new ActiveXOject("Microsoft.XMLHTTP");
                    } else {
                        alert("Browser does not support Ajax");
                    }

                    if (a != null) {
                        a.onreadystatechange = function() {

                            if (a.readyState < 4) {
                                document.getElementById('loading').innerHTML = 'Please wait... <img src="images/loader_transparent.gif" height="25px" width="auto"/>';
                            }

                            if (a.readyState === 4) {
                                var res = a.responseText;
                                document.getElementById('loading').innerHTML ='';
                                document.getElementById('search_results').innerHTML = res;
                            }
                        }

                        a.open("POST", "Admin-ViewUserDetails_1.jsp", true);
                        a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        a.send("key=" + key + "&searchmethod=" + searchmethod);
                    }
                }
            }

            function removeBorder() {

                document.getElementById('msg_searchmethod').innerHTML = '<br>';
                document.getElementById("idsearchmethod").style.border = '';
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

        <div class="content"><h2>View User Details</h2></div>


        <div class="content">

            <table border="0">
                <tr>
                    <td>Search User by :</td>
                    <td>
                        <select name="searchmethod" id="idsearchmethod" style="width: 200px;" class="text" onclick="removeBorder()">
                            <option value="">---Select Method---</option>
                            <option value="firstname">First Name</option>
                            <option value="lastname">Last Name</option>
                            <option value="emial">Email</option>
                        </select>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>Enter keyword : </td>
                    <td><input type="text" name="key" value="" class="text" id="idkey" onkeyup="show()"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td id="msg_searchmethod" style="color: red;"><br></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>



        </div>
        <br><br>
        <div class="content" id="loading"></div>

        <div id="search_results">

        </div>
    </center>

    <%}%>
</body>
</html>
