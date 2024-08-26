package com.klef.ep.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Dispatcher")
public class Dispatcher implements 	Serializable
{
	@Column(name = "username",unique = true,length = 20,nullable = false)
	private String username;
	@Id
	@Column(name = "contact",length=20)
	private String contact;
	@Column(name = "email",unique = true,length = 50,nullable = false)
	private String email;
	@Column(name = "address",length = 100,nullable = false)
	private String address;
	@Column(name = "city",length = 20,nullable = false)
	private String city;
	@Column(name = "pincode",length = 20,nullable = false)
	private String pincode;
	@Column(name = "password",length = 30,nullable = false)
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
	
}
