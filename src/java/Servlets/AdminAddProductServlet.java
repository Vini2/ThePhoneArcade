/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.Category;
import HibernateClasses.Description;
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
@WebServlet(name = "AdminAddProductServlet", urlPatterns = {"/AdminAddProductServlet"})
public class AdminAddProductServlet extends HttpServlet {

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

            String general_2G_network = "";
            String general_3G_network = "";
            String general_4G_network = "";
            String general_sim = "";
            String general_announced = "";
            String general_status = "";
            String body_dimensions = "";
            String body_weight = "";
            String display_type = "";
            String display_size = "";
            String display_multitouch = "";
            String display_protection = "";
            String sound_alert_type = "";
            String sound_loudspeaker = "";
            String sound_35mm_jack = "";
            String memory_card_slot = "";
            String memory_internal = "";
            String data_gprs = "";
            String data_edge = "";
            String data_speed = "";
            String data_wlan = "";
            String data_bluetooth = "";
            String data_nfc = "";
            String data_infrared_port = "";
            String data_usb = "";
            String camera_primary = "";
            String camera_features = "";
            String camera_video = "";
            String camera_secondary = "";
            String features_os = "";
            String features_chipset = "";
            String features_cpu = "";
            String features_gpu = "";
            String features_sensors = "";
            String features_messaging = "";
            String features_browser = "";
            String features_radio = "";
            String features_gps = "";
            String features_java = "";
            String features_colours = "";
            String battery_type = "";
            String battery_standby = "";
            String battery_talktime = "";
            String battery_music_play = "";
            String misc_sar_us = "";
            String misc_sar_eu = "";
            String tests_display = "";
            String tests_loudspeaker = "";
            String tests_audio_quality = "";
            String tests_camera = "";
            String tests_battery_life = "";


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

//                        Criteria cr = s.createCriteria(Product.class);
//                        cr.add(Restrictions.eq("name", name));
//                        Product pro = (Product) cr.uniqueResult();
//
//                        if (pro == null) {
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
                            
//                        } else{
//                            response.sendRedirect("Admin-AddProduct.jsp?msg=Product name entered already exists.");
//                        }


                    } else if (fileitem.getFieldName().equals("general_2G_network")) {
                        general_2G_network = fileitem.getString();
                        System.out.println("........." + general_2G_network);
                        System.out.println("general_2G_network");
                    } else if (fileitem.getFieldName().equals("general_3G_network")) {
                        general_3G_network = fileitem.getString();
                        System.out.println(general_3G_network);
                    } else if (fileitem.getFieldName().equals("general_4G_network")) {
                        general_4G_network = fileitem.getString();
                        System.out.println(general_4G_network);
                    } else if (fileitem.getFieldName().equals("general_sim")) {
                        general_sim = fileitem.getString();
                        System.out.println(general_sim);
                    } else if (fileitem.getFieldName().equals("general_announced")) {
                        general_announced = fileitem.getString();
                        System.out.println(general_announced);
                    } else if (fileitem.getFieldName().equals("general_status")) {
                        general_status = fileitem.getString();
                        System.out.println(general_status);
                    } else if (fileitem.getFieldName().equals("body_dimensions")) {
                        body_dimensions = fileitem.getString();
                        System.out.println(body_dimensions);
                    } else if (fileitem.getFieldName().equals("body_weight")) {
                        body_weight = fileitem.getString();
                        System.out.println(body_weight);
                    } else if (fileitem.getFieldName().equals("display_type")) {
                        display_type = fileitem.getString();
                        System.out.println(display_type);
                    } else if (fileitem.getFieldName().equals("display_size")) {
                        display_size = fileitem.getString();
                        System.out.println(display_size);
                    } else if (fileitem.getFieldName().equals("display_multitouch")) {
                        display_multitouch = fileitem.getString();
                        System.out.println(display_multitouch);
                    } else if (fileitem.getFieldName().equals("display_protection")) {
                        display_protection = fileitem.getString();
                        System.out.println(sprice);
                    } else if (fileitem.getFieldName().equals("display_protection")) {
                        sprice = fileitem.getString();
                        System.out.println(sprice);
                    } else if (fileitem.getFieldName().equals("sound_alert_type")) {
                        sound_alert_type = fileitem.getString();
                        System.out.println(sound_alert_type);
                    } else if (fileitem.getFieldName().equals("sound_loudspeaker")) {
                        sound_loudspeaker = fileitem.getString();
                        System.out.println(sound_loudspeaker);
                    } else if (fileitem.getFieldName().equals("sound_35mm_jack")) {
                        sound_35mm_jack = fileitem.getString();
                        System.out.println(sound_35mm_jack);
                    } else if (fileitem.getFieldName().equals("memory_card_slot")) {
                        memory_card_slot = fileitem.getString();
                        System.out.println(memory_card_slot);
                    } else if (fileitem.getFieldName().equals("memory_internal")) {
                        memory_internal = fileitem.getString();
                        System.out.println(memory_internal);
                    } else if (fileitem.getFieldName().equals("data_gprs")) {
                        data_gprs = fileitem.getString();
                        System.out.println(data_gprs);
                    } else if (fileitem.getFieldName().equals("data_edge")) {
                        data_edge = fileitem.getString();
                        System.out.println(data_edge);
                    } else if (fileitem.getFieldName().equals("data_speed")) {
                        data_speed = fileitem.getString();
                        System.out.println(data_speed);
                    } else if (fileitem.getFieldName().equals("data_wlan")) {
                        data_wlan = fileitem.getString();
                        System.out.println(data_wlan);
                    } else if (fileitem.getFieldName().equals("data_bluetooth")) {
                        data_bluetooth = fileitem.getString();
                        System.out.println(data_bluetooth);
                    } else if (fileitem.getFieldName().equals("data_nfc")) {
                        data_nfc = fileitem.getString();
                        System.out.println(data_nfc);
                    } else if (fileitem.getFieldName().equals("data_infrared_port")) {
                        data_infrared_port = fileitem.getString();
                        System.out.println(data_infrared_port);
                    } else if (fileitem.getFieldName().equals("data_usb")) {
                        data_usb = fileitem.getString();
                        System.out.println(data_usb);
                    } else if (fileitem.getFieldName().equals("camera_primary")) {
                        camera_primary = fileitem.getString();
                        System.out.println(camera_primary);
                    } else if (fileitem.getFieldName().equals("camera_features")) {
                        camera_features = fileitem.getString();
                        System.out.println(camera_features);
                    } else if (fileitem.getFieldName().equals("camera_video")) {
                        camera_video = fileitem.getString();
                        System.out.println(camera_video);
                    } else if (fileitem.getFieldName().equals("camera_secondary")) {
                        camera_secondary = fileitem.getString();
                        System.out.println(camera_secondary);
                    } else if (fileitem.getFieldName().equals("features_os")) {
                        features_os = fileitem.getString();
                        System.out.println(features_os);
                    } else if (fileitem.getFieldName().equals("features_chipset")) {
                        features_chipset = fileitem.getString();
                        System.out.println(features_chipset);
                    } else if (fileitem.getFieldName().equals("features_cpu")) {
                        features_cpu = fileitem.getString();
                        System.out.println(features_cpu);
                    } else if (fileitem.getFieldName().equals("features_gpu")) {
                        features_gpu = fileitem.getString();
                        System.out.println(features_gpu);
                    } else if (fileitem.getFieldName().equals("features_sensors")) {
                        features_sensors = fileitem.getString();
                        System.out.println(features_sensors);
                    } else if (fileitem.getFieldName().equals("features_messaging")) {
                        features_messaging = fileitem.getString();
                        System.out.println(features_messaging);
                    } else if (fileitem.getFieldName().equals("features_browser")) {
                        features_browser = fileitem.getString();
                        System.out.println(features_browser);
                    } else if (fileitem.getFieldName().equals("features_radio")) {
                        features_radio = fileitem.getString();
                        System.out.println(features_radio);
                    } else if (fileitem.getFieldName().equals("features_gps")) {
                        features_gps = fileitem.getString();
                        System.out.println(features_gps);
                    } else if (fileitem.getFieldName().equals("features_java")) {
                        features_java = fileitem.getString();
                        System.out.println(features_java);
                    } else if (fileitem.getFieldName().equals("features_colours")) {
                        features_colours = fileitem.getString();
                        System.out.println(features_colours);
                    } else if (fileitem.getFieldName().equals("battery_type")) {
                        battery_type = fileitem.getString();
                        System.out.println(battery_type);
                    } else if (fileitem.getFieldName().equals("battery_standby")) {
                        battery_standby = fileitem.getString();
                        System.out.println(battery_standby);
                    } else if (fileitem.getFieldName().equals("battery_talktime")) {
                        battery_talktime = fileitem.getString();
                        System.out.println(battery_talktime);
                    } else if (fileitem.getFieldName().equals("battery_music_play")) {
                        battery_music_play = fileitem.getString();
                        System.out.println(battery_music_play);
                    } else if (fileitem.getFieldName().equals("misc_sar_us")) {
                        misc_sar_us = fileitem.getString();
                        System.out.println(misc_sar_us);
                    } else if (fileitem.getFieldName().equals("misc_sar_eu")) {
                        misc_sar_eu = fileitem.getString();
                        System.out.println(misc_sar_eu);
                    } else if (fileitem.getFieldName().equals("tests_display")) {
                        tests_display = fileitem.getString();
                        System.out.println(tests_display);
                    } else if (fileitem.getFieldName().equals("tests_loudspeaker")) {
                        tests_loudspeaker = fileitem.getString();
                        System.out.println(tests_loudspeaker);
                    } else if (fileitem.getFieldName().equals("tests_audio_quality")) {
                        tests_audio_quality = fileitem.getString();
                        System.out.println(tests_audio_quality);
                    } else if (fileitem.getFieldName().equals("tests_camera")) {
                        tests_camera = fileitem.getString();
                        System.out.println(tests_camera);
                    } else if (fileitem.getFieldName().equals("tests_audio_quality")) {
                        tests_audio_quality = fileitem.getString();
                        System.out.println(tests_audio_quality);
                    } else if (fileitem.getFieldName().equals("tests_battery_life")) {
                        tests_battery_life = fileitem.getString();
                        System.out.println(tests_battery_life);

                    }

                } else {

//                    Criteria cr = s.createCriteria(Product.class);
//                    cr.add(Restrictions.eq("name", name));
//                    Product pro = (Product) cr.uniqueResult();
//
//                    if (pro == null) {

                        i++;

                        path = "ProductImages/" + make + " " + name + "_" + i + ".jpg";

                        File savedFile = new File(request.getServletContext().getRealPath("/") + path);
                        fileitem.write(savedFile);

                        Images im = new Images();
                        im.setImageName(make + " " + name + "_" + i);
                        im.setImagePath("ProductImages/" + make + " " + name + "_" + i + ".jpg");

                        if (i == 1) {
                            Product p = (Product) request.getSession().getAttribute("product");
                            p.setImagePath(path);
                            s.update(p);
                        }

                        Product p1 = (Product) request.getSession().getAttribute("product");
                        im.setProduct(p1);

                        s.save(im);

//                    }

                }
            }

//            Criteria cr = s.createCriteria(Product.class);
//            cr.add(Restrictions.eq("name", name));
//            Product pro = (Product) cr.uniqueResult();
//
//            if (pro == null) {

                Product p1 = (Product) request.getSession().getAttribute("product");

                Description d = new Description();
                d.setGeneral2gNetwork(general_2G_network);
                d.setGeneral3gNetwork(general_3G_network);
                d.setGeneral4gNetwork(general_4G_network);
                d.setGeneralSim(general_sim);
                d.setGeneralAnnounced(general_announced);
                d.setGeneralStatus(general_status);
                d.setBodyDimensions(body_dimensions);
                d.setBodyWeight(body_weight);
                d.setDisplayType(display_type);
                d.setDisplaySize(display_size);
                d.setDisplayMultitouch(display_multitouch);
                d.setDisplayProtection(display_protection);
                d.setSoundAlertType(sound_alert_type);
                d.setSoundLoudspeaker(sound_loudspeaker);
                d.setSound35mmJack(sound_35mm_jack);
                d.setMemoryCardSlot(memory_card_slot);
                d.setMemoryInternal(memory_internal);
                d.setDataGprs(data_gprs);
                d.setDataEdge(data_edge);
                d.setDataSpeed(data_speed);
                d.setDataWlan(data_wlan);
                d.setDataBluetooth(data_bluetooth);
                d.setDataNfc(data_nfc);
                d.setDataInfraredPort(data_infrared_port);
                d.setDataUsb(data_usb);
                d.setCameraPrimary(camera_primary);
                d.setCameraFeatures(camera_features);
                d.setCameraVideo(camera_video);
                d.setCameraSecondary(camera_secondary);
                d.setFeaturesOs(features_os);
                d.setFeaturesChipset(features_chipset);
                d.setFeaturesCpu(features_cpu);
                d.setFeaturesGpu(features_gpu);
                d.setFeaturesSensors(features_sensors);
                d.setFeaturesMessaging(features_messaging);
                d.setFeaturesBrowser(features_browser);
                d.setFeaturesRadio(features_radio);
                d.setFeaturesGps(features_gps);
                d.setFeaturesJava(features_java);
                d.setFeaturesColours(features_colours);
                d.setBatteryType(battery_type);
                d.setBatteryStandby(battery_standby);
                d.setBatteryTalktime(battery_talktime);
                d.setBatteryMusicPlay(battery_music_play);
                d.setMiscSarUs(misc_sar_us);
                d.setMiscSarEu(misc_sar_eu);
                d.setTestsDisplay(tests_display);
                d.setTestsAudioQuality(tests_audio_quality);
                d.setTestsBatteryLife(tests_battery_life);
                d.setTestsCamera(tests_camera);
                d.setTestsLoudspeaker(tests_loudspeaker);
                d.setProduct(p1);

                s.save(d);

                t.commit();

                response.sendRedirect("Admin-AddProduct.jsp?msg=Product registered successfully...!");

            //}
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
