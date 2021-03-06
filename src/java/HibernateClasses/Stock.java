package HibernateClasses;
// Generated Nov 4, 2015 1:58:45 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Stock generated by hbm2java
 */
public class Stock  implements java.io.Serializable {


     private Integer idstock;
     private Product product;
     private Double qty;
     private Date date;

    public Stock() {
    }

	
    public Stock(Product product) {
        this.product = product;
    }
    public Stock(Product product, Double qty, Date date) {
       this.product = product;
       this.qty = qty;
       this.date = date;
    }
   
    public Integer getIdstock() {
        return this.idstock;
    }
    
    public void setIdstock(Integer idstock) {
        this.idstock = idstock;
    }
    public Product getProduct() {
        return this.product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    public Double getQty() {
        return this.qty;
    }
    
    public void setQty(Double qty) {
        this.qty = qty;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }




}


