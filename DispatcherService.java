package com.klef.ep.services;

import javax.ejb.Remote;

import com.klef.ep.models.Dispatcher;

@Remote
public interface DispatcherService {
	
	public Dispatcher dispatcherlogin(String username, String password);
	
	public Dispatcher dispatcheremail(String email);
	
	public String adddispatcher(Dispatcher dispatcher);
	
	public String updatedispatcher(Dispatcher dispatcher);
}
