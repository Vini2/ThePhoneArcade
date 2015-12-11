/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.PoolManager;
import HibernateClasses.SystemStatus;
import HibernateClasses.User;
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
@WebServlet(name = "AdminAddNewAdmin", urlPatterns = {"/AdminAddNewAdmin"})
public class AdminAddNewAdmin extends HttpServlet {

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

            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String password = request.getParameter("password");
            String confirmpassword = request.getParameter("confirmpassword");

            String msg = "";

            boolean b = true;

            if (firstname.equals("")) {
                b = false;
                msg = "firstname_null";
            } else if (lastname.equals("")) {
                b = false;
                msg = "lastname_null";
            } else if (gender.equals("")) {
                b = false;
                msg = "gender_null";
            } else if (address.equals("")) {
                b = false;
                msg = "address_null";
            } else if (mobile.equals("")) {
                b = false;
                msg = "mobile_null";
            } else if (!NumberCheck.isNumeric(mobile)) {
                b = false;
                msg = "mobile_invalid";
            } else if (email.equals("")) {
                b = false;
                msg = "email_null";
            } else if (!EmailValidator.getInstance().isValid(email)) {
                b = false;
                msg = "email_invalid";
            } else if (password.equals("")) {
                b = false;
                msg = "password_null";
            } else if (confirmpassword.equals("")) {
                b = false;
                msg = "confirmpassword_null";
            } else if (!password.equals(confirmpassword)) {
                b = false;
                msg = "confirmpassword_mismatch";
            }

            

            if (b) {
            

            Session s = PoolManager.getSessionFactory().openSession();

            Transaction t = s.beginTransaction();

            Criteria c = s.createCriteria(SystemStatus.class);
            c.add(Restrictions.eq("statusName", "Active"));
            SystemStatus ss = (SystemStatus) c.uniqueResult();

            Criteria c1 = s.createCriteria(UserType.class);
            c1.add(Restrictions.eq("typeName", "Admin"));
            UserType ut = (UserType) c1.uniqueResult();

            Criteria c2 = s.createCriteria(UserLogin.class);
            c2.add(Restrictions.eq("email", email));
            UserLogin ul = (UserLogin) c2.uniqueResult();

            if (ul == null) {
                
                User u = new User();
                u.setFirstName(firstname);
                u.setLastName(lastname);
                u.setGender(gender);
                u.setAddress(address);
                u.setMobile(mobile);
                u.setRegisterDate(new Date());
                u.setSystemStatus(ss);
                u.setUserType(ut);

                s.save(u);

                UserLogin ul1 = new UserLogin();
                ul1.setEmail(email);
                ul1.setPassword(Security.encrypt(password));
                ul1.setUser(u);
                ul1.setSystemStatus(ss);

                s.save(ul1);
                
                t.commit();

                msg = "Registration Successful...!";
                
            } else {
                
                msg = "The email address entered already exists.";
            }
            
            }

            out.write(msg);


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
