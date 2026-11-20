package org.example.collegeevent.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.collegeevent.dao.UserDAO;
import org.example.collegeevent.model.User;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.login(email, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("role", user.getRole());

            if ("STUDENT".equals(user.getRole())) {
                response.sendRedirect("student-dashboard.jsp");

            } else if ("ORGANIZER".equals(user.getRole())) {
                response.sendRedirect("organizer-dashboard.jsp");

            } else if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("admin-dashboard.jsp");

            } else {
                response.sendRedirect("login.jsp?error=1");
            }

        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}