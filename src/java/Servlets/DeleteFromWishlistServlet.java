/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.Container;
import HibernateClasses.ContainerType;
import HibernateClasses.PoolManager;
import HibernateClasses.Product;
import HibernateClasses.ProductInContainer;
import HibernateClasses.User;
import HibernateClasses.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
@WebServlet(name = "DeleteFromWishlistServlet", urlPatterns = {"/DeleteFromWishlistServlet"})
public class DeleteFromWishlistServlet extends HttpServlet {

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
            System.out.println("Servlet");
            
            UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
            
            User r = ul.getUser();

            String pcid = request.getParameter("pcid");

            Session s = PoolManager.getSessionFactory().openSession();
            Transaction t = s.beginTransaction();

            Criteria c1 = s.createCriteria(ProductInContainer.class);
            c1.add(Restrictions.eq("pcId", Integer.parseInt(pcid)));
            ProductInContainer pc = (ProductInContainer) c1.uniqueResult();
            
            Product p = pc.getProduct();
            
            Criteria c = s.createCriteria(ContainerType.class);
            c.add(Restrictions.eq("typeName", "Wishlist"));
            ContainerType ct1 = (ContainerType) c.uniqueResult();
            
            Criteria c2 = s.createCriteria(Container.class);
            c2.add(Restrictions.and(Restrictions.eq("user", r), Restrictions.eq("containerType", ct1)));
            Container cnt = (Container) c2.uniqueResult();

            double tot = pc.getQty() * p.getCustomerPrice();
            
            cnt.setTotalProducts(cnt.getTotalProducts()-pc.getQty());
            cnt.setTotalAmount(cnt.getTotalAmount()-tot);
            cnt.setDate(new Date());
            
            s.update(cnt);
            
            s.delete(pc);
            
            t.commit();
            
            response.sendRedirect("MyWishlist.jsp");

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
