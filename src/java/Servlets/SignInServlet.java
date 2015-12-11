/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.LoginSession;
import HibernateClasses.PoolManager;
import HibernateClasses.SystemStatus;
import HibernateClasses.UserLogin;
import HibernateClasses.UserType;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.validator.routines.EmailValidator;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Asus
 */
@WebServlet(name = "SignInServlet", urlPatterns = {"/SignInServlet"})
public class SignInServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {

            boolean b = true;

            if (!EmailValidator.getInstance().isValid(request.getParameter("email"))) {
                b = false;
                response.sendRedirect("SignIn.jsp?msg=Error0");
            }

            if (b) {

                Session s = PoolManager.getSessionFactory().openSession();

                Transaction t = s.beginTransaction();

                Criteria cr = s.createCriteria(SystemStatus.class);
                cr.add(Restrictions.eq("statusName", "Suspended"));
                SystemStatus sus = (SystemStatus) cr.uniqueResult();

                Criteria c = s.createCriteria(UserLogin.class);
                c.add(Restrictions.eq("email", request.getParameter("email")));
                UserLogin ul = (UserLogin) c.uniqueResult();

                Criteria c1 = s.createCriteria(UserType.class);
                c1.add(Restrictions.eq("typeName", "Admin"));
                UserType ut = (UserType) c1.uniqueResult();

                if (ul == null) {
                    response.sendRedirect("SignIn.jsp?msg=Error1");

                } else if (!Security.decrypt(ul.getPassword()).equals(request.getParameter("password"))) {

                    if (ul.getUser().getUserType().equals(ut)) {
                        response.sendRedirect("SignIn.jsp?msg=Error1");
                    } else {

                        int count = 0;

                        if (request.getSession().getAttribute("login_count") == null) {
                            request.getSession().setAttribute("login_count", 1);
                            count = 1;
                        } else {
                            count = Integer.parseInt(request.getSession().getAttribute("login_count").toString());
                            count++;
                            request.getSession().setAttribute("login_count", count);

                        }

                        if (count == 3) {
                            ul.setSystemStatus(sus);

                            s.update(ul);

                            ul.getUser().setSystemStatus(sus);

                            s.update(ul.getUser());

                            response.sendRedirect("SignIn.jsp?msg=Error2");
                        } else {
                            response.sendRedirect("SignIn.jsp?msg=Error1");
                        }

                        t.commit();

                    }


                } else {

                    if (ul.getSystemStatus().getStatusName().equals("Active")) {

                        request.getSession().invalidate();

                        request.getSession().setAttribute("user", ul);

                        LoginSession ls = new LoginSession();
                        ls.setInTime(new Date());
                        ls.setOutTime(new Date());
                        ls.setIpAddress(request.getRemoteHost());
                        ls.setUserLogin(ul);

                        s.save(ls);

                        request.getSession().setAttribute("ses", ls);

                        t.commit();

                        if (ul.getUser().getUserType().equals(ut)) {
                            response.sendRedirect("AdminPanel.jsp");
                        } else {
                            response.sendRedirect("Home.jsp");
                        }


                    } else {
                        response.sendRedirect("SignIn.jsp?msg=Error3");
                    }
                }
            }


        } catch (Exception e) {
            throw new ServletException(e);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
