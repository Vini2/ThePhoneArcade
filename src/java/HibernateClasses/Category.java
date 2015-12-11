package HibernateClasses;
// Generated Nov 4, 2015 1:58:45 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Category generated by hbm2java
 */
public class Category  implements java.io.Serializable {


     private Integer idcategory;
     private String categoryName;
     private Set<Product> products = new HashSet<Product>(0);

    public Category() {
    }

    public Category(String categoryName, Set<Product> products) {
       this.categoryName = categoryName;
       this.products = products;
    }
   
    public Integer getIdcategory() {
        return this.idcategory;
    }
    
    public void setIdcategory(Integer idcategory) {
        this.idcategory = idcategory;
    }
    public String getCategoryName() {
        return this.categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    public Set<Product> getProducts() {
        return this.products;
    }
    
    public void setProducts(Set<Product> products) {
        this.products = products;
    }




}


