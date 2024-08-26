package com.klef.ep.beans;

import java.io.IOException;

import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.klef.ep.models.Admin;
import com.klef.ep.services.AdminService;

@ManagedBean(name = "adminbean", eager = true)
public class AdminBean {

    @EJB(lookup = "java:global/EPPROJECT/AdminServiceImpl!com.klef.ep.services.AdminService")
    AdminService adminService;

    private String username;
    private String password;


    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }





    public void validateAdminLogin() throws IOException {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        ExternalContext externalContext = facesContext.getExternalContext();
        HttpServletRequest request = (HttpServletRequest) externalContext.getRequest();
        HttpServletResponse response = (HttpServletResponse) externalContext.getResponse();
        Admin admin = adminService.checkAdminLogin(username, password);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            response.sendRedirect("adminHP.jsp");
        } else {
            response.sendRedirect("AdminLoginFail.jsf");
        }
    }
}
