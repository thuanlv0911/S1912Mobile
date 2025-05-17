package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dal.AccountDAO;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import models.Account;
import models.Orders;

/**
 *
 * @author LE VAN THUAN
 */
public class ProfileServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        AccountDAO ad = new AccountDAO();
        OrderDAO od = new OrderDAO();
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("acc");
        if (user == null) {
            System.out.println("User not found in session!");
            response.sendRedirect("login");
            return;
        } else {
            System.out.println("User found: " + user.getUsername());
        }

        Account a = ad.getUserByUsername(user.getUsername());
        List<Orders> listOrders = od.getOrdersByAccID(user.getId());
        for (Orders order : listOrders) {
            order.setIsReceived(od.isOrderReceived(order.getOrderID()));
        }

        request.setAttribute("a", a);
        request.setAttribute("orders", listOrders);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        AccountDAO ad = new AccountDAO();
        OrderDAO od = new OrderDAO();

        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (email != null && phone != null && address != null) {
            account.setEmail(email);
            account.setPhoneNumber(phone);
            account.setAddress(address);
            ad.updateAddress(account);
            session.setAttribute("acc", account);
            session.setAttribute("succ", "Update successfully!");
            response.sendRedirect("profile");
            return;
        }

        String orderID_raw = request.getParameter("orderID");
        if (orderID_raw != null && !orderID_raw.isEmpty()) {
            try {
                int orderID = Integer.parseInt(orderID_raw);
                boolean success = od.markAsReceived(orderID);
                if (!success) {
                    request.setAttribute("err", "Failed to update order status!");
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid order ID: " + e);
            }
        }

        response.sendRedirect("profile");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
