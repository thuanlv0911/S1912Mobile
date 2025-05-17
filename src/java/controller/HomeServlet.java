/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import models.Categories;
import models.Products;

/**
 *
 * @author LE VAN THUAN
 */
public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
        DAO d = new DAO();
        List<Categories> listCate = d.getAll();

        String cateID_raw = request.getParameter("key2");
        String key = request.getParameter("key");
        String page_raw = request.getParameter("page");
        String bestSelling = request.getParameter("bestSelling");

        List<Products> listProd = new ArrayList<>();
        List<Products> neww = d.getNewProduct();
        List<Products> oldd = d.getOldProduct();

        int cateID = 0, page = 1, pageSize = 10;

        try {
            cateID = (cateID_raw == null) ? 0 : Integer.parseInt(cateID_raw);
            if (page_raw != null) {
                page = Integer.parseInt(page_raw);
            }
        } catch (NumberFormatException e) {
            System.err.println(e);
        }

        System.out.println("cateID: " + cateID + ", page: " + page + ", pageSize: " + pageSize);
        System.out.println("OFFSET: " + ((page - 1) * pageSize));

        int totalProducts;
        int totalPages = 1; // khong co san pham thi mac dinh co 1 trang

        if (bestSelling != null) {
            // neu nguoi dung bam vao nut Best Selling
            listProd = d.getBestSellingProduct();
        } else if (key != null && !key.trim().isEmpty()) {
            // neu tim kiem tren navbar, search theo key, khong phan trang
            listProd = d.getProductByKey(key);
        } else {
            // khong search tren navbar thi phan trang 
            totalProducts = d.getTotalProducts(cateID);
            listProd = d.getProductsByPage(cateID, page, pageSize);
            if (totalProducts > 0) {
                totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            }
        }

        System.out.println("Number of products: " + listProd.size());
        
        request.setAttribute("neww", neww);
        request.setAttribute("oldd", oldd);
        request.setAttribute("cate", listCate);
        request.setAttribute("prod", listProd);
        request.setAttribute("key", key);
        request.setAttribute("cateID", cateID);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("scrollToProducts", true);

        request.getRequestDispatcher("home.jsp").forward(request, response);
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
        processRequest(request, response);
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
