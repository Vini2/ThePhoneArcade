/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import HibernateClasses.Container;
import HibernateClasses.Invoice;
import HibernateClasses.PoolManager;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Asus
 */
public class NewClass {

    public static void main(String[] args) {

        try {

            String trDate="20130106";
            Date dd = new SimpleDateFormat("yyyyMMdd", Locale.ENGLISH).parse(trDate);
            System.out.println(dd);

        } catch (Exception e) {
            System.out.println(e);
        }


    }
}
