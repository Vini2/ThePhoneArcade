<%-- 
    Document   : newjsp
    Created on : Oct 3, 2013, 9:26:01 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.Category"%>
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
        %>

        <title>The Phone Arcade - Details</title>

        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <link href="css/modern-menu-my.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/jquery.modern-menu.min.js" type="text/javascript"></script>

        <script type="text/javascript">

            function load() {

                alert("OK");

                var category = document.getElementById('idcategory').value;

                

                alert("OK1");

                var a;

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
                            
                            document.getElementById('idsubcategory').innerHTML = res;
                            
                        }
                    }

                    a.open("POST", "NewServlet", true);
                    a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    a.send("category=" + category);

                }

            }

            function show(){
                document.getElementById("iddiv").innerHTML = document.getElementById('idsubcategory').value;
            }





        </script>


    </head>
    <body>
    <center>

        <select name="category" id="idcategory" onchange="load()">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
        </select>

        <select name="subcategory" id="idsubcategory">
        </select>

        <div id="iddiv"></div>
        
        <input type="submit" value="Show" onclick="show()" />

    </center>
</body>
</html>