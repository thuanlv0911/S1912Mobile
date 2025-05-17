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
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import models.Categories;
import models.Products;

/**
 *
 * @author LE VAN THUAN
 */
public class SearchServlet extends HttpServlet {

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
            out.println("<title>Servlet SearchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchServlet at " + request.getContextPath() + "</h1>");
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
        request.setAttribute("cate", listCate);

        String key = request.getParameter("key");
        String cID_raw = request.getParameter("cID");

        List<Products> listProd = new ArrayList<>();
        int cID = 0;

        try {
            if (key != null && !key.trim().isEmpty()) {
                listProd = d.getProductByKey(key);
            } else if (cID_raw != null) {
                cID = Integer.parseInt(cID_raw);
                listProd = (cID == 0) ? d.getAllProducts() : d.getProductsById(cID);
            } else {
                listProd = d.getAllProducts();
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid category ID: " + e.getMessage());
        }

        request.setAttribute("prod", listProd);
        request.setAttribute("cID", cID);
        request.setAttribute("key", key);
        request.getRequestDispatcher("products.jsp").forward(request, response);

    }
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        DAO d = new DAO();
//        List<Categories> listCate = d.getAll();
//        request.setAttribute("cate", listCate);
//        String cID_raw = request.getParameter("cID");
//        String cid_raw = request.getParameter("key");
//        String pricef_raw = request.getParameter("pricefrom");
//        String pricet_raw = request.getParameter("priceto");
//        Double pricef, pricet;
//        int cid;
//        try {
//            cid = (cid_raw == null) ? 0 : Integer.parseInt(cid_raw);
//            pricef = ((pricef_raw == null) || (pricef_raw.isEmpty())) ? null : Double.parseDouble(pricef_raw);
//            pricet = ((pricet_raw == null) || (pricet_raw.isEmpty())) ? null : Double.parseDouble(pricet_raw);
//            List<Products> listProd = d.searchPriceAndCateId(pricef, pricet, cid);
//            request.setAttribute("prod", listProd);
//            request.getRequestDispatcher("products.jsp").forward(request, response);
//        } catch (NumberFormatException e) {
//            System.err.println(e);
//        }
//    }
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
////        String[] price = {"Under 1000.0",
////            "From 1000.0 to 2500.0",
////            "From 2500.0 to 5000.0",
////            "From 5000.0 to 10000.0",
////            "From 10000.0 to 20000.0",
////            "Over 20000.0"};
////        boolean[] priceLeft = new boolean[price.length + 1];
//        DAO d = new DAO();
//        List<Categories> listCate = d.getAll();
////        boolean[] cateLeft = new boolean[listCate.size() + 1];
//        String key = request.getParameter("key");
//        List<Products> listProd = new ArrayList<>();
//        if (key != null) {
//            listProd = d.getProductByKey(key);
//        }
//        String cID_raw = request.getParameter("cID");
////        String[] cid_raw = request.getParameterValues("cid");
////        String[] prices = request.getParameterValues("prices");
////        int[] cid = null;
//        int cID = 0;
//
//        if (cID_raw != null) {
//            cID = Integer.parseInt(cID_raw);
//            listProd = d.getProductsById(cID);
////            if (cID == 0) {
////                cateLeft[0] = true;
////            }
//        }
//
////        if (cid_raw != null) {
////            cid = new int[cid_raw.length];
////            for (int i = 0; i < cid.length; i++) {
////                cid[i] = Integer.parseInt(cid_raw[i]);
////            }
////            listProd = d.getProductsByCheckboxId(cid);
////        }
////        if (prices != null) {
////            double from, to;
////            for (String priceOption : prices) {
////                List<Products> tmp = new ArrayList<>();
////                switch (priceOption) {
////                    case "0":
////                        from = 0;
////                        to = 50000;
////                        listProd = d.getProductsByPrice(from, to);
////                        priceLeft[0] = true;
////                        break;
////                    case "1":
////                        from = 0;
////                        to = 1000;
////                        tmp = d.getProductsByPrice(from, to);
////                        priceLeft[1] = true;
////                        break;
////                    case "2":
////                        from = 1000;
////                        to = 2500;
////                        tmp = d.getProductsByPrice(from, to);
////                        priceLeft[2] = true;
////                        break;
////                    case "3":
////                        from = 2500;
////                        to = 5000;
////                        tmp = d.getProductsByPrice(from, to);
////                        priceLeft[3] = true;
////                        break;
////                    case "4":
////                        from = 5000;
////                        to = 10000;
////                        tmp = d.getProductsByPrice(from, to);
////                        priceLeft[4] = true;
////                        break;
////                    case "5":
////                        from = 10000;
////                        to = 20000;
////                        tmp = d.getProductsByPrice(from, to);
////                        priceLeft[5] = true;
////                        break;
////                    case "6":
////                        from = 20000;
////                        to = 50000;
////                        tmp = d.getProductsByPrice(from, to);
////                        priceLeft[6] = true;
////                        break;
////                }
////                listProd.addAll(tmp);
////            }
////        } else {
////            priceLeft[0] = true;
////        }
////        if (cID_raw == null) {
////            cateLeft[0] = true;
////        }
////        if ((cid_raw != null) && (cid[0] != 0)) {
////            cateLeft[0] = false;
////            for (int i = 1; i < cateLeft.length; i++) {
////                if (isCheck(listCate.get(i - 1).getCateID(), cid)) {
////                    cateLeft[i] = true;
////                } else {
////                    cateLeft[i] = false;
////                }
////            }
////        }
//        //data = cate
//        //products = prod
//        //pp = price
//        //pb = priceLeft
//        //cid = cID
//        //cidd = cid
//        //chid = cateLeft
//        //price = prices
//        request.setAttribute("cate", listCate);
//        request.setAttribute("prod", listProd);
//        request.setAttribute("key", key);
////        request.setAttribute("price", price);
////        request.setAttribute("priceLeft", priceLeft);
//        request.setAttribute("cID", cID);
////        request.setAttribute("cateLeft", cateLeft);
//        request.getRequestDispatcher("products.jsp").forward(request, response);
//    }

//    private boolean isCheck(int cate, int[] cid) {
//        if (cid == null) {
//            return false;
//        } else {
//            for (int i = 0; i < cid.length; i++) {
//                if (cid[i] == cate) {
//                    return true;
//                }
//            }
//            return false;
//        }
//    }
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
        //processRequest(request, response);
//        DAO d = new DAO();
//        List<Categories> listCate = d.getAll();
//        request.setAttribute("cate", listCate);
//        String cid_raw = request.getParameter("key");
//        String pricef_raw = request.getParameter("pricefrom");
//        String pricet_raw = request.getParameter("priceto");
//        Double pricef, pricet;
//        int cid;
//        try {
//            cid = (cid_raw == null) ? 0 : Integer.parseInt(cid_raw);
//            pricef = ((pricef_raw == null) || (pricef_raw.equals(""))) ? null : Double.parseDouble(pricef_raw);
//            pricet = ((pricet_raw == null) || (pricet_raw.equals(""))) ? null : Double.parseDouble(pricet_raw);
//            List<Products> listProd = d.searchPriceAndCateId(pricef, pricet, cid);
//            request.setAttribute("prod", listProd);
//            request.getRequestDispatcher("products.jsp").forward(request, response);
//        } catch (NumberFormatException e) {
//            System.err.println(e);
//        }
        
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
