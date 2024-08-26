package com.klef.ep.services;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import com.klef.ep.models.Client;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class ClientServiceImpl implements ClientService {

	@Override
	public String addClient(Client client) {

		EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
		EntityManager em = emf.createEntityManager();
		
		em.getTransaction().begin();
		em.persist(client);
		em.getTransaction().commit();
		
		em.close();
		emf.close();

		return "Client Registered Successfully";
	}

	@Override
	public Client clientlogin(String contact, String password) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
		EntityManager em = emf.createEntityManager();
		
		Query qry = em.createQuery("select c from Client c where c.contact=? and c.password=?");
		qry.setParameter(1,contact);
		qry.setParameter(2, password);
		
		Client emp = null;
		
		if(qry.getResultList().size()>0) {
			emp = (Client)  qry.getSingleResult();
		}
		
		em.close();
		emf.close();
		
		return emp;
	}

}
