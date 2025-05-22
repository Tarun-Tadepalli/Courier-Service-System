package com.klef.ep.services;

import javax.ejb.Remote;

import com.klef.ep.models.Client;
import com.klef.ep.models.Dispatcher;

@Remote
public interface ClientService {
	public String addClient(Client client);
	

	public Client clientlogin(String contact, String password);
	
	
	public String updateclient(Client client);
	
	
	public Client clientemail(String email);
}
