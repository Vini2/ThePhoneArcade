/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.Category;
import HibernateClasses.Make;
import HibernateClasses.PoolManager;
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
@WebServlet(name = "AdminAddMake", urlPatterns = {"/AdminAddMake"})
public class AdminAddMake extends HttpServlet {

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

            if (request.getParameter("make").equals("")) {
                response.sendRedirect("Admin-AddMake.jsp?msg=Error1");
            } else {

                Session s = PoolManager.getSessionFactory().openSession();
                Transaction t = s.beginTransaction();

                Criteria cr = s.createCriteria(Make.class);
                cr.add(Restrictions.eq("makeName", request.getParameter("make")));
                Make make = (Make) cr.uniqueResult();

                if (make == null) {

                    Make m = new Make();
                    m.setMakeName(request.getParameter("make"));

                    s.save(m);
                    t.commit();

                    response.sendRedirect("Admin-AddMake.jsp?msg=Success");
                } else {
                    response.sendRedirect("Admin-AddMake.jsp?msg=Error2");
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
