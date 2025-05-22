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

        try {
            em.getTransaction().begin();
            em.persist(client);
            em.getTransaction().commit();
            return "Client Registered Successfully";
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return "Registration Failed";
        } finally {
            em.close();
            emf.close();
        }
    }

    @Override
    public Client clientlogin(String contact, String password) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        Client client = null;

        try {
            Query qry = em.createQuery("select c from Client c where c.contact=:contact and c.password=:password");
            qry.setParameter("contact", contact);
            qry.setParameter("password", password);

            if (qry.getResultList().size() > 0) {
                client = (Client) qry.getSingleResult();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }

        return client;
    }

    @Override
    public String updateclient(Client client) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            Client clie = em.find(Client.class, client.getContact());

            if (clie != null) {
                clie.setPassword(client.getPassword());
                em.getTransaction().commit();
                return "Updated Successfully";
            } else {
                em.getTransaction().rollback();
                return "Update Failed: Client Not Found";
            }
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return "Update Failed: Exception occurred";
        } finally {
            em.close();
            emf.close();
        }
    }

    @Override
    public Client clientemail(String email) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        Client cli = null;

        try {
            Query qry = em.createQuery("SELECT c FROM Client c WHERE c.email = :email");
            qry.setParameter("email", email);

            if (!qry.getResultList().isEmpty()) {
                cli = (Client) qry.getSingleResult();
                System.out.println("Client found: " + cli.getEmail());
            } else {
                System.out.println("No client found for email: " + email);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }

        return cli;
    }
}
