package com.klef.ep.services;

import javax.ejb.Remote;

import com.klef.ep.models.Client;

@Remote
public interface ClientService {
	public String addClient(Client client);
	

	public Client clientlogin(String contact, String password);
}
