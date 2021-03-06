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
import HibernateClasses.SystemStatus;
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
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {

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

            String pid = request.getParameter("pid");
            String qty = request.getParameter("qty");

            UserLogin ul = (UserLogin) request.getSession().getAttribute("user");

            User r = ul.getUser();

            Session s = PoolManager.getSessionFactory().openSession();
            Transaction t = s.beginTransaction();

            Criteria c = s.createCriteria(Product.class);
            c.add(Restrictions.eq("idproduct", Integer.parseInt(pid)));
            Product p = (Product) c.uniqueResult();

            Criteria c1 = s.createCriteria(ContainerType.class);
            c1.add(Restrictions.eq("typeName", "Cart"));
            ContainerType ct = (ContainerType) c1.uniqueResult();

            Criteria c2 = s.createCriteria(Container.class);
            c2.add(Restrictions.and(Restrictions.eq("user", r), Restrictions.eq("containerType", ct)));
            Container cnt = (Container) c2.uniqueResult();

            Criteria c3 = s.createCriteria(ProductInContainer.class);
            c3.add(Restrictions.eq("container", cnt));
            c3.add(Restrictions.eq("product", p));
            ProductInContainer pce = (ProductInContainer) c3.uniqueResult();
            
            Criteria c4 = s.createCriteria(SystemStatus.class);
            c4.add(Restrictions.eq("statusName", "InCart"));
            SystemStatus st = (SystemStatus) c4.uniqueResult();

            if (pce != null) {
                if (pce.getProduct().getCategory().getCategoryName().equals("Accessory")) {
                    response.sendRedirect("ViewDetailsAccessory.jsp?pid=" + p.getIdproduct() + "&msg=The product is already in your cart");
                } else {
                    response.sendRedirect("ViewDetails.jsp?pid=" + p.getIdproduct() + "&msg=The product is already in your cart");
                }

            } else {


                if (p.getAvailableQty() > 10) {

                    if (NumberCheck.isNumeric(qty)) {

                        if (Double.parseDouble(qty) <= (p.getAvailableQty() - 10)) {

                            double tot = Double.parseDouble(qty) * p.getCustomerPrice();

                            ProductInContainer pc = new ProductInContainer();
                            pc.setQty(Double.parseDouble(qty));
                            pc.setAmount(tot);
                            pc.setAddedDate(new Date());
                            pc.setContainer(cnt);
                            pc.setProduct(p);
                            pc.setSystemStatus(st);

                            s.save(pc);

                            cnt.setTotalProducts(cnt.getTotalProducts() + Double.parseDouble(qty));
                            cnt.setTotalAmount(cnt.getTotalAmount() + tot);
                            cnt.setDate(new Date());

                            s.update(cnt);

                            p.setAvailableQty(p.getAvailableQty() - Double.parseDouble(qty));

                            s.update(p);

                            t.commit();

                            response.sendRedirect("MyCart.jsp");

                        } else {
                            if (p.getCategory().getCategoryName().equals("Accessory")) {
                                response.sendRedirect("ViewDetailsAccessory.jsp?pid=" + p.getIdproduct() + "&msg=Please enter a valid quantity");
                            } else {
                                response.sendRedirect("ViewDetails.jsp?pid=" + p.getIdproduct() + "&msg=Please enter a valid quantity");
                            }
                        }


                    } else {

                        if (p.getCategory().getCategoryName().equals("Accessory")) {
                            response.sendRedirect("ViewDetailsAccessory.jsp?pid=" + p.getIdproduct() + "&msg=Please enter a valid quantity");
                        } else {
                            response.sendRedirect("ViewDetails.jsp?pid=" + p.getIdproduct() + "&msg=Please enter a valid quantity");
                        }

                    }



                } else {
                    if (p.getCategory().getCategoryName().equals("Accessory")) {
                        response.sendRedirect("ViewDetailsAccessory.jsp?pid=" + p.getIdproduct() + "&msg=This product is out of stock");
                    } else {
                        response.sendRedirect("ViewDetails.jsp?pid=" + p.getIdproduct() + "&msg=This product is out of stock");
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
