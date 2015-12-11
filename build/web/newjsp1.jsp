<%-- 
    Document   : newjsp1
    Created on : Dec 7, 2013, 3:02:38 PM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link rel="stylesheet" href="css/newAdmin.css" />

        <script src="jqueryCalendar/jquery-1.6.2.min.js"></script>
        <script src="jqueryCalendar/jquery-ui-1.8.15.custom.min.js"></script>
        <link rel="stylesheet" href="jqueryCalendar/jqueryCalendar.css">
        <script>
            jQuery(function() {
                jQuery("#id_date").datepicker();
                jQuery("#id_date1").datepicker();
            });

            $(document).ready(function() {
                $("#id_date").datepicker({
                    numberOfMonths: 2,
                    onSelect: function(selected) {
                        $("#id_date1").datepicker("option", "minDate", selected)
                    }
                });
                $("#id_date1").datepicker({
                    numberOfMonths: 2,
                    onSelect: function(selected) {
                        $("#id_date").datepicker("option", "maxDate", selected)
                    }
                });
            });

        </script>

    </head>
    <body>
        <h1>Hello World!</h1>

        From : 
        <input type="text" name="startDate" value="" id="id_date" class="text" readonly="readonly" />&nbsp;&nbsp;&nbsp;&nbsp;
        To :
        <input type="text" name="endDate" value="" id="id_date1" class="text" readonly="readonly" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" value="VIEW" class="button1" style="width: 100px"/>

    </body>
</html>
