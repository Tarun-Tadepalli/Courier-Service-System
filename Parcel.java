package com.klef.ep.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Deliveries")
@EntityListeners(ParcelListener.class)
public class Parcel implements Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "pid")
	private Long pid;
	@Column(name = "pname",length = 20,nullable = false)
	private String pname;
	@Column(name = "weight",nullable = false,precision = 10,scale = 4)
	private double weight;
	@Column(name="ptype",nullable = false,length = 30)
	private String ptype;
	@Column(length = 20,nullable = false)
	private String sname;
	@Column(length = 30,nullable = false)
	private String scity;
	@Column(length=20)
	private String scontact;
	@Column(length = 20,nullable = false)
	private String rname;
	@Column(length=20)
	private String rcontact;
	@Column(length = 50,nullable = false)
	private String remail;
	@Column(length = 30,nullable = false)
	private String rcity;
	@Column(length = 100,nullable = false)
	private String raddress;
	@Column(length = 30,nullable = false)
	private String shipping_type;
	@Column(length = 30,nullable = false)
	private String dispatcher = "none";
	@Column(length = 30,nullable = false)
	private String status = "Godown";
	@Column(name = "awbNo", unique = true, length = 20, nullable = false)
    private String awbNo;
    @Column(name = "lrn", unique = true, length = 20, nullable = false)
    private String lrn;
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getScity() {
		return scity;
	}
	public void setScity(String scity) {
		this.scity = scity;
	}
	public String getScontact() {
		return scontact;
	}
	public void setScontact(String scontact) {
		this.scontact = scontact;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getRcontact() {
		return rcontact;
	}
	public void setRcontact(String rcontact) {
		this.rcontact = rcontact;
	}
	public String getRemail() {
		return remail;
	}
	public void setRemail(String remail) {
		this.remail = remail;
	}
	public String getRcity() {
		return rcity;
	}
	public void setRcity(String rcity) {
		this.rcity = rcity;
	}
	public String getRaddress() {
		return raddress;
	}
	public void setRaddress(String raddress) {
		this.raddress = raddress;
	}
	public String getShipping_type() {
		return shipping_type;
	}
	public void setShipping_type(String shipping_type) {
		this.shipping_type = shipping_type;
	}
	public String getDispatcher() {
		return dispatcher;
	}
	public void setDispatcher(String dispatcher) {
		this.dispatcher = dispatcher;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAwbNo() {
		return awbNo;
	}
	public void setAwbNo(String awbNo) {
		this.awbNo = awbNo;
	}
	public String getLrn() {
		return lrn;
	}
	public void setLrn(String lrn) {
		this.lrn = lrn;
	}

}
