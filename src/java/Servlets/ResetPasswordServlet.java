/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.PoolManager;
import HibernateClasses.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.crypto.IllegalBlockSizeException;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPasswordServlet"})
public class ResetPasswordServlet extends HttpServlet {

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
        
        String msg = "";
        try {


            String email = new SecurityEncDec().decrypt(request.getParameter("email"));
            String time = request.getParameter("time");

            long t1 = Long.parseLong(time);

            long difference = System.currentTimeMillis() - t1;

            if (difference >= 0 && difference <= 3600000) {

                String password = request.getParameter("password");
                String confirmpassword = request.getParameter("confirmpassword");

                boolean b = true;

                if (password.equals("")) {
                    b = false;
                    msg = "password_null";
                } else if (confirmpassword.equals("")) {
                    b = false;
                    msg = "confirmpassword_null";
                } else if (!password.equals(confirmpassword)) {
                    b = false;
                    msg = "confirmpassword_mismatch";
                } else if (!EmailValidator.getInstance().isValid(email)) {
                    b = false;
                    msg = "email_invalid";
                }

                if (b) {

                    Session s = PoolManager.getSessionFactory().openSession();
                    Transaction t = s.beginTransaction();

                    Criteria c = s.createCriteria(UserLogin.class);
                    c.add(Restrictions.eq("email", email));
                    UserLogin ul = (UserLogin) c.uniqueResult();

                    if (ul != null) {
                        ul.setPassword(Security.encrypt(password));
                        s.update(ul);
                        t.commit();
                        
                        to = email;
                        text = "Dear "+ul.getUser().getFirstName()+" "+ul.getUser().getLastName()+",\n\nThis is a courtesy notice to let you know that your TPA password has been changed. No response is needed.\n\nIf you have any other questions regarding your account, please contact our support team at support@tpa.com";
                        
                        sendTextMail();
                        
                        msg = "Password changed successfully...! Please sign in with your new password.";

                    } else {
                        msg = "The link you have browsed seems to be wrong. Please use the correct email address and try again.";
                    }
                }

            } else {
                msg = "The link you have browsed has expired. Please request for a new password.";
            }

            out.write(msg);


        
        } catch (Exception e) {
            throw new ServletException(e);
        }

    }
    
    
    
        private static class MailAuthenticator extends javax.mail.Authenticator {

        @Override
        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(sender_email, password);
        }
    }
    static String sender_email = "info.thephonearcadek@gmail.com";
    static String password = "infotpa1234567890";
    static String host = "smtp.gmail.com";  //yahoo - smtp.mail.yahoo.com, live - smtp.live.com
    static String port = "465";             //yahoo - 465, live - 587
    static String to = "";
    static String subject = "Change Password Confirmation";
    static String text = "";


    public static void sendTextMail() {
        Properties props = new Properties();
        props.put("mail.smtp.user", sender_email);
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", port);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");

        try {
            Authenticator auth = new MailAuthenticator();
            javax.mail.Session session = javax.mail.Session.getInstance(props, auth);

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender_email));
            message.setSubject(subject);
            message.setText(text);

            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            Transport.send(message);
        } catch (Exception mex) {
            mex.printStackTrace();
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
