<%-- 
    Document   : AdminPanel
    Created on : Oct 31, 2013, 11:15:57 AM
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

    </head>
    <body>

        <table border="0" width="100%">
            <tr>
                <td width="800"><img src="AdminImages/tpa head.gif" /></td>
                <td align="center"><div class="content"><h1>Administrator Panel</h1></div></td>
                <td align="right">
                    <font style="font-family:'Arial'; font-size:12px">
                    <a href="Home.jsp" class="alink">Home</a>&nbsp;&nbsp;<br>
                    <a href="AdminSignOut" class="alink">Sign Out</a>&nbsp;&nbsp;
                    </font>
                </td>
            </tr>
        </table>
        <hr>
        <br>
        <table border="0" width="1200" align="center">
            <tr>
                <td>
                    <div class="content"><h3>Product and Sales Management</h3></div>
                    <a href="Admin-AddProduct.jsp">
                        <div class="paneltab content">
                            <center>
                                Add New Product - Mobile Device<br>
                                <img src="AdminImages/add new product mobile device.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-AddProductOther.jsp">
                        <div class="paneltab content">
                            <center>
                                Add New Product - Accessory<br>
                                <img src="AdminImages/Add new product - accessory.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-AddCategory.jsp">
                        <div class="paneltab content">
                            <center>
                                Add New Category<br>
                                <img src="AdminImages/Add new category.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-AddMake.jsp">
                        <div class="paneltab content">
                            <center>
                                Add New Make<br>
                                <img src="AdminImages/Add new make.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
            <tr>
                <td>
                    <a href="Admin-ViewSalesHistory.jsp">
                        <div class="paneltab content">
                            <center>
                                View Sales History<br>
                                <img src="AdminImages/View stock.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-UpdateProductDetails.jsp">
                        <div class="paneltab content">
                            <center>
                                Update Product Details<br>
                                <img src="AdminImages/Update product details.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-AddStock.jsp">
                        <div class="paneltab content">
                            <center>
                                Add/View Stock<br>
                                <img src="AdminImages/Add stock.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-DeleteProduct.jsp">
                        <div class="paneltab content">
                            <center>
                                Remove Product<br>
                                <img src="AdminImages/Remove product.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                </td>
            </tr>
            <tr>
                <td>
                    <br>
                    <div class="content"><h3>User Management</h3></div>
                    <a href="Admin-ViewUserDetails.jsp">
                        <div class="paneltab content">
                            <center>
                                View User Details<br>
                                <img src="AdminImages/View user details.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-ViewUserPurchaseHistory.jsp">
                        <div class="paneltab content">
                            <center>
                                View User Purchase History<br>
                                <img src="AdminImages/View user purchase history.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-ManageUserAccounts.jsp">
                        <div class="paneltab content">
                            <center>
                                Manage User Accounts<br>
                                <img src="AdminImages/Manage user accounts.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                    <a href="Admin-AddNewAdmin.jsp">
                        <div class="paneltab content">
                            <center>
                                Add New Administrator<br>
                                <img src="AdminImages/Add new admins.png" width="170" height="auto"/>
                            </center>
                        </div></a>
                </td>
            </tr>
        </table>
        <br><br>
        <hr><br>

        <%}%>
    </body>
</html>
