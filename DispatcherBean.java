package com.klef.ep.beans;

import java.io.IOException;
import javax.ejb.EJB;
import javax.ejb.Stateful;
import javax.ejb.Stateless;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.klef.ep.models.Dispatcher;
import com.klef.ep.services.DispatcherService;

@Stateful
@ManagedBean(name="dispatcherbean", eager=true)
public class DispatcherBean {
    @EJB(lookup="java:global/EPPROJECT/DispatcherServiceImpl!com.klef.ep.services.DispatcherService")
    DispatcherService dispatchservice;

    private String username;
    private String contact;
    private String email;
    private String address;
    private String city;
    private String pincode;
    private String password;
  
    // Getters and Setters
    public String getUsername() 
    {
    	return username; 
    }
    public void setUsername(String username) 
    {
    	this.username = username; 
    }
    public String getContact() 
    {
    	return contact; 
    }
    public void setContact(String contact) 
    { 
    	this.contact = contact; 
    }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getPincode() { return pincode; }
    public void setPincode(String pincode) { this.pincode = pincode; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
  

    public String add() {
        Dispatcher d = new Dispatcher();
        d.setUsername(username);
        d.setContact(contact);
        d.setEmail(email);
        d.setAddress(address);
        d.setCity(city);
        d.setPincode(pincode);
        d.setPassword(password);

        dispatchservice.adddispatcher(d);

        return "dispatcherlogin.jsf";
    }

    public void validateemail() throws IOException {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        ExternalContext externalContext = facesContext.getExternalContext();
        HttpServletRequest request = (HttpServletRequest) externalContext.getRequest();
        HttpServletResponse response = (HttpServletResponse) externalContext.getResponse();

        Dispatcher dispatch = dispatchservice.dispatcheremail(email);

        if (dispatch != null) {
            HttpSession session = request.getSession();
            session.setAttribute("dispatcher", dispatch);
            System.out.println("Dispatcher email validated: " + email);
            response.sendRedirect("forgotpassword.jsf");
        } else {
            System.out.println("Failed to validate dispatcher email: " + email);
            response.sendRedirect("verifyfail.jsf");
        }
    }



    public String update() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        ExternalContext externalContext = facesContext.getExternalContext();
        HttpServletRequest request = (HttpServletRequest) externalContext.getRequest();
        HttpSession session = request.getSession();
        Dispatcher dispatcher = (Dispatcher) session.getAttribute("dispatcher");

        if (dispatcher != null) {
            dispatcher.setPassword(password);
            dispatchservice.updatedispatcher(dispatcher);
            return "updatesuccess.jsf";
        } else {
            return "updatefail.jsf";
        }
    }

    public void validatedispatcherlogin() throws IOException {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        ExternalContext externalContext = facesContext.getExternalContext();
        HttpServletRequest request = (HttpServletRequest) externalContext.getRequest();
        HttpServletResponse response = (HttpServletResponse) externalContext.getResponse();

        Dispatcher dispatch = dispatchservice.dispatcherlogin(username, password);

        if (dispatch != null) {
            HttpSession session = request.getSession();
            session.setAttribute("dispatcher", dispatch);
            response.sendRedirect("dispatcherhome.jsp");
        } else {
            response.sendRedirect("dispatcherloginfail.jsf");
        }
    }
}
