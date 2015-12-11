<%-- 
    Document   : Admin-SignIn
    Created on : Nov 4, 2013, 11:45:44 AM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TPA - Admin Sign In</title>

        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        %>
        
        <link rel="stylesheet" href="css/newAdmin.css" type="text/css"/>

        <script type="text/javascript">

        </script>

    </head>
    <body>

    <center>
        
        <table border="0" width="100%">
            <tr>
                <td><img src="AdminImages/tpa head.gif" /></td>
            </tr>
        </table>
        <hr>
        
        <div class="content"><h1>Administrator Panel - Sign In</h1></div>
        <br>
        <div class="sign">
            <form action="AdminSignIn" method="POST">

                <img src="AdminImages/signin.png" height="180px" width="auto"/>
                
                <h4>
                <font color="red">
                
                <%
                    if (request.getParameter("msg") != null) {
                        out.write(request.getParameter("msg"));
                    }
                %>

                </font>
                </h4>
                <table border="0">

                    <tr>
                        <td>Email</td>
                        <td>:</td>
                        <td><input type="text" name="email" value="" style="width: 250px" /></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td>:</td>
                        <td><input type="password" name="password" value="" style="width: 250px" /></td>
                    </tr>

                    <tr>
                        <td colspan="3" align="right"><input type="submit" value="SIGN IN" class="button1"/><br><br></td>
                    </tr>
                </table>

            </form>
        </div>

    </center>

</body>
</html>

