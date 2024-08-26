package com.klef.ep.services;

import java.util.List;

import javax.ejb.Remote;

import com.klef.ep.models.Parcel;

@Remote
public interface ParcelService {
	public String addParcel(Parcel parcel);
	public Parcel viewParcelByAwbNo(String awbNo);
    public Parcel viewParcelByLrn(String lrn);
    public Parcel viewParcelByRcontact(String rcontact);
    public Parcel viewParcelByPid(Long pid);
    public List<Parcel> viewParcelsByContact(String contact);

}
