package com.klef.ep.services;

import java.util.List;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import com.klef.ep.models.Dispatcher;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class DispatcherServiceImpl implements DispatcherService
{

	@Override
	public Dispatcher dispatcherlogin(String username, String password) 
	{
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
	    EntityManager em = emf.createEntityManager();
	    
	    Query qry = em.createQuery("select d from Dispatcher d where d.username=? and d.password=?  ");
	    qry.setParameter(1, username);
	    qry.setParameter(2, password);
	    	
        Dispatcher dispatch = null;
        
        if(qry.getResultList().size()>0)
        {
           dispatch  = (Dispatcher) qry.getSingleResult();
        }
    em.close();
    emf.close();
    
    return dispatch;
	    
	}



	@Override
	public String adddispatcher(Dispatcher dispatcher)
    {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
		EntityManager em = emf.createEntityManager();
		
		em.getTransaction().begin();
		em.persist(dispatcher);
		em.getTransaction().commit();
		
		em.close();
		emf.close();

		return "Dispatcher Registered Successfully";
		
	}

	@Override
	  public String updatedispatcher(Dispatcher dispatcher) {
	      EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
	      EntityManager em = emf.createEntityManager();
	      
	      try {
	          em.getTransaction().begin();
	          Dispatcher dis = em.find(Dispatcher.class, dispatcher.getContact());
	          
	          if (dis != null) {
	              dis.setPassword(dispatcher.getPassword());
	              em.getTransaction().commit();
	          } else {
	              em.getTransaction().rollback();
	              return "Update Failed: Dispatcher Not Found";
	          }
	      } catch (Exception e) {
	          em.getTransaction().rollback();
	          e.printStackTrace();
	          return "Update Failed: Exception occurred";
	      } finally {
	          em.close();
	          emf.close();
	      }
	      
	      return "Updated Successfully";
	  }
	
	@Override
	  public Dispatcher dispatcheremail(String email) {
	      EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
	      EntityManager em = emf.createEntityManager();
	      Dispatcher dispatch = null;

	      try {
	          Query qry = em.createQuery("SELECT d FROM Dispatcher d WHERE d.email = :email");
	          qry.setParameter("email", email);

	          if (!qry.getResultList().isEmpty()) {
	              dispatch = (Dispatcher) qry.getSingleResult();
	              System.out.println("Dispatcher found: " + dispatch.getEmail());
	          } else {
	              System.out.println("No dispatcher found for email: " + email);
	          }
	      } catch (Exception e) {
	          e.printStackTrace();  // Logging the exception
	      } finally {
	          em.close();
	          emf.close();
	      }

	      return dispatch;
	  }
	 @Override
	    public List<Dispatcher> getAllDispatchers() {
	        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
	        EntityManager em = emf.createEntityManager();
	        
	        Query qry = em.createQuery("select d from Dispatcher d");
	        List<Dispatcher> dispatchers = qry.getResultList();
	        
	        em.close();
	        emf.close();
	        
	        return dispatchers;
	    }
	 @Override
		public List<Dispatcher> viewalldis() {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
			EntityManager em = emf.createEntityManager();
			
			Query qry = em.createQuery("select e from Dispatcher e");
			// e is an alias of Employee Class
			List<Dispatcher> dislist = qry.getResultList();
			
		    em.close();
		    emf.close();
		    
		    return dislist;
		}
		

		@Override
		public String deletedispatcher(String contact) {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
			EntityManager em = emf.createEntityManager();
			
			em.getTransaction().begin();
			
			Dispatcher e = em.find(Dispatcher.class, contact);
			em.remove(e);
			em.getTransaction().commit();
			
			em.close();
			emf.close();
			
			return "Dispatcher Deleted Successfully";
		}


}
