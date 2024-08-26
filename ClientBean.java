package com.klef.ep.beans;

import java.io.IOException;

import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.klef.ep.models.Client;
import com.klef.ep.services.ClientService;

@ManagedBean(name="clientbean",eager=true)
public class ClientBean {
	
	@EJB(lookup = "java:global/EPPROJECT/ClientServiceImpl!com.klef.ep.services.ClientService")
	ClientService service;
	
	private String username;
	private String contact;
	private String email;
	private String address;
	private String city;
	private String pincode;
	private String password;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getPincode() {
		return pincode;
	}
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String add() {
		Client c = new Client();
		
		c.setUsername(username);
		c.setContact(contact);
		c.setEmail(email);
		c.setAddress(address);
		c.setCity(city);
		c.setPincode(pincode);
		c.setPassword(password);
		
		service.addClient(c);
		
		return "clientlogin.jsf";
	}
	
public void validatelogin() throws IOException {
		
		FacesContext facesContext = FacesContext.getCurrentInstance();
		ExternalContext externalContext = facesContext.getExternalContext();
		
		HttpServletRequest request = (HttpServletRequest) externalContext.getRequest();
		HttpServletResponse response = (HttpServletResponse) externalContext.getResponse();
		
		Client c = service.clientlogin(contact, password);
		
		if(c!=null) {

			HttpSession session = request.getSession();
			session.setAttribute("client", c); // client is a session variable of type Client
			
			session.setMaxInactiveInterval(50);
			
			response.sendRedirect("track.jsp");
		}
		else {
			response.sendRedirect("clientlogin.jsf?faces-redirect=true");
		}
	}
}
