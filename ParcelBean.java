package com.klef.ep.beans;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.faces.bean.ManagedBean;

import com.klef.ep.models.Parcel;
import com.klef.ep.services.ParcelService;
import java.util.List;

@Stateless
@ManagedBean(name="parcelbean", eager=true)
public class ParcelBean {
    @EJB(lookup = "java:global/EPPROJECT/ParcelServiceImpl!com.klef.ep.services.ParcelService")
    private ParcelService service;

    private Long pid;
    private String pname;
    private double weight;
    private String ptype;
    private String sname;
    private String scity;
    private String scontact;
    private String rname;
    private String rcontact;
    private String remail;
    private String rcity;
    private String raddress;
    private String shipping_type;
    private String dispatcher = "none";
    private String status = "Godown";
    private String awbNo;
    private String lrn;

    // Getters and setters for all fields

    public ParcelService getService() {
		return service;
	}

	public void setService(ParcelService service) {
		this.service = service;
	}

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

	public String padd() {
        Parcel p = new Parcel();

        p.setPname(pname);
        p.setDispatcher(dispatcher);
        p.setPtype(ptype);
        p.setRaddress(raddress);
        p.setRcity(rcity);
        p.setRcontact(rcontact);
        p.setRemail(remail);
        p.setRname(rname);
        p.setScity(scity);
        p.setScontact(scontact);
        p.setShipping_type(shipping_type);
        p.setSname(sname);
        p.setStatus(status);
        p.setWeight(weight);

        service.addParcel(p);

        return "parcelsuccess.jsf";
    }

    public Parcel viewParcel(String searchType, String searchValue) {
        if (searchValue == null || searchValue.trim().isEmpty()) {
            return null;
        }

        switch (searchType) {
            case "awbNo":
                return service.viewParcelByAwbNo(searchValue);
            case "lrn":
                return service.viewParcelByLrn(searchValue);
            case "rcontact":
                return service.viewParcelByRcontact(searchValue);
            case "pid":
                try {
                    Long pidLong = Long.parseLong(searchValue);
                    return service.viewParcelByPid(pidLong);
                } catch (NumberFormatException e) {
                    return null;
                }
            default:
                return null;
        }
    }

    public List<Parcel> viewParcelsByContact(String contact) {
        return service.viewParcelsByContact(contact);
    }
}
