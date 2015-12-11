<%-- 
    Document   : Admin-AddProduct
    Created on : Oct 28, 2013, 1:43:12 PM
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

        <div class="content"><h2>Add New Product - Mobile Device</h2></div>

        <div class="content">
            <%
                if (request.getParameter("msg") != null) {
                    out.write(request.getParameter("msg"));
                }
            %>
        </div>
        <br>

        <form method="POST" action="AdminAddProductServlet" onsubmit="validate(this);
                return false;" enctype="multipart/form-data" id="testform">
            <center>

                <div class="register">

                    <table border="0" width="475">
                        <tr>
                            <td colspan="3"><h3>General</h3><hr></td>
                        </tr>
                        <tr>
                            <td>Make</td>
                            <td>:</td>
                            <td><select name="make" style="width: 303px" id="idmake" class="text" >
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
                            <td><select name="category" style="width: 303px" id="idcategory" class="text" >
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
                            <td><input type="text" name="name" value="" style="width: 300px" id="idname" class="text" /></td>
                        </tr>
                        <tr>
                            <td width="145"></td>
                            <td colspan="3" id="msg_name" style="color: red"><br></td>
                        </tr>

                        <tr>
                            <td>Description</td>
                            <td>:</td>
                            <td><textarea name="desc" rows="4" cols="20" style="width: 297px" id="iddesc" class="text" ></textarea></td>
                        </tr>
                        <tr>
                            <td width="145"></td>
                            <td colspan="3" id="msg_desc" style="color: red"><br></td>
                        </tr>

                        <tr>
                            <td>Special Price</td>
                            <td>:</td>
                            <td><input type="text" name="sprice" value="" style="width: 300px" id="idsprice" class="text" /></td>
                        </tr>
                        <tr>
                            <td width="145"></td>
                            <td colspan="3" id="msg_sprice" style="color: red"><br></td>
                        </tr>

                        <tr>
                            <td>Customer Price</td>
                            <td>:</td>
                            <td><input type="text" name="cprice" value="" style="width: 300px" id="idcprice" class="text" /></td>
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
                                        <input type="file" name="images" id="images" multiple="multiple" class="text" />
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

                    </table>


                    <table border="0" width="475">

                        <tr>
                            <td colspan="3"><hr><h3>Specifications</h3><hr></td>
                        </tr>

                        <tr>
                            <td colspan="3"><h4>General</h4></td>
                        </tr>
                        <tr>
                            <td style="width: 300px">2G Network</td>
                            <td>:</td>
                            <td><input type="text" name="general_2G_network" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>3G Network</td>
                            <td>:</td>
                            <td><input type="text" name="general_3G_network" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>4G Network</td>
                            <td>:</td>
                            <td><input type="text" name="general_4G_network" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>SIM</td>
                            <td>:</td>
                            <td><input type="text" name="general_sim" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Announced</td>
                            <td>:</td>
                            <td><input type="text" name="general_announced" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Status</td>
                            <td>:</td>
                            <td><input type="text" name="general_status" value="" style="width: 300px" class="text" /></td>
                        </tr>

                        <tr>
                            <td colspan="3"><h4>Body</h4></td>
                        </tr>
                        <tr>
                            <td>Dimensions</td>
                            <td>:</td>
                            <td><input type="text" name="body_dimensions" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Weight</td>
                            <td>:</td>
                            <td><input type="text" name="body_weight" value="" style="width: 300px" class="text" /></td>
                        </tr>

                        <tr>
                            <td colspan="3"><h4>Display</h4></td>
                        </tr>
                        <tr>
                            <td>Type</td>
                            <td>:</td>
                            <td><input type="text" name="display_type" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Size</td>
                            <td>:</td>
                            <td><input type="text" name="display_size" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Multitouch</td>
                            <td>:</td>
                            <td><input type="text" name="display_multitouch" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Protection</td>
                            <td>:</td>
                            <td><input type="text" name="display_protection" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><h4>Sound</h4></td>
                        </tr>
                        <tr>
                            <td>Alert types</td>
                            <td>:</td>
                            <td><input type="text" name="sound_alert_type" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Loudspeaker</td>
                            <td>:</td>
                            <td><input type="text" name="sound_loudspeaker" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>3.5mm jack</td>
                            <td>:</td>
                            <td><input type="text" name="sound_35mm_jack" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><h4>Memory</h4></td>
                        </tr>
                        <tr>
                            <td>Card slot</td>
                            <td>:</td>
                            <td><input type="text" name="memory_card_slot" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Internal</td>
                            <td>:</td>
                            <td><input type="text" name="memory_internal" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><h4>Data</h4></td>
                        </tr>
                        <tr>
                            <td>GPRS</td>
                            <td>:</td>
                            <td><input type="text" name="data_gprs" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>EDGE</td>
                            <td>:</td>
                            <td><input type="text" name="data_edge" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Speed</td>
                            <td>:</td>
                            <td><input type="text" name="data_speed" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>WLAN</td>
                            <td>:</td>
                            <td><input type="text" name="data_wlan" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Bluetooth</td>
                            <td>:</td>
                            <td><input type="text" name="data_bluetooth" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>NFC</td>
                            <td>:</td>
                            <td><input type="text" name="data_nfc" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Infrared port</td>
                            <td>:</td>
                            <td><input type="text" name="data_infrared_port" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>USB</td>
                            <td>:</td>
                            <td><input type="text" name="data_usb" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><h4>Camera</h4></td>
                        </tr>
                        <tr>
                            <td>Primary</td>
                            <td>:</td>
                            <td><input type="text" name="camera_primary" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Features</td>
                            <td>:</td>
                            <td><input type="text" name="camera_features" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Video</td>
                            <td>:</td>
                            <td><input type="text" name="camera_video" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Secondary</td>
                            <td>:</td>
                            <td><input type="text" name="camera_secondary" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><h4>Features</h4></td>
                        </tr>
                        <tr>
                            <td>OS</td>
                            <td>:</td>
                            <td><input type="text" name="features_os" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Chipset</td>
                            <td>:</td>
                            <td><input type="text" name="features_chipset" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>CPU</td>
                            <td>:</td>
                            <td><input type="text" name="features_cpu" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>GPU</td>
                            <td>:</td>
                            <td><input type="text" name="features_gpu" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Sensors</td>
                            <td>:</td>
                            <td><input type="text" name="features_sensors" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Messaging</td>
                            <td>:</td>
                            <td><input type="text" name="features_messaging" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Browser</td>
                            <td>:</td>
                            <td><input type="text" name="features_browser" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Radio</td>
                            <td>:</td>
                            <td><input type="text" name="features_radio" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>GPS</td>
                            <td>:</td>
                            <td><input type="text" name="features_gps" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Java</td>
                            <td>:</td>
                            <td><input type="text" name="features_java" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Colors</td>
                            <td>:</td>
                            <td><input type="text" name="features_colours" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><h4>Battery</h4></td>
                        </tr>
                        <tr>
                            <td>Type</td>
                            <td>:</td>
                            <td><input type="text" name="battery_type" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Stand-by</td>
                            <td>:</td>
                            <td><input type="text" name="battery_standby" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Talk time</td>
                            <td>:</td>
                            <td><input type="text" name="battery_talktime" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Music play</td>
                            <td>:</td>
                            <td><input type="text" name="battery_music_play" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><h4>Misc</h4></td>
                        </tr>
                        <tr>
                            <td>SAR US</td>
                            <td>:</td>
                            <td><input type="text" name="misc_sar_us" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>SAR EU</td>
                            <td>:</td>
                            <td><input type="text" name="misc_sar_eu" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><h4>Tests</h4></td>
                        </tr>
                        <tr>
                            <td>Display</td>
                            <td>:</td>
                            <td><input type="text" name="tests_display" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Loudspeaker</td>
                            <td>:</td>
                            <td><input type="text" name="tests_loudspeaker" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Audio quality</td>
                            <td>:</td>
                            <td><input type="text" name="tests_audio_quality" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Camera</td>
                            <td>:</td>
                            <td><input type="text" name="tests_camera" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td>Battery life</td>
                            <td>:</td>
                            <td><input type="text" name="tests_battery_life" value="" style="width: 300px" class="text" /></td>
                        </tr>
                        <tr>
                            <td colspan="3" align="right">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="3" align="right"><hr><input type="submit" value="SAVE PRODUCT" class="button1"/></td>
                        </tr>
                    </table>
                </div>
            </center>
        </form>
    </center>
    <%}%>
</body>
</html>


