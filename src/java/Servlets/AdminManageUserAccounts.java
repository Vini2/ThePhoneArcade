/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.PoolManager;
import HibernateClasses.SystemStatus;
import HibernateClasses.User;
import HibernateClasses.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Asus
 */
@WebServlet(name = "AdminManageUserAccounts", urlPatterns = {"/AdminManageUserAccounts"})
public class AdminManageUserAccounts extends HttpServlet {

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
            
            String sysStat = request.getParameter("sysid");
            String uid = request.getParameter("uid");
            
            Session s = PoolManager.getSessionFactory().openSession();
            Transaction t = s.beginTransaction();

            Criteria c = s.createCriteria(SystemStatus.class);
            c.add(Restrictions.eq("statusName", sysStat));
            SystemStatus ss = (SystemStatus) c.uniqueResult();
            
            User u = (User) s.load(User.class, Integer.parseInt(uid));
            
            Criteria c1 = s.createCriteria(UserLogin.class);
            c1.add(Restrictions.eq("user", u));
            UserLogin ul = (UserLogin) c1.uniqueResult();
            
            u.setSystemStatus(ss);
            s.update(u);
            
            ul.setSystemStatus(ss);
            s.update(ul);
            
            t.commit();
            
            response.sendRedirect("Admin-ManageUserAccounts.jsp");
            
            
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
