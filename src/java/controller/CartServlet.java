/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CartDAO;
import dal.DAO;
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
import models.Products;

/**
 *
 * @author LE VAN THUAN
 */
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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

        CartDAO cd = new CartDAO();
        DAO d = new DAO(); // Để lấy thông tin sản phẩm
        List<Item> cartItems = cd.getCartItems(account.getId());

        double subtotal = 0;
        for (Item item : cartItems) {
            subtotal += (item.getProduct().getPrice() - (item.getProduct().getPrice() * 0.15)) * item.getQuantity();

            // Cập nhật số lượng tối đa có thể chọn
            Products product = d.getProductsByPid(item.getProduct().getProdID());
            int maxQuantity = product.getQuantity();
            item.getProduct().setQuantity(maxQuantity);
        }

        double shippingFee = 10;
        double totalAmount = subtotal + shippingFee;

        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("cartItems", cartItems);
        System.out.println("Cart Items: " + cartItems.size());
        request.getRequestDispatcher("cart.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        CartDAO cd = new CartDAO();
        DAO d = new DAO(); // Để lấy thông tin sản phẩm
        int itemID;
        int newQuantity;
        int quantity;

        try {
            if ("add".equals(action)) {
                String prodID = request.getParameter("prodID");
                quantity = Integer.parseInt(request.getParameter("quantity"));

                int cartID = cd.getCartIDByAccID(account.getId());
                if (cartID == -1) {
                    cartID = cd.createCartForUser(account.getId());
                }

                Products product = d.getProductsByPid(prodID);
                if (product == null || product.getQuantity() <= 0) {
                    response.sendRedirect("cart");
                    return;
                }

                Item existingItem = cd.getItemByCartAndProduct(cartID, prodID);

                if (existingItem != null) {
                    int totalQuantity = existingItem.getQuantity() + quantity;

                    if (totalQuantity > product.getQuantity()) {
                        totalQuantity = product.getQuantity();
                    }

                    cd.updateItemQuantity(existingItem.getItemID(), totalQuantity);
                } else {
                    if (quantity > product.getQuantity()) {
                        quantity = product.getQuantity();
                    }
                    cd.addItemToCart(cartID, prodID, quantity);
                }

            } else if ("update".equals(action)) {
                itemID = Integer.parseInt(request.getParameter("itemID"));
                newQuantity = Integer.parseInt(request.getParameter("quantity"));

                Item item = cd.getItemById(itemID);
                if (item != null) {
                    Products product = d.getProductsByPid(item.getProduct().getProdID());

                    if (newQuantity > product.getQuantity()) {
                        newQuantity = product.getQuantity();
                    }
                    cd.updateItemQuantity(itemID, newQuantity);
                }

            } else if ("delete".equals(action)) {
                itemID = Integer.parseInt(request.getParameter("itemID"));
                cd.deleteItem(itemID);
            }
        } catch (NumberFormatException e) {
            System.err.println(e);
        }
        response.sendRedirect("cart");
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
