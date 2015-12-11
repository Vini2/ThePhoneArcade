/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.Container;
import HibernateClasses.PoolManager;
import HibernateClasses.Product;
import HibernateClasses.ProductInContainer;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Asus
 */
@WebServlet(name = "UpdateQtyInCartServlet", urlPatterns = {"/UpdateQtyInCartServlet"})
public class UpdateQtyInCartServlet extends HttpServlet {

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

            String pcid = request.getParameter("pcid");
            String qty = request.getParameter("qty");

            Session s = PoolManager.getSessionFactory().openSession();
            Transaction t = s.beginTransaction();

            ProductInContainer pc = (ProductInContainer) s.load(ProductInContainer.class, Integer.parseInt(pcid));

            if (NumberCheck.isNumeric(qty)) {

                double new_qty_in_container = Double.parseDouble(qty);
                double old_qty_in_container = pc.getQty();
                double difference = new_qty_in_container - old_qty_in_container;
                double qty_available = pc.getProduct().getAvailableQty();
                double qty_in_container = pc.getContainer().getTotalProducts();
                double amount_in_container = pc.getContainer().getTotalAmount();

                System.out.println(new_qty_in_container);
                System.out.println(old_qty_in_container);
                System.out.println(difference);
                System.out.println(qty_available);
                System.out.println(qty_available - difference);
                System.out.println(new_qty_in_container * pc.getProduct().getCustomerPrice());
                System.out.println(difference * pc.getProduct().getCustomerPrice());
                System.out.println(qty_in_container);
                System.out.println(qty_in_container + difference);
                System.out.println(amount_in_container + (difference * pc.getProduct().getCustomerPrice()));

                pc.getContainer().getTotalAmount();



                if ((qty_available - 50) > new_qty_in_container) {
                    pc.setQty(new_qty_in_container);
                    pc.setAmount(new_qty_in_container * pc.getProduct().getCustomerPrice());

                    s.update(pc);

                    Product p = pc.getProduct();
                    p.setAvailableQty(qty_available - difference);

                    s.update(p);

                    Container c = pc.getContainer();
                    c.setTotalProducts(qty_in_container + difference);
                    c.setTotalAmount(amount_in_container + (difference * pc.getProduct().getCustomerPrice()));

                    s.update(c);

                    t.commit();

                    response.sendRedirect("MyCart.jsp");

                } else {
                    response.sendRedirect("MyCart.jsp?msg=Error1");
                }
            } else {
                response.sendRedirect("MyCart.jsp?msg=Error2");
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
