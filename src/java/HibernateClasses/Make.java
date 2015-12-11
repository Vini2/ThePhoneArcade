package HibernateClasses;
// Generated Nov 4, 2015 1:58:45 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Make generated by hbm2java
 */
public class Make  implements java.io.Serializable {


     private Integer idmake;
     private String makeName;
     private Set<Product> products = new HashSet<Product>(0);

    public Make() {
    }

    public Make(String makeName, Set<Product> products) {
       this.makeName = makeName;
       this.products = products;
    }
   
    public Integer getIdmake() {
        return this.idmake;
    }
    
    public void setIdmake(Integer idmake) {
        this.idmake = idmake;
    }
    public String getMakeName() {
        return this.makeName;
    }
    
    public void setMakeName(String makeName) {
        this.makeName = makeName;
    }
    public Set<Product> getProducts() {
        return this.products;
    }
    
    public void setProducts(Set<Product> products) {
        this.products = products;
    }




}


