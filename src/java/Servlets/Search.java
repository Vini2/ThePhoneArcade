/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.PoolManager;
import HibernateClasses.Product;
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
@WebServlet(name = "Search", urlPatterns = {"/Search"})
public class Search extends HttpServlet {

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

            String a = request.getParameter("search");
            String b = a.trim();

            if (b.equals("")) {
                response.sendRedirect("NoResultsFound.jsp");
            } else {

                try {
                    
                    String name = request.getParameter("search");

                    String[] name1 = name.split(" ", 2);

                    Session s = PoolManager.getSessionFactory().openSession();
                    Transaction t = s.beginTransaction();

                    Criteria c = s.createCriteria(Product.class);
                    c.add(Restrictions.eq("name", name1[1]));
                    Product p = (Product) c.uniqueResult();

                    if (p == null) {
                        response.sendRedirect("NoResultsFound.jsp");
                    } else {
                        if (p.getCategory().getCategoryName().equals("Accessory")) {
                            response.sendRedirect("ViewDetailsAccessory.jsp?pid=" + p.getIdproduct());
                        } else {
                            response.sendRedirect("ViewDetails.jsp?pid=" + p.getIdproduct());
                        }
                    }
                    
                } catch (ArrayIndexOutOfBoundsException ae) {
                    response.sendRedirect("NoResultsFound.jsp");
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
