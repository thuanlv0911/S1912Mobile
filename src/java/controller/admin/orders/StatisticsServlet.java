/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.orders;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import models.ProductStatistics;

/**
 *
 * @author LE VAN THUAN
 */
public class StatisticsServlet extends HttpServlet {

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
            out.println("<title>Servlet StatisticsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StatisticsServlet at " + request.getContextPath() + "</h1>");
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
        DAO d = new DAO();
        List<String> prodIDs = new ArrayList<>();
        List<String> prodNames = new ArrayList<>();
        List<Integer> quantities = new ArrayList<>();
        List<Integer> totalSoldList = new ArrayList<>();
        int totalSoldSum = 0;

        try {
            List<ProductStatistics> statis = d.getProductStatistics();
            for (ProductStatistics stat : statis) {
                if (!"Canceled".equals(stat.getStatus())) {
                    prodIDs.add(stat.getProdID());
                    prodNames.add(stat.getProdName());
                    totalSoldList.add(stat.getTotalSold());
                    quantities.add(stat.getQuantity());
                    totalSoldSum += stat.getTotalSold();
                }
            }
            request.setAttribute("statisticsList", statis);
            request.setAttribute("prodIDs", prodIDs);
            request.setAttribute("prodNames", prodNames);
            request.setAttribute("totalSoldList", totalSoldList);
            request.setAttribute("quantities", quantities);
            request.setAttribute("totalSoldSum", totalSoldSum);
            request.getRequestDispatcher("/admin/orders/statistics.jsp").forward(request, response);

        } catch (ServletException e) {
            System.err.println(e);
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
