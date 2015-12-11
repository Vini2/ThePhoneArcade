/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.Container;
import HibernateClasses.ContainerType;
import HibernateClasses.PoolManager;
import HibernateClasses.SystemStatus;
import HibernateClasses.User;
import HibernateClasses.UserLogin;
import HibernateClasses.UserType;
import captchas.CaptchasDotNet;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
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
@WebServlet(name = "SignUpServlet", urlPatterns = {"/SignUpServlet"})
public class SignUpServlet extends HttpServlet {

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
            String captcha = request.getParameter("captcha");

            System.out.println(captcha);
            
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
            } else if (captcha.equals("")) {
                b = false;
                msg = "captcha_null";
            }

            
            if (!captcha.equals("")) {

// Construct the captchas object
                CaptchasDotNet captchas = new captchas.CaptchasDotNet(
                        request.getSession(true), // Ensure session
                        "vinimal", // client
                        "OL6JPLRXtN8p7Banl9AQGvtQzgexQMASc3oBYizB" // secret
                        );

// Check captcha
                switch (captchas.check(captcha)) {
                    case 's':
                        b = false;
                        msg = "Session seems to be timed out or broken. Please try again";
                        break;
                    case 'm':
                        b = false;
                        msg = "The current CAPTCHA has already been used. ";
                        break;
                    case 'w':
                        b = false;
                        msg = "You entered the wrong captcha. ";
                        break;
                    default:
                        break;
                }
            }

            if (b) {

                Session s = PoolManager.getSessionFactory().openSession();

                Transaction t = s.beginTransaction();

                Criteria c = s.createCriteria(SystemStatus.class);
                c.add(Restrictions.eq("statusName", "Pending"));
                SystemStatus ss = (SystemStatus) c.uniqueResult();

                Criteria c1 = s.createCriteria(UserType.class);
                c1.add(Restrictions.eq("typeName", "Buyer"));
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

                    Criteria c3 = s.createCriteria(ContainerType.class);
                    c3.add(Restrictions.eq("typeName", "Wishlist"));
                    ContainerType ct = (ContainerType) c3.uniqueResult();

                    Container co = new Container();
                    co.setTotalAmount(0.0);
                    co.setTotalProducts(0.0);
                    co.setDate(new Date());
                    co.setUser(u);
                    co.setContainerType(ct);

                    s.save(co);

                    Criteria c4 = s.createCriteria(ContainerType.class);
                    c4.add(Restrictions.eq("typeName", "Cart"));
                    ContainerType ct1 = (ContainerType) c4.uniqueResult();

                    Container co1 = new Container();
                    co1.setTotalAmount(0.0);
                    co1.setTotalProducts(0.0);
                    co1.setDate(new Date());
                    co1.setUser(u);
                    co1.setContainerType(ct1);

                    s.save(co1);

                    t.commit();

                    //Send Verification Email
                    String email_replaced = "";
                    to = email;
                    text = "Hi " + firstname + " " + lastname + "\n\nThanks for creating your new TPA account. To finalize the registration process, please visit the following link " + "\nhttp://localhost:8080/ThePhoneArcade/AccountVerificationServlet?ea=" + URLEncoder.encode(new SecurityEncDec().encrypt(email), "UTF-8") + "&t=" + System.currentTimeMillis() + "\n\nThis link will expire within an hour after sending this email.\n\nThis email was sent to " + email + "\nIf you did not create a TPA account, just ignore this message.";

                    sendTextMail();


                msg = "success";


                } else {

                    msg = "The email address entered already exists.";
                }
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
    static String subject = "Welcome to The Phone Arcade";
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
