/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

/**
 *
 * @author Asus
 */
public class NumberCheck {

    public static boolean isNumeric(String str) {
        
        try {
            
            double d = Double.parseDouble(str);
            
        } catch (NumberFormatException e) {
            
            return false;
            
        }
        return true;
    }
}
