package com.klef.ep.services;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.List;

import com.klef.ep.models.Parcel;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class ParcelServiceImpl implements ParcelService {
    @Override
    public String addParcel(Parcel parcel) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        
        em.getTransaction().begin();
        em.persist(parcel);
        em.getTransaction().commit();
        
        em.close();
        emf.close();
        
        return "Delivery created successfully";
    }

    @Override
    public Parcel viewParcelByAwbNo(String awbNo) {
        return getParcelByField("awbNo", awbNo);
    }

    @Override
    public Parcel viewParcelByLrn(String lrn) {
        return getParcelByField("lrn", lrn);
    }

    @Override
    public Parcel viewParcelByRcontact(String rcontact) {
        return getParcelByField("rcontact", rcontact);
    }

    @Override
    public Parcel viewParcelByPid(Long pid) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        
        Parcel parcel = em.find(Parcel.class, pid);
        
        em.close();
        emf.close();
        
        return parcel;
    }

    @Override
    public List<Parcel> viewParcelsByContact(String contact) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        
        List<Parcel> parcels = null;
        try {
            TypedQuery<Parcel> query = em.createQuery("SELECT p FROM Parcel p WHERE p.rcontact = :contact", Parcel.class);
            query.setParameter("contact", contact);
            parcels = query.getResultList();
        } catch (NoResultException e) {
            // Handle no result
        } finally {
            em.close();
            emf.close();
        }
        
        return parcels;
    }

    private Parcel getParcelByField(String fieldName, String fieldValue) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
        EntityManager em = emf.createEntityManager();
        
        Parcel parcel = null;
        try {
            TypedQuery<Parcel> query = em.createQuery("SELECT p FROM Parcel p WHERE p." + fieldName + " = :fieldValue", Parcel.class);
            query.setParameter("fieldValue", fieldValue);
            parcel = query.getSingleResult();
        } catch (NoResultException e) {
            // Handle no result
        } finally {
            em.close();
            emf.close();
        }
        
        return parcel;
    }
}
