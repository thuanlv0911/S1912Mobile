/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import models.OrderDetail;
import models.Orders;

/**
 *
 * @author LE VAN THUAN
 */
public class UserOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet UserOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserOrderServlet at " + request.getContextPath() + "</h1>");
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
        OrderDAO od = new OrderDAO();
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String orderID_raw = request.getParameter("orderID");
        if (orderID_raw == null) {
            response.sendRedirect("profile");
            return;
        }

        try {
            int orderID = Integer.parseInt(orderID_raw);
            Orders o = od.getOrderByOrderId(orderID);
            AccountDAO ad = new AccountDAO();
            Account acc = ad.getAccountByID(o.getAccID());

            if (acc == null) {
                request.setAttribute("error", "Account not found!");
                System.out.println("aEx");

            }

            if (o == null) {
                session.setAttribute("err", "Order not found!");
                response.sendRedirect("profile");
                return;
            }

            if (o.getAccID() != user.getId()) {
                response.sendRedirect("profile");
                return;
            }

            List<OrderDetail> listOrderDetail = od.getOrderDetails(orderID);
            
            request.setAttribute("orderDetails", listOrderDetail);
            request.setAttribute("order", o);
            request.setAttribute("a", acc);
            request.getRequestDispatcher("userOrderDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println("Invalid order ID: " + e);
        }
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
        Account user = (Account) session.getAttribute("acc");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        OrderDAO od = new OrderDAO();
        String orderID_raw = request.getParameter("orderID");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        try {
            int orderID = Integer.parseInt(orderID_raw);
            Orders order = od.getOrderByOrderId(orderID);

            if (order == null) {
                session.setAttribute("err", "Order not found!");
                response.sendRedirect("profile");
                return;
            }

            if (order.getAccID() == user.getId() && "Pending".equals(order.getStatus())) {
                order.setEmail(email);
                order.setPhoneNumber(phone);
                order.setAddress(address);

                boolean updated = od.updateOrderAddress(order);

                if (updated) {
                    session.setAttribute("succ", "Order updated successfully!");
                } else {
                    session.setAttribute("err", "Failed to update order. Please try again.");
                }
            } else {
                session.setAttribute("err", "You are not authorized to update this order.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("err", "Invalid order ID!");
        }
        response.sendRedirect("user-order?orderID=" + orderID_raw);
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
