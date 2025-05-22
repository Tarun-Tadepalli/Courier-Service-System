package com.klef.ep.services;

import java.util.List;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import com.klef.ep.models.Admin;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)

public class AdminServiceImpl implements AdminService {

    @Override
    public Admin checkAdminLogin(String username, String password) 
    {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        
        Query qry = em.createQuery("select a from Admin a where a.username=? and a.password=?  ");
        qry.setParameter(1, username);
        qry.setParameter(2, password);
        
        Admin admin = null;
        if (!qry.getResultList().isEmpty()) {
            admin = (Admin) qry.getSingleResult();
        }
        
        
        em.close();
        emf.close();
        return admin;
    }
    
    @Override
    public long parcelcount() {
    	EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        
        Query qry = em.createQuery("select count(*) from Parcel");
        List list = qry.getResultList();
        
        long count = (long) list.get(0);
        
        return count;
    }
    @Override
    public long dispatchercount() {
    	EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        
        Query qry = em.createQuery("select count(*) from Dispatcher");
        List list = qry.getResultList();
        
        long count = (long) list.get(0);
        
        return count;
    }
}