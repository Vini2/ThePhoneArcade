/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.Category;
import HibernateClasses.Images;
import HibernateClasses.Make;
import HibernateClasses.PoolManager;
import HibernateClasses.Product;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Asus
 */
@WebServlet(name = "AdminAddProductOtherServlet", urlPatterns = {"/AdminAddProductOtherServlet"})
public class AdminAddProductOtherServlet extends HttpServlet {

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

            String make = "";
            String category = "";
            String name = "";
            String desc = "";
            String sprice = "";
            String cprice = "";
            String path = "";

            int i = 0;

            Session s = PoolManager.getSessionFactory().openSession();

            Transaction t = s.beginTransaction();

            FileItemFactory factory = new DiskFileItemFactory();

            ServletFileUpload upload = new ServletFileUpload(factory);

            List<Object> items = upload.parseRequest(request);

            for (Object element : items) {
                FileItem fileitem = (FileItem) element;

                if (fileitem.isFormField()) {

                    if (fileitem.getFieldName().equals("make")) {
                        make = fileitem.getString();
                        System.out.println(make);
                    } else if (fileitem.getFieldName().equals("category")) {
                        category = fileitem.getString();
                        System.out.println(category);
                    } else if (fileitem.getFieldName().equals("name")) {
                        name = fileitem.getString();
                        System.out.println(name);
                    } else if (fileitem.getFieldName().equals("desc")) {
                        desc = fileitem.getString();
                        System.out.println(desc);
                    } else if (fileitem.getFieldName().equals("sprice")) {
                        sprice = fileitem.getString();
                        System.out.println(sprice);
                    } else if (fileitem.getFieldName().equals("cprice")) {
                        cprice = fileitem.getString();
                        System.out.println(cprice);
                        
//                        if (make.equals("")) {
//                            response.sendRedirect("Admin-AddProductOther.jsp?msg=Error1");
//                        } else if (category.equals("")) {
//                            response.sendRedirect("Admin-AddProductOther.jsp?msg=Error1");
//                        } else if (name.equals("")) {
//                            response.sendRedirect("Admin-AddProductOther.jsp?msg=Error1");
//                        } else if (desc.equals("")) {
//                            response.sendRedirect("Admin-AddProductOther.jsp?msg=Error1");
//                        } else if (sprice.equals("")) {
//                            response.sendRedirect("Admin-AddProductOther.jsp?msg=Error1");
//                        } else if (!NumberCheck.isNumeric(sprice)) {
//                            response.sendRedirect("Admin-AddProductOther.jsp?msg=Error2");
//                        } else if (cprice.equals("")) {
//                            response.sendRedirect("Admin-AddProductOther.jsp?msg=Error1");
//                        } else if (!NumberCheck.isNumeric(cprice)) {
//                            response.sendRedirect("Admin-AddProductOther.jsp?msg=Error2");
//                        }

                        Product p = new Product();
                        p.setName(name);
                        p.setGeneralDescription(desc);
                        p.setAvailableQty(0.0);
                        p.setSpecialPrice(Double.parseDouble(sprice));
                        p.setCustomerPrice(Double.parseDouble(cprice));
                        p.setImagePath("");
                        p.setStatus("Available");

                        Criteria c1 = s.createCriteria(Make.class);
                        c1.add(Restrictions.eq("makeName", make));
                        Make m = (Make) c1.uniqueResult();
                        p.setMake(m);

                        Criteria c2 = s.createCriteria(Category.class);
                        c2.add(Restrictions.eq("idcategory", Integer.parseInt(category)));
                        Category c = (Category) c2.uniqueResult();
                        p.setCategory(c);

                        s.save(p);
                        
                        request.getSession().removeAttribute("product");
                        request.getSession().setAttribute("product", p);


                    }


                } else {

                    i++;

                    if (make.equals("Other")) {
                        path = "ProductImages/" + name + "_" + i + ".jpg";
                    } else {
                        path = "ProductImages/" + make + " " + name + "_" + i + ".jpg";
                    }

                    File savedFile = new File(request.getServletContext().getRealPath("/") + path);
                    fileitem.write(savedFile);

                    Images im = new Images();
                    im.setImageName(make + " " + name + "_" + i);
                    im.setImagePath(path);

                    if (i == 1) {
                        Product p = (Product) request.getSession().getAttribute("product");
                        p.setImagePath(path);
                        s.update(p);
                    }

                    Product p1 = (Product) request.getSession().getAttribute("product");
                    im.setProduct(p1);

                    s.save(im);

                }
            }


            t.commit();

            response.sendRedirect("Admin-AddProductOther.jsp?msg=Success");

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
