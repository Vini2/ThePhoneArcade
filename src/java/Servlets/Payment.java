/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.Container;
import HibernateClasses.Invoice;
import HibernateClasses.PoolManager;
import HibernateClasses.ProductInContainer;
import HibernateClasses.SystemStatus;
import HibernateClasses.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
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
@WebServlet(name = "Payment", urlPatterns = {"/Payment"})
public class Payment extends HttpServlet {

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
            
            String msg="";

            String containerid = request.getParameter("containerid");
            String billaddress = request.getParameter("billaddress");

            String card_number = request.getParameter("cardnumber");
            String expdate = request.getParameter("expdate");
            String cid = request.getParameter("csc");
            
            int invoice_id=0;

            boolean b = true;

            if (billaddress.equals("")) {
                b = false;
            } else if (card_number.equals("")) {
                b = false;
            } else if (expdate.equals("")) {
                b = false;
            } else if (cid.equals("")) {
                b = false;
            }

            if (b) {

                Session s = PoolManager.getSessionFactory().openSession();
                Transaction t = s.beginTransaction();

                Criteria c = s.createCriteria(SystemStatus.class);
                c.add(Restrictions.eq("statusName", "InCart"));
                SystemStatus ss = (SystemStatus) c.uniqueResult();
                
                Criteria c1 = s.createCriteria(SystemStatus.class);
                c1.add(Restrictions.eq("statusName", "Purchased"));
                SystemStatus ss1 = (SystemStatus) c1.uniqueResult();

                Container con = (Container) s.load(Container.class, Integer.parseInt(containerid));

                Criteria c2 = s.createCriteria(ProductInContainer.class);
                c2.add(Restrictions.eq("systemStatus", ss));
                c2.add(Restrictions.eq("container", con));
                List<ProductInContainer> pcl = c2.list();
                
                for (ProductInContainer pc : pcl) {
                    System.out.println(pc.getSystemStatus().getStatusName());
                    pc.setSystemStatus(ss1);
                    System.out.println(ss1.getStatusName());
                    s.update(pc);
                    System.out.println("OK");
                }

//                UserLogin ul = (UserLogin) request.getSession().getAttribute("user");
//                ul.getUser().setAddress(billaddress);
//                s.update(ul);

                Invoice in = new Invoice();
                in.setInvoiceTotal(con.getTotalAmount());
                in.setDate(new Date());
                in.setContainer(con);
//                in.setName(request.getParameter("firstname")+" "+request.getParameter("lastname"));
//                in.setBillingAddress(billaddress);
                s.save(in);
                invoice_id=in.getIdinvoice();
                
                con.setTotalAmount(0.0);
                con.setTotalProducts(0.0);
                s.update(con);

                t.commit();
                
                msg="Success";

            } else{
                msg="Error";
            }

            System.out.println(containerid);
            System.out.println(billaddress);
            System.out.println(card_number);
            System.out.println(expdate);
            System.out.println(cid);
            
            response.sendRedirect("CheckoutResult.jsp?msg="+msg+"&inid="+invoice_id);

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
