package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.hibernate.criterion.Order;
import HibernateClasses.Category;
import org.hibernate.criterion.Restrictions;
import HibernateClasses.UserLogin;
import java.util.List;
import HibernateClasses.Product;
import org.hibernate.Criteria;
import HibernateClasses.PoolManager;
import org.hibernate.Session;

public final class Home_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>The Phone Arcade - Home</title>\n");
      out.write("\n");
      out.write("        ");

            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        
      out.write("\n");
      out.write("\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/style.css\" type=\"text/css\"/>\n");
      out.write("        <link href=\"css/modern-menu-my.css\" type=\"text/css\" rel=\"stylesheet\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/jquery-ui.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/style1.css\" />\n");
      out.write("\n");
      out.write("        <script src=\"js/jquery-1.10.2.min.js\"></script>\n");
      out.write("        <script src=\"js/jquery-ui.js\"></script>\n");
      out.write("        <script src=\"js/jquery.modern-menu.min.js\" type=\"text/javascript\"></script>\n");
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
      out.write("            });\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("    <center>\n");
      out.write("        <div id=\"tab\">\n");
      out.write("            <table width=\"1000\" height=\"2000\" border=\"0\" cellpadding=\"0\">\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"3\" height=\"100\">\n");
      out.write("                        <img src=\"HomeImages/header.gif\" />\n");
      out.write("                    </td>\n");
      out.write("                    <td colspan=\"2\" height=\"100\" align=\"right\">\n");
      out.write("                        <font style=\"font-family:'Arial'; font-size:12px\">\n");
      out.write("                        ");

                            if (request.getSession().getAttribute("user") != null) {
                                UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
                                if (ul.getUser().getUserType().getTypeName().equals("Buyer")) {
      out.write("\n");
      out.write("\n");
      out.write("                        Welcome ");
      out.print(ul.getUser().getFirstName());
      out.write("&nbsp;<br>\n");
      out.write("                        <a href=\"MyWishlist.jsp\" class=\"alink\">My Wishlist</a>&nbsp;&nbsp;|&nbsp;\n");
      out.write("                        <a href=\"MyCart.jsp\" class=\"alink\">My Cart</a>&nbsp;&nbsp;|&nbsp;\n");
      out.write("                        <a href=\"BuyerHistory.jsp\" class=\"alink\">History</a>&nbsp;&nbsp;|&nbsp;\n");
      out.write("                        <a href=\"SignOutServlet\" class=\"alink\">Sign Out</a>&nbsp;<br><br>\n");
      out.write("                        ");
} else {
      out.write("\n");
      out.write("                        <a href=\"AdminPanel.jsp\" class=\"alink\">Administrator Panel</a>&nbsp;<br><br>\n");
      out.write("                        ");
}
                        } else {
      out.write("\n");
      out.write("                        <a href=\"SignIn.jsp\" class=\"alink\">Sign In</a>&nbsp;&nbsp;|&nbsp;\n");
      out.write("                        <a href=\"SignUp.jsp\" class=\"alink\">Sign Up</a>&nbsp;<br><br><br>\n");
      out.write("                        ");
}
      out.write("\n");
      out.write("\n");
      out.write("                        <div class=\"ui-widget\">\n");
      out.write("                            <form action=\"Search\" method=\"POST\">\n");
      out.write("                                <input name=\"search\" id=\"tags\" class=\"searchtext\"/><input type=\"submit\" value=\"SEARCH\" class=\"button-search\" />\n");
      out.write("                            </form>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        </font>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td height=\"40\" colspan=\"5\" width=\"498\">\n");
      out.write("\n");
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
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" align=\"right\" height=\"30\">\n");
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"300\" align=\"center\">\n");
      out.write("\n");
      out.write("                        <script type=\"text/javascript\" src=\"HomeGallery/js/swfobject.js\"></script>\n");
      out.write("                        <script type=\"text/javascript\" src=\"HomeGallery/js/flashgallery.js\"></script>\n");
      out.write("                        <script type=\"text/javascript\">\n");
      out.write("                            jQuery.flashgallery('HomeGallery/HomeGallery.swf', 'HomeGallery/config.xml', {width: '900px', height: '400px', background: 'transparent'});\n");
      out.write("                        </script>\n");
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"200\">\n");
      out.write("                        <br><br>\n");
      out.write("                        <div class=\"homeslide\">\n");
      out.write("                            <img src=\"HomeImages/h2_color.png\"/><br>\n");
      out.write("                            <p align=\"justify\" class=\"content\">With a handful of smartphones, tablets and devices, not to mention copious amounts of mid- to low-range models, some with multiple variants, it is quite easy to get lost in the the world of modern-day mobile devices. Samsung, who is probably one of the greatest offenders, probably knows this too well and has put out an infographic that spells out in easy-to-understand images and marketing lingo the features of its latest masterpieces, the Galaxy Note 3 smartphone and the Galaxy Gear companion smartwatch.</p>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"50\">\n");
      out.write("                        <br><br>\n");
      out.write("                        <div><h2>New Arrivals - Phones</h2></div>\n");
      out.write("                        <hr>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"200\">\n");
      out.write("\n");
      out.write("                        ");


                            Criteria c1 = s1.createCriteria(Category.class);
                            c1.add(Restrictions.eq("categoryName", "Phone"));
                            Category cat1 = (Category) c1.uniqueResult();

                            Criteria c3 = s1.createCriteria(Product.class);
                            c3.add(Restrictions.eq("status", "Available"));
                            c3.add(Restrictions.eq("category", cat1));
                            c3.addOrder(Order.desc("idproduct"));
                            c3.setMaxResults(4);

                            List<Product> lpp = c3.list();

                            for (Product p : lpp) {

                        
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                        <div class=\"resultstab\">\n");
      out.write("\n");
      out.write("                            <table width=\"200\" height=\"300\" border=\"0\" align=\"center\">\n");
      out.write("                                <tr>\n");
      out.write("                                    <td>\n");
      out.write("                                <center><img src=\"");
      out.print(p.getImagePath());
      out.write("\" height=\"200\" width=\"auto\"/></center>\n");
      out.write("                                </td>\n");
      out.write("                                </tr>\n");
      out.write("                                <tr>\n");
      out.write("                                    <td align=\"center\" height=\"40\">");
      out.print(p.getMake().getMakeName() + " " + p.getName());
      out.write("</td>\n");
      out.write("                                </tr>\n");
      out.write("                                <tr>\n");
      out.write("                                    <td align=\"center\">\n");
      out.write("                                        <a href=\"ViewDetails.jsp?pid=");
      out.print(p.getIdproduct());
      out.write("\"><input type=\"submit\" value=\"VIEW\" class=\"button-search\" style=\"width: 100px\"/></a>\n");
      out.write("\n");
      out.write("                                    </td>\n");
      out.write("                                </tr>\n");
      out.write("\n");
      out.write("                            </table>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                        ");
}
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"50\">\n");
      out.write("                        <br><div><h2>New Arrivals - Tablets</h2></div>\n");
      out.write("                        <hr>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\" height=\"200\">\n");
      out.write("\n");
      out.write("                        ");

                            Criteria c2 = s1.createCriteria(Category.class);
                            c2.add(Restrictions.eq("categoryName", "Tablet"));
                            Category cat2 = (Category) c2.uniqueResult();

                            Criteria c4 = s1.createCriteria(Product.class);
                            c4.add(Restrictions.eq("status", "Available"));
                            c4.add(Restrictions.eq("category", cat2));
                            c4.addOrder(Order.desc("idproduct"));
                            c4.setMaxResults(4);

                            List<Product> lpt = c4.list();

                            for (Product p : lpt) {

                        
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                        <div class=\"resultstab\">\n");
      out.write("\n");
      out.write("                            <table width=\"200\" height=\"300\" border=\"0\" align=\"center\">\n");
      out.write("                                <tr>\n");
      out.write("                                    <td>\n");
      out.write("                                <center><img src=\"");
      out.print(p.getImagePath());
      out.write("\" height=\"200\" width=\"auto\"/></center>\n");
      out.write("                                </td>\n");
      out.write("                                </tr>\n");
      out.write("                                <tr>\n");
      out.write("                                    <td align=\"center\" height=\"40\">");
      out.print(p.getMake().getMakeName() + " " + p.getName());
      out.write("</td>\n");
      out.write("                                </tr>\n");
      out.write("                                <tr>\n");
      out.write("                                    <td align=\"center\">\n");
      out.write("                                        <a href=\"ViewDetails.jsp?pid=");
      out.print(p.getIdproduct());
      out.write("\"><input type=\"submit\" value=\"VIEW\" class=\"button-search\" style=\"width: 100px\"/></a>\n");
      out.write("\n");
      out.write("                                    </td>\n");
      out.write("                                </tr>\n");
      out.write("\n");
      out.write("                            </table>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                        ");
}
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"5\"></td>\n");
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
      out.write("                                    <li><div class=\"about\">+94 (034) 2221068</div></li>\n");
      out.write("                                    <li><div class=\"about\">+94 (034) 4902250</div></li>\n");
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
      out.write("</body>\n");
      out.write("</html>\n");
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
