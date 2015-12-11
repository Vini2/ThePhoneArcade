package HibernateClasses;
// Generated Nov 4, 2015 1:58:45 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * User generated by hbm2java
 */
public class User  implements java.io.Serializable {


     private Integer iduser;
     private SystemStatus systemStatus;
     private UserType userType;
     private String firstName;
     private String lastName;
     private String gender;
     private String address;
     private String mobile;
     private Date registerDate;
     private Set<UserLogin> userLogins = new HashSet<UserLogin>(0);
     private Set<Container> containers = new HashSet<Container>(0);

    public User() {
    }

	
    public User(SystemStatus systemStatus, UserType userType) {
        this.systemStatus = systemStatus;
        this.userType = userType;
    }
    public User(SystemStatus systemStatus, UserType userType, String firstName, String lastName, String gender, String address, String mobile, Date registerDate, Set<UserLogin> userLogins, Set<Container> containers) {
       this.systemStatus = systemStatus;
       this.userType = userType;
       this.firstName = firstName;
       this.lastName = lastName;
       this.gender = gender;
       this.address = address;
       this.mobile = mobile;
       this.registerDate = registerDate;
       this.userLogins = userLogins;
       this.containers = containers;
    }
   
    public Integer getIduser() {
        return this.iduser;
    }
    
    public void setIduser(Integer iduser) {
        this.iduser = iduser;
    }
    public SystemStatus getSystemStatus() {
        return this.systemStatus;
    }
    
    public void setSystemStatus(SystemStatus systemStatus) {
        this.systemStatus = systemStatus;
    }
    public UserType getUserType() {
        return this.userType;
    }
    
    public void setUserType(UserType userType) {
        this.userType = userType;
    }
    public String getFirstName() {
        return this.firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return this.lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getGender() {
        return this.gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    public String getAddress() {
        return this.address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    public String getMobile() {
        return this.mobile;
    }
    
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }
    public Date getRegisterDate() {
        return this.registerDate;
    }
    
    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }
    public Set<UserLogin> getUserLogins() {
        return this.userLogins;
    }
    
    public void setUserLogins(Set<UserLogin> userLogins) {
        this.userLogins = userLogins;
    }
    public Set<Container> getContainers() {
        return this.containers;
    }
    
    public void setContainers(Set<Container> containers) {
        this.containers = containers;
    }




}

