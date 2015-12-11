package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import HibernateClasses.SystemStatus;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;
import HibernateClasses.Category;
import org.hibernate.criterion.Order;
import HibernateClasses.ProductInContainer;
import HibernateClasses.Container;
import org.hibernate.criterion.Restrictions;
import HibernateClasses.ContainerType;
import java.util.List;
import HibernateClasses.Product;
import org.hibernate.Criteria;
import org.hibernate.Session;
import HibernateClasses.PoolManager;
import HibernateClasses.UserLogin;

public final class BuyerHistory_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>The Phone Arcade - Purchase History</title>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        ");

            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            if (request.getSession().getAttribute("user") == null) {
                response.sendRedirect("SignIn.jsp?msg=Please login and continue");
            } else {
                UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
        
      out.write("\n");
      out.write("\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/style.css\" type=\"text/css\"/>\n");
      out.write("        <link href=\"css/modern-menu-my.css\" type=\"text/css\" rel=\"stylesheet\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/jquery-ui.css\" />\n");
      out.write("        <script src=\"js/jquery-1.10.2.min.js\"></script>\n");
      out.write("        <script src=\"js/jquery-ui.js\"></script>\n");
      out.write("        <script src=\"js/jquery.modern-menu.min.js\" type=\"text/javascript\"></script>\n");
      out.write("        <script src=\"js/jqFancyTransitions.1.8.js\" type=\"text/javascript\"></script>\n");
      out.write("\n");
      out.write("        ");

            Session s1 = PoolManager.getSessionFactory().openSession();
            Criteria cc = s1.createCriteria(Category.class);
            cc.add(Restrictions.eq("categoryName", "Accessory"));
            Category catl = (Category) cc.uniqueResult();
        
      out.write("\n");
      out.write("\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("            $(function() {\n");
      out.write("\n");
      out.write("            ");

                Criteria c = s1.createCriteria(Product.class);
                c.add(Restrictions.eq("status", "Available"));
                c.add(Restrictions.not(Restrictions.eq("category", catl)));
                c.addOrder(Order.asc("make"));
                List<Product> lp1 = c.list();
            
      out.write("\n");
      out.write("                var availableTags = [\n");
      out.write("\n");
      out.write("            ");

                for (Product p : lp1) {
            
      out.write("\n");
      out.write("                \"");
      out.print(p.getMake().getMakeName() + " " + p.getName());
      out.write("\",\n");
      out.write("            ");
}
      out.write("\n");
      out.write("                ];\n");
      out.write("                        $(\"#tags\").autocomplete({\n");
      out.write("                    source: availableTags\n");
      out.write("                });\n");
      out.write("            });</script>\n");
      out.write("\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("\n");
      out.write("            function period() {\n");
      out.write("\n");
      out.write("                var p = document.getElementById('idperiod').value;\n");
      out.write("                if (p == 'Yesterday') {\n");
      out.write("            ");

                Calendar sdate1 = Calendar.getInstance();
                sdate1.add(Calendar.DATE, - 1);
                Calendar edate1 = Calendar.getInstance();

            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(sdate1.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((sdate1.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(sdate1.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    var edate1 = ");
      out.print(edate1.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((edate1.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(edate1.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("//                    document.getElementById(\"id_date\").disabled= true;\n");
      out.write("//                    document.getElementById(\"id_date1\").disabled= true;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'Today') {\n");
      out.write("            ");

                Calendar sdate2 = Calendar.getInstance();
                Calendar edate2 = Calendar.getInstance();
                edate2.add(Calendar.DATE, +1);

            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(sdate2.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((sdate2.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(sdate2.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    var edate1 = ");
      out.print(edate2.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((edate2.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(edate2.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'This Week') {\n");
      out.write("            ");

                Calendar today = Calendar.getInstance();
                int dyofweek = today.get(Calendar.DAY_OF_WEEK);
                dyofweek--;
                today.add(Calendar.DATE, -dyofweek);
            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(today.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today.get(Calendar.YEAR));
      out.write(";\n");
      out.write("            ");

                today.add(Calendar.DATE, +6);

            
      out.write("\n");
      out.write("                    var edate1 = ");
      out.print(today.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'Last Week') {\n");
      out.write("            ");

                Calendar today1 = Calendar.getInstance();
                int week = today1.get(Calendar.DAY_OF_WEEK);
                int lastweek = week + 6;
                today1.add(Calendar.DATE, -lastweek);
            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(today1.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today1.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today1.get(Calendar.YEAR));
      out.write(";\n");
      out.write("            ");

                today1.add(Calendar.DATE, +6);

            
      out.write("\n");
      out.write("\n");
      out.write("                    var edate1 = ");
      out.print(today1.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today1.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today1.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'This Month') {\n");
      out.write("            ");

                Calendar today2 = Calendar.getInstance();
                int thismonth = today2.get(Calendar.DAY_OF_MONTH);
                thismonth--;
                today2.add(Calendar.DATE, -thismonth);
            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(today2.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today2.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today2.get(Calendar.YEAR));
      out.write(";\n");
      out.write("            ");

                today2.add(Calendar.MONTH, +1);
                today2.add(Calendar.DATE, -1);
            
      out.write("\n");
      out.write("\n");
      out.write("                    var edate1 = ");
      out.print(today2.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today2.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today2.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'Last Month') {\n");
      out.write("            ");

                Calendar today3 = Calendar.getInstance();
                int thismonth1 = today3.get(Calendar.DAY_OF_MONTH);
                thismonth1--;
                today3.add(Calendar.DATE, -thismonth1);
                today3.add(Calendar.MONTH, - 1);
            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(today3.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today3.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today3.get(Calendar.YEAR));
      out.write(";\n");
      out.write("            ");

                today3.add(Calendar.MONTH, +1);
                today3.add(Calendar.DATE, -1);
            
      out.write("\n");
      out.write("\n");
      out.write("                    var edate1 = ");
      out.print(today3.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today3.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today3.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'Last 3 Months') {\n");
      out.write("            ");

                Calendar today4 = Calendar.getInstance();
                int thismonth2 = today4.get(Calendar.DAY_OF_MONTH);
                thismonth2--;
                today4.add(Calendar.DATE, -thismonth2);
                today4.add(Calendar.MONTH, - 3);
            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(today4.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today4.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today4.get(Calendar.YEAR));
      out.write(";\n");
      out.write("            ");

                today4.add(Calendar.MONTH, +3);
                today4.add(Calendar.DATE, -1);
            
      out.write("\n");
      out.write("\n");
      out.write("                    var edate1 = ");
      out.print(today4.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today4.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today4.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'This Year') {\n");
      out.write("            ");

                Calendar today5 = Calendar.getInstance();
                int thismonth3 = today5.get(Calendar.DAY_OF_MONTH);
                int months = today5.get(Calendar.MONTH);
                thismonth3--;
                today5.add(Calendar.DATE, -thismonth3);
                today5.add(Calendar.MONTH, -months);
            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(today5.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today5.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today5.get(Calendar.YEAR));
      out.write(";\n");
      out.write("            ");

                today5.add(Calendar.MONTH, +12);
                today5.add(Calendar.DATE, -1);
            
      out.write("\n");
      out.write("\n");
      out.write("                    var edate1 = ");
      out.print(today5.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today5.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today5.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'Last Year') {\n");
      out.write("            ");

                Calendar today6 = Calendar.getInstance();
                int thismonth4 = today6.get(Calendar.DAY_OF_MONTH);
                int months1 = today6.get(Calendar.MONTH);
                thismonth4--;
                today6.add(Calendar.DATE, -thismonth4);
                today6.add(Calendar.MONTH, -months1);
                today6.add(Calendar.YEAR, - 1);
            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(today6.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today6.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today6.get(Calendar.YEAR));
      out.write(";\n");
      out.write("            ");

                today6.add(Calendar.MONTH, +12);
                today6.add(Calendar.DATE, -1);
            
      out.write("\n");
      out.write("\n");
      out.write("                    var edate1 = ");
      out.print(today6.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today6.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today6.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("                else if (p == 'Last 3 Years') {\n");
      out.write("            ");

                Calendar today7 = Calendar.getInstance();
                int thismonth5 = today7.get(Calendar.DAY_OF_MONTH);
                int months2 = today7.get(Calendar.MONTH);
                thismonth5--;
                today7.add(Calendar.DATE, -thismonth5);
                today7.add(Calendar.MONTH, -months2);
                today7.add(Calendar.YEAR, -3);
            
      out.write("\n");
      out.write("                    var sdate1 = ");
      out.print(today7.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today7.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today7.get(Calendar.YEAR));
      out.write(";\n");
      out.write("            ");

                today7.add(Calendar.DATE, -1);
                today7.add(Calendar.YEAR, +3);
            
      out.write("\n");
      out.write("\n");
      out.write("                    var edate1 = ");
      out.print(today7.get(Calendar.DATE));
      out.write(" + \"/\" +");
      out.print((today7.get(Calendar.MONTH) + 1));
      out.write(" + \"/\" +");
      out.print(today7.get(Calendar.YEAR));
      out.write(";\n");
      out.write("                    document.getElementById('id_date').value = sdate1;\n");
      out.write("                    document.getElementById('id_date1').value = edate1;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("    <center>\n");
      out.write("        <div id=\"tab\">\n");
      out.write("            <table width=\"1000\" height=\"2000\" border=\"0\" cellpadding=\"0\">\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"3\" height=\"100\">\n");
      out.write("                        <img src=\"HomeImages/header.gif\" />\n");
      out.write("                    </td>\n");
      out.write("                    <td colspan=\"2\" height=\"100\" align=\"right\">\n");
      out.write("                        <font style=\"font-family:'Arial'; font-size:12px\">\n");
      out.write("\n");
      out.write("                        Welcome ");
      out.print(ul.getUser().getFirstName());
      out.write("&nbsp;<br>\n");
      out.write("                        ");
 if (ul.getUser().getUserType().getTypeName().equals("Buyer")) {
      out.write("\n");
      out.write("                        <a href=\"MyWishlist.jsp\" class=\"alink\">My Wishlist</a>&nbsp;&nbsp;|&nbsp;\n");
      out.write("                        <a href=\"MyCart.jsp\" class=\"alink\">My Cart</a>&nbsp;&nbsp;|&nbsp;\n");
      out.write("                        <a href=\"BuyerHistory.jsp\" class=\"alink\">History</a>&nbsp;&nbsp;|&nbsp;\n");
      out.write("                        <a href=\"SignOutServlet\" class=\"alink\">Sign Out</a>&nbsp;<br><br>\n");
      out.write("                        ");
}
      out.write("\n");
      out.write("                        <div class=\"ui-widget\">\n");
      out.write("                            <form action=\"Search\" method=\"POST\">\n");
      out.write("                                <input name=\"search\" id=\"tags\" class=\"searchtext\"/><input type=\"submit\" value=\"SEARCH\" class=\"button-search\" />\n");
      out.write("                            </form>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                        </font>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td height=\"40\" colspan=\"5\" width=\"498\">\n");
      out.write("                        <div>\n");
      out.write("                            <ul class=\"modern-menu theme6\">\n");
      out.write("                                <li><a href=\"Home.jsp\"><span>HOME</span></a></li>\n");
      out.write("                                <li><a href=\"#\"><span>MOBILE DEVICESˇ</span></a>\n");
      out.write("                                    <ul><li><a href=\"Samsung.jsp\"><span>Samsung</span></a></li>\n");
      out.write("                                        <li><a href=\"Nokia.jsp\"><span>Nokia</span></a></li>\n");
      out.write("                                        <li><a href=\"Sony.jsp\"><span>Sony</span></a></li>\n");
      out.write("                                        <li><a href=\"LG.jsp\"><span>LG</span></a></li>\n");
      out.write("                                        <li><a href=\"Micromax.jsp\"><span>Micromax</span></a></li>\n");
      out.write("                                        <li><a href=\"E-tel.jsp\"><span>E-tel</span></a></li>\n");
      out.write("                                        <li><a href=\"MobileDevicesOther.jsp\"><span>Other</span></a></li></ul></li>\n");
      out.write("                                <li><a href=\"MobilePhoneAccessories.jsp\"><span>ACCESSORIESˇ</span></a>\n");
      out.write("                                    <ul><li><a href=\"Accessories.jsp?type=Battery\"><span>Batteries</span></a></li>\n");
      out.write("                                        <li><a href=\"Accessories.jsp?type=Charger\"><span>Chargers</span></a></li>\n");
      out.write("                                        <li><a href=\"Accessories.jsp?type=Cover\"><span>Covers</span></a></li>\n");
      out.write("                                        <li><a href=\"Accessories.jsp?type=Headset\"><span>Headsets</span></a></li>\n");
      out.write("                                        <li><a href=\"Accessories.jsp?type=ScreenGuard\"><span>Screen Guards</span></a></li>\n");
      out.write("                                        <li><a href=\"Accessories.jsp?type=Other\"><span>Other</span></a></li></ul></li>\n");
      out.write("                                <li><a href=\"#\"><span>SERVICESˇ</span></a>\n");
      out.write("                                    <ul><li><a href=\"Repairs.jsp\"><span>Repairs</span></a></li></ul></li>\n");
      out.write("                                <li><a href=\"#\"><span>ABOUT TPAˇ</span></a>\n");
      out.write("                                    <ul><li><a href=\"AboutUs.jsp\"><span>About Us</span></a></li>\n");
      out.write("                                        <li><a href=\"ContactUs.jsp\"><span>Contact Us</span></a></li></ul></li>\n");
      out.write("                                <ul class=\"mm-group mm-right\">\n");
      out.write("                                    <li class=\"mm-icon\"><a href=\"https://www.facebook.com/\"><span class=\"mm-facebook\"><img src=\"theme/facebook.png\"/></span></a></li>\n");
      out.write("                                    <li class=\"mm-icon\"><a href=\"https://twitter.com/\"><span class=\"mm-twitter\"><img src=\"theme/twitter.png\"/></span></a></li>\n");
      out.write("                                    <li class=\"mm-icon\"><a href=\"https://plus.google.com\"><span class=\"mm-googleplus\"><img src=\"theme/googleplus.png\"/></span></a></li>\n");
      out.write("                                    <li class=\"mm-icon\"><a href=\"https://www.linkedin.com\"><span class=\"mm-linkedin\"><img src=\"theme/linkedin.png\"/></span></a></li></ul></ul>\n");
      out.write("                            <hr>\n");
      out.write("                        </div>\n");
      out.write("                        <script type=\"text/javascript\">$(\".modern-menu\").modernMenu();</script>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td align=\"center\"  colspan=\"5\" height=\"100px\">\n");
      out.write("                        <div class=\"content\">\n");
      out.write("                            <h2 style=\"text-shadow: 5px 5px 5px #999999;\">Purchase History</h2><br><br>\n");
      out.write("\n");
      out.write("                            Select a Time Period : \n");
      out.write("                            <select name=\"period\" id=\"idperiod\" onchange=\"period()\" class=\"text\" style=\"width: 210px;\">\n");
      out.write("                                <option value=\"\">---Select Time Period---</option>\n");
      out.write("                                <option value=\"Today\">Today</option>\n");
      out.write("                                <option value=\"Yesterday\">Yesterday</option>\n");
      out.write("                                <option value=\"This Week\">This Week</option>\n");
      out.write("                                <option value=\"Last Week\">Last Week</option>\n");
      out.write("                                <option value=\"This Month\">This Month</option>\n");
      out.write("                                <option value=\"Last Month\">Last Month</option>\n");
      out.write("                                <option value=\"Last 3 Months\">Last 3 Months</option>\n");
      out.write("                                <option value=\"This Year\">This Year</option>\n");
      out.write("                                <option value=\"Last Year\">Last Year</option>\n");
      out.write("                                <option value=\"Last 3 Years\">Last 3 Years</option>\n");
      out.write("                            </select>\n");
      out.write("\n");
      out.write("                            <br><br>\n");
      out.write("                            <form action=\"BuyerGetDate\" method=\"POST\">\n");
      out.write("\n");
      out.write("                                Start date: \n");
      out.write("                                <input type=\"text\" name=\"startDate\" value=\"\" id=\"id_date\" class=\"text\" readonly=\"readonly\" />&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("                                End date :\n");
      out.write("                                <input type=\"text\" name=\"endDate\" value=\"\" id=\"id_date1\" class=\"text\" readonly=\"readonly\" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("                                <input type=\"submit\" value=\"VIEW\" class=\"button-search\" style=\"width: 100px\"/>\n");
      out.write("                            </form>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <br>\n");
      out.write("\n");
      out.write("\n");
      out.write("                        ");
if (request.getParameter("msg") != null) {
      out.write("\n");
      out.write("                        <div class=\"content\" style=\"color: red\">Please select a time period or enter a valid date range</div>\n");
      out.write("                        ");
}
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                ");

                    if (request.getParameter("y1") != null) {

                        Date sdate = new Date(Integer.parseInt(request.getParameter("y1")), Integer.parseInt(request.getParameter("m1")), Integer.parseInt(request.getParameter("d1")));
                        Date edate = new Date(Integer.parseInt(request.getParameter("y2")), Integer.parseInt(request.getParameter("m2")), Integer.parseInt(request.getParameter("d2")));

                        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

                        String sdateformats = formatter.format(sdate);
                        String edateformats = formatter.format(edate);

                
      out.write("\n");
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td align=\"center\"  colspan=\"5\" height=\"100px\">\n");
      out.write("                        <div class=\"content\"><h3>Purchase History from ");
      out.print(sdateformats);
      out.write(" to ");
      out.print(edateformats);
      out.write("</h3></div>\n");
      out.write("\n");
      out.write("                        <br>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                        ");


                            int index = 0;

                            if (request.getParameter("index") != null) {
                                index = Integer.parseInt(request.getParameter("index"));
                            }
                            double checkout_total = 0.0;

                            Criteria c2 = s1.createCriteria(SystemStatus.class);
                            c2.add(Restrictions.eq("statusName", "Purchased"));
                            SystemStatus ss = (SystemStatus) c2.uniqueResult();

                            Criteria c3 = s1.createCriteria(ContainerType.class);
                            c3.add(Restrictions.eq("typeName", "Cart"));
                            ContainerType ct = (ContainerType) c3.uniqueResult();

                            Criteria c4 = s1.createCriteria(Container.class);
                            c4.add(Restrictions.and(Restrictions.eq("user", ul.getUser()), Restrictions.eq("containerType", ct)));
                            Container con = (Container) c4.uniqueResult();

                            Criteria c5 = s1.createCriteria(ProductInContainer.class);
                            c5.add(Restrictions.between("addedDate", sdate, edate));
                            c5.add(Restrictions.eq("systemStatus", ss));
                            c5.add(Restrictions.eq("container", con));

                            int l = c5.list().size();

                            c5.setFirstResult(index);
                            c5.setMaxResults(10);

                            List<ProductInContainer> list = c5.list();

                            if (l > 0) {
                        
      out.write("\n");
      out.write("                        <div class=\"wishlist\">\n");
      out.write("                            <table border=\"0\" align=\"center\">\n");
      out.write("\n");
      out.write("\n");
      out.write("                                <tr class=\"content\">\n");
      out.write("                                    <th></th>\n");
      out.write("                                    <th></th>\n");
      out.write("                                    <th>Price</th>\n");
      out.write("                                    <th>Quantity</th>\n");
      out.write("                                    <th>Total</th>\n");
      out.write("                                    <th>Purchased Date</th>\n");
      out.write("                                </tr>\n");
      out.write("                                <tr>\n");
      out.write("                                    <td colspan=\"7\"><hr></td>\n");
      out.write("                                </tr>\n");
      out.write("\n");
      out.write("                                ");

                                    for (ProductInContainer pc : list) {

                                        String formats = formatter.format(pc.getAddedDate());

                                        checkout_total += pc.getAmount();
                                        double d = pc.getQty();
                                        int qty1 = (int) d;

                                
      out.write("\n");
      out.write("\n");
      out.write("                                <tr>\n");
      out.write("                                    <td align=\"center\">\n");
      out.write("                                        <img src=\"");
      out.print(pc.getProduct().getImagePath());
      out.write("\" height=\"200\" width=\"auto\"/>\n");
      out.write("                                    </td>\n");
      out.write("                                    <td width=\"250\">\n");
      out.write("                                        <h3>");
      out.print(pc.getProduct().getMake().getMakeName() + " " + pc.getProduct().getName());
      out.write("</h3>\n");
      out.write("                                    </td>\n");
      out.write("                                    <td width=\"120\" align=\"center\">\n");
      out.write("                                        <div class=\"content\">LKR ");
      out.print(pc.getProduct().getCustomerPrice());
      out.write("0</div>\n");
      out.write("                                    </td>\n");
      out.write("                                    <td width=\"70\" align=\"center\">\n");
      out.write("                                        <div class=\"content\">");
      out.print(qty1);
      out.write("</div>\n");
      out.write("                                    </td>\n");
      out.write("                                    <td width=\"180\">\n");
      out.write("                                        <h4>LKR ");
      out.print(pc.getAmount());
      out.write("0</h4>\n");
      out.write("                                    </td>\n");
      out.write("                                    <td align=\"center\">\n");
      out.write("                                        <div class=\"content\">");
      out.print(formats);
      out.write("</div>\n");
      out.write("                                    </td>\n");
      out.write("                                </tr>\n");
      out.write("                                <tr width=\"200\">\n");
      out.write("                                    <td colspan=\"7\"><hr></td>\n");
      out.write("                                </tr>\n");
      out.write("\n");
      out.write("                                ");
 }
      out.write("\n");
      out.write("\n");
      out.write("                            </table>\n");
      out.write("                            ");
 if (index > 0) {
      out.write("\n");
      out.write("                            <a href=\"BuyerHistory.jsp?index=");
      out.print( index - 10);
      out.write("&y1=");
      out.print(request.getParameter("y1"));
      out.write("&m1=");
      out.print(request.getParameter("m1"));
      out.write("&d1=");
      out.print(request.getParameter("d1"));
      out.write("&y2=");
      out.print(request.getParameter("y2"));
      out.write("&m2=");
      out.print(request.getParameter("m2"));
      out.write("&d2=");
      out.print(request.getParameter("d2"));
      out.write("\">\n");
      out.write("                                <input type=\"submit\" value=\"<< Back\" class=\"button-search\"/>\n");
      out.write("                            </a>\n");
      out.write("                            ");
 }
      out.write("\n");
      out.write("\n");
      out.write("                            ");
 if (index < l - 10) {
      out.write("\n");
      out.write("                            <a href=\"BuyerHistory.jsp?index=");
      out.print( index + 10);
      out.write("&y1=");
      out.print(request.getParameter("y1"));
      out.write("&m1=");
      out.print(request.getParameter("m1"));
      out.write("&d1=");
      out.print(request.getParameter("d1"));
      out.write("&y2=");
      out.print(request.getParameter("y2"));
      out.write("&m2=");
      out.print(request.getParameter("m2"));
      out.write("&d2=");
      out.print(request.getParameter("d2"));
      out.write("\">\n");
      out.write("                                <input type=\"submit\" value=\"Next >>\" class=\"button-search\"/>\n");
      out.write("                            </a>\n");
      out.write("                            ");
 }
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                        ");
} else {
      out.write("\n");
      out.write("                        <div class=\"content\"><img src=\"images/no result.jpg\" height=\"50px\" width=\"auto\"/>&nbsp;&nbsp;&nbsp;No results found for your search</div><br><br>\n");
      out.write("\n");
      out.write("                        ");
}
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                        ");
}
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"200\">\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\">&nbsp;</td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"200\">\n");
      out.write("                        <hr>\n");
      out.write("                        <div id=\"footer\">\n");
      out.write("                            <div class=\"detailstab\">\n");
      out.write("                                <h3>Mobile Phones</h3>\n");
      out.write("                                <ul>\n");
      out.write("                                    <li><a href=\"Samsung.jsp\" title=\"Samsung\">Samsung</a></li>\n");
      out.write("                                    <li><a href=\"Nokia.jsp\" title=\"Nokia\">Nokia</a></li>\n");
      out.write("                                    <li><a href=\"Sony.jsp\" title=\"SONY\">Sony</a></li>\n");
      out.write("                                    <li><a href=\"LG.jsp\" title=\"LG\">LG</a></li>\n");
      out.write("                                    <li><a href=\"Micromax.jsp\" title=\"Micromax\">Micromax</a></li>\n");
      out.write("                                    <li><a href=\"E-tel.jsp\" title=\"E-tel\">E-tel</a></li>\n");
      out.write("                                </ul>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"detailstab\">\n");
      out.write("                                <h3>Accessories</h3>\n");
      out.write("                                <ul>\n");
      out.write("                                    <li><a href=\"Accessories.jsp?type=Battery\" title=\"Batteries\">Batteries</a></li>\n");
      out.write("                                    <li><a href=\"Accessories.jsp?type=Charger\" title=\"Chargers\">Chargers</a></li>\n");
      out.write("                                    <li><a href=\"Accessories.jsp?type=Cover\" title=\"Cases\">Cases</a></li>\n");
      out.write("                                    <li><a href=\"Accessories.jsp?type=Headset\" title=\"Headsets\">Headsets</a></li>\n");
      out.write("                                    <li><a href=\"Accessories.jsp?type=ScreenGuard\" title=\"Screen Guards\">Screen Guards</a></li>\n");
      out.write("                                </ul>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"detailstab\">\n");
      out.write("                                <h3>Help & Support</h3>\n");
      out.write("                                <ul>\n");
      out.write("                                    <li><a href=\"TermsAndConditions.jsp\" title=\"Terms and Conditions\">Terms and Conditions</a></li>\n");
      out.write("                                    <li><a href=\"PrivacyPolicy.jsp\" title=\"Privacy Policy\">Privacy Policy</a></li>\n");
      out.write("                                </ul>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"detailstab\">\n");
      out.write("                                <h3>About TPA</h3>\n");
      out.write("                                <ul>\n");
      out.write("                                    <li><a href=\"AboutUs.jsp\" title=\"About Us\">About Us</a></li>\n");
      out.write("                                    <li><a href=\"ContactUs.jsp\" title=\"Contact Us\">Contact Us</a></li>\n");
      out.write("                                    <li><div class=\"about\">info.thephonearcadek@gmail.com</div></li>\n");
      out.write("                                    <li><div class=\"about\">+94 (77) 1234567</div></li>\n");
      out.write("                                    <li><div class=\"about\">+94 (77) 1234567</div></li>\n");
      out.write("                                </ul>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"5\"><hr /></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"3\" height=\"50\"><div class=\"content\">Copyright 2013 | The Phone Arcade |  All rights reserved</div></td>\n");
      out.write("                    <td height=\"50\" align=\"right\" colspan=\"2\">\n");
      out.write("                        <img src=\"HomeImages/Visa.jpg\" height=\"40\" width=\"auto\"/>\n");
      out.write("                        <img src=\"HomeImages/MasterCard.jpg\" height=\"40\" width=\"auto\"/>\n");
      out.write("                        <img src=\"HomeImages/american-express.jpg\" height=\"40\" width=\"auto\"/>\n");
      out.write("                        <img src=\"HomeImages/paypal_logo.jpg\" height=\"40\" width=\"auto\"/>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("            </table>\n");
      out.write("        </div>\n");
      out.write("    </center>\n");
      out.write("    ");
}
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
