<%-- 
    Document   : Admin-AddProductOther
    Created on : Oct 28, 2013, 1:43:41 PM
    Author     : Asus
--%>

<%@page import="HibernateClasses.UserLogin"%>
<%@page import="HibernateClasses.Category"%>
<%@page import="java.util.List"%>
<%@page import="HibernateClasses.Make"%>
<%@page import="org.hibernate.Criteria"%>
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

            function validate(myform) {



                var make = myform["make"].value;
                var category = myform["category"].value;
                var name = myform["name"].value;
                var desc = myform["desc"].value;
                var sprice = myform["sprice"].value;
                var cprice = myform["cprice"].value;
                var images = myform["images"].value;

                var myboolean = new Boolean();

                myboolean = true;

                if (make == "") {
                    myboolean = false;
                    document.getElementById('msg_make').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select a make</font>';
                    document.getElementById("idmake").style.border = 'red solid 1px';

                }
                else {
                    document.getElementById('msg_make').innerHTML = '<br>';
                    document.getElementById("idmake").style.border = '';
                }

                if (category == "") {
                    myboolean = false;
                    document.getElementById('msg_category').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select a category</font>';
                    document.getElementById("idcategory").style.border = 'red solid 1px';

                }
                else {
                    document.getElementById('msg_category').innerHTML = '<br>';
                    document.getElementById("idcategory").style.border = '';
                }

                if (name == "") {
                    myboolean = false;
                    document.getElementById('msg_name').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a name</font>';
                    document.getElementById("idname").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_name').innerHTML = '<br>';
                    document.getElementById("idname").style.border = '';
                }

                if (desc == "") {
                    myboolean = false;
                    document.getElementById('msg_desc').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a description</font>';
                    document.getElementById("iddesc").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_desc').innerHTML = '<br>';
                    document.getElementById("iddesc").style.border = '';
                }

                if (sprice == "") {
                    myboolean = false;
                    document.getElementById('msg_sprice').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a special price</font>';
                    document.getElementById("idsprice").style.border = 'red solid 1px';
                }
                else if (isNaN(sprice)) {
                    myboolean = false;
                    document.getElementById('msg_sprice').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid special price</font>';
                    document.getElementById("idsprice").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_sprice').innerHTML = '<br>';
                    document.getElementById("idsprice").style.border = '';
                }

                if (cprice == "") {
                    myboolean = false;
                    document.getElementById('msg_cprice').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a customer price </font>';
                    document.getElementById("idcprice").style.border = 'red solid 1px';
                }
                else if (isNaN(cprice)) {
                    myboolean = false;
                    document.getElementById('msg_cprice').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please enter a valid customer price</font>';
                    document.getElementById("idcprice").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_cprice').innerHTML = '<br>';
                    document.getElementById("idcprice").style.border = '';
                }

                if (images == "") {
                    myboolean = false;
                    document.getElementById('msg_images').innerHTML = '<font size="-1">&nbsp;&nbsp;&nbsp;Please select an image</font>';
                    document.getElementById("images").style.border = 'red solid 1px';
                }
                else {
                    document.getElementById('msg_images').innerHTML = '<br>';
                    document.getElementById("images").style.border = '';
                }

                if (myboolean == true) {
                    document.form("testform").submit();
                }

            }


            function removeBorder(ab) {

                if (ab == "make") {
                    document.getElementById('msg_make').innerHTML = '<br>';
                    document.getElementById("idmake").style.border = '';
                } else if (ab == "category") {
                    document.getElementById('msg_category').innerHTML = '<br>';
                    document.getElementById("idcategory").style.border = '';
                } else if (ab == "name") {
                    document.getElementById('msg_name').innerHTML = '<br>';
                    document.getElementById("idname").style.border = '';
                } else if (ab == "desc") {
                    document.getElementById('msg_desc').innerHTML = '<br>';
                    document.getElementById("iddesc").style.border = '';
                } else if (ab == "sprice") {
                    document.getElementById('msg_sprice').innerHTML = '<br>';
                    document.getElementById("idsprice").style.border = '';
                } else if (ab == "cprice") {
                    document.getElementById('msg_cprice').innerHTML = '<br>';
                    document.getElementById("idcprice").style.border = '';
                } else if (ab == "images") {
                    document.getElementById('msg_images').innerHTML = '<br>';
                    document.getElementById("idimages").style.border = '';
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

        <h2>Add New Product - Accessory</h2>

        <div class="content">
            <%
                if (request.getParameter("msg") != null) {
                    if (request.getParameter("msg").equals("Error1")) {
            %>
            Make sure you have filled all the fields.
            <%} else if (request.getParameter("msg").equals("Error2")) {%>
            Please enter a valid price.
            <%} else if(request.getParameter("msg").equals("Success")){%>
            Product registered successfully...!
            <%}}%>
        </div>
        <br>

        <form method="POST" action="AdminAddProductOtherServlet" onsubmit="validate(this);
                return false;" enctype="multipart/form-data" id="testform">
            <div class="register">
                <table border="0">
                    <tr>
                        <td>Make</td>
                        <td>:</td>
                        <td><select name="make" style="width: 253px" id="idmake" class="text" onclick="removeBorder('make')">
                                <option value="">---Select Make---</option>
                                <%
                                    Session s = PoolManager.getSessionFactory().openSession();
                                    Criteria c1 = s.createCriteria(Make.class);
                                    List<Make> lm = c1.list();
                                    for (Make m : lm) {
                                %>
                                <option value="<%=m.getMakeName()%>"><%=m.getMakeName()%></option>
                                <%}%>
                            </select></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_make" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Category</td>
                        <td>:</td>
                        <td><select name="category" style="width: 253px" id="idcategory" class="text" onclick="removeBorder('category')">
                                <option value="">---Select Category---</option>
                                <%
                                    Criteria c2 = s.createCriteria(Category.class);
                                    List<Category> lc = c2.list();
                                    for (Category c : lc) {
                                %>
                                <option value="<%=c.getIdcategory()%>"><%=c.getCategoryName()%></option>
                                <%}%>
                            </select></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_category" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Name/Model</td>
                        <td>:</td>
                        <td><input type="text" name="name" value="" style="width: 250px" id="idname"  class="text" onclick="removeBorder('name')" onkeypress="removeBorder('name')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_name" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Description</td>
                        <td>:</td>
                        <td><textarea name="desc" rows="4" cols="20" style="width: 247px" id="iddesc"  class="text" onclick="removeBorder('desc')" onkeypress="removeBorder('desc')"></textarea></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_desc" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Special Price</td>
                        <td>:</td>
                        <td><input type="text" name="sprice" value="" style="width: 250px" id="idsprice" class="text" onclick="removeBorder('sprice')" onkeypress="removeBorder('sprice')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_sprice" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Customer Price</td>
                        <td>:</td>
                        <td><input type="text" name="cprice" value="" style="width: 250px" id="idcprice"  class="text" onclick="removeBorder('cprice')" onkeypress="removeBorder('cprice')"/></td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_cprice" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td>Image</td>
                        <td>:</td>
                        <td>
                            <div id="main">
                                <h4>Upload Your Images</h4
                                <form method="post" enctype="multipart/form-data">
                                    <input type="file" name="images" id="images" multiple="multiple" style="width: 258px" class="text" onclick="removeBorder('images')"/>
                                    <button type="submit" id="btn">Upload Files!</button>
                                </form>
                                <div id="response"></div>
                                <ul id="image-list">

                                </ul>
                            </div>
                            <script src="js/jquery-1.10.2.min.js"></script>
                            <script src="js/upload.js"></script>
                        </td>
                    </tr>
                    <tr>
                        <td width="145"></td>
                        <td colspan="3" id="msg_images" style="color: red"><br></td>
                    </tr>

                    <tr>
                        <td colspan="3" align="right"><input type="submit" value="SAVE PRODUCT" class="button1"/></td>
                    </tr>
                </table>
            </div>
        </form>

    </center>
    <%}%>
</body>
</html>

