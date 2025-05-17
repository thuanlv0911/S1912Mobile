/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import dal.CartDAO;
import dal.DAO;
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
import models.Item;

/**
 *
 * @author LE VAN THUAN
 */
public class CheckOutServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckOutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckOutServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");

        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        AccountDAO ad = new AccountDAO();
        Account a = ad.getUserByUsername(account.getUsername());
        request.setAttribute("a", a);

        CartDAO cartDAO = new CartDAO();
        List<Item> cartItems = cartDAO.getCartItems(account.getId());
        request.setAttribute("cartItems", cartItems);

        double subtotal = 0;
        for (Item item : cartItems) {
            subtotal += item.getQuantity() * (item.getProduct().getPrice() - (item.getProduct().getPrice() * 0.15));
        }
        double shippingFee = 10;
        double totalAmount = subtotal + shippingFee;

        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("totalAmount", totalAmount);

        request.getRequestDispatcher("checkOut.jsp").forward(request, response);
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
        String username = request.getParameter("username");
        String address = request.getParameter("address");
        String phone = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        System.out.println("Username: " + username);
        System.out.println("Address: " + address);
        System.out.println("Phone: " + phone);
        System.out.println("Email: " + email);
        CartDAO cartDAO = new CartDAO();
        List<Item> cartItems = cartDAO.getCartItems(account.getId());

        if (cartItems.isEmpty()) {
            request.setAttribute("error", "Empty cart. Please try again!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        DAO productDAO = new DAO();

        for (Item item : cartItems) {
            int availableQuantity = productDAO.getProductQuantity(item.getProduct().getProdID());
            if (item.getQuantity() > availableQuantity) {
                request.setAttribute("error", "Product " + item.getProduct().getProdName() + " is out of stock or not enough quantity.");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }
        }
        double subtotal = 0;
        for (Item item : cartItems) {
            subtotal += item.getQuantity() * (item.getProduct().getPrice() - (item.getProduct().getPrice() * 0.15));
        }
        double shippingFee = 10;
        double totalAmount = subtotal + shippingFee;

        OrderDAO od = new OrderDAO();
        int orderId = od.createOrder(account.getId(), address, phone, email);

        if (orderId > 0) {
            od.addOrderItems(orderId, account.getId());
            od.updateTotalAmount(orderId, totalAmount);
            od.clearCart(account.getId());
            response.sendRedirect("order-success");
        } else {
            request.setAttribute("error", "Order failed. Please try again!");
            request.getRequestDispatcher("checkOut.jsp").forward(request, response);
        }
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
