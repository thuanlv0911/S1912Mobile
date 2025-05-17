/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.orders;

import dal.AccountDAO;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.List;
import models.Account;
import models.Orders;

/**
 *
 * @author LE VAN THUAN
 */
public class OrderServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
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
        OrderDAO od = new OrderDAO();
        List<Orders> listOrders = od.getAllOrders();
        double totalAmountSum = 0;
        double highestOrderAmount = 0;
        double lowestOrderAmount = Double.MAX_VALUE;
        for (Orders order : listOrders) {
            order.setIsReceived(od.isOrderReceived(order.getOrderID()));
            if (!"Canceled".equals(order.getStatus())) {
                totalAmountSum += order.getTotalAmount();
                if (order.getTotalAmount() > highestOrderAmount) {
                    highestOrderAmount = order.getTotalAmount();
                }
                if (order.getTotalAmount() < lowestOrderAmount) {
                    lowestOrderAmount = order.getTotalAmount();
                }
            }
        }

        if (lowestOrderAmount == Double.MAX_VALUE) {
            lowestOrderAmount = 0;
        }

        DecimalFormat df = new DecimalFormat("#.##");
        request.setAttribute("totalAmountSum", df.format(totalAmountSum));
        request.setAttribute("highestOrderAmount", df.format(highestOrderAmount));
        request.setAttribute("lowestOrderAmount", df.format(lowestOrderAmount));
        request.setAttribute("orders", listOrders);
        request.getRequestDispatcher("/admin/orders/order.jsp").forward(request, response);
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
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        String status = request.getParameter("status");

        OrderDAO orderDAO = new OrderDAO();
        boolean success = orderDAO.updateOrderStatus(orderID, status);

        if (success) {
            response.sendRedirect("order");
        } else {
            request.setAttribute("error", "Change status is wrong!");
            response.sendRedirect("order");
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
