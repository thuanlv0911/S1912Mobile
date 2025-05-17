/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.product;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import models.Categories;
import models.Products;

/**
 *
 * @author LE VAN THUAN
 */
@MultipartConfig
public class AddProdServlet extends HttpServlet {

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
            out.println("<title>Servlet AddProdServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProdServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
        // Lấy dữ liệu từ request
//        String prodID = request.getParameter("pid");
//        String prodName = request.getParameter("pname");
//        String imagePath = request.getParameter("imagePath");
//        String quantityRaw = request.getParameter("quantity");
//        String priceRaw = request.getParameter("price");
//        String description = request.getParameter("description");
//        String cid_raw = request.getParameter("cateID");
//        try {
//
//            // Kiểm tra null hoặc chuỗi rỗng
//            if (prodID == null || prodID.trim().isEmpty()
//                    || prodName == null || prodName.trim().isEmpty()
//                    || quantityRaw == null || quantityRaw.trim().isEmpty()
//                    || priceRaw == null || priceRaw.trim().isEmpty()
//                    || description == null || description.trim().isEmpty()
//                    || cid_raw == null || cid_raw.trim().isEmpty()) {
//                request.setAttribute("error", "All fields are required!");
//                request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//                return;
//            }
//
//            // Chuyển đổi dữ liệu số
//            int quantity;
//            double price;
//            int cid;
//            try {
//                quantity = Integer.parseInt(quantityRaw);
//                price = Double.parseDouble(priceRaw);
//                cid = Integer.parseInt(cid_raw);
//            } catch (NumberFormatException e) {
//                request.setAttribute("error", "Invalid number format for quantity, price, or category ID!");
//                request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//                return;
//            }
//
//            DAO d = new DAO();
//            Products p = d.getProductsByPid(prodID);
//            Categories c = d.getCategoryById(cid);
//
//            if (p != null) {
//                request.setAttribute("error", "Product ID " + prodID + " already exists, please try again!");
//                request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//                return;
//            }
//
//            // Xử lý file upload
//            Part filePart = request.getPart("imageFile");
//            String fileName = (filePart != null) ? Paths.get(filePart.getSubmittedFileName()).getFileName().toString() : "";
//
//            if (filePart != null && fileName != null && !fileName.isEmpty()) {
//                String uploadDir = "D:\\FPT\\semester4\\PRJ301\\ASS\\S1912Mobile\\web\\admin\\product\\img";
//                File uploadFolder = new File(uploadDir);
//                if (!uploadFolder.exists()) {
//                    uploadFolder.mkdirs();
//                }
//                File uploadedFile = new File(uploadDir + File.separator + fileName);
//                if (uploadedFile.exists()) {
//                    request.setAttribute("error", "File already exists!");
//                    request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//                    return;
//                }
//                filePart.write(uploadedFile.getAbsolutePath());
//                imagePath = "img/" + fileName;
//            }
//
//            // Lưu sản phẩm mới vào database
//            Products pNew = new Products(prodID, prodName, imagePath, quantity, price, description, null, c);
//            d.addProd(pNew);
//            response.sendRedirect(request.getContextPath() + "/admin/product/product");
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
//            request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//        }
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
        String prodID = request.getParameter("pid");
        String prodName = request.getParameter("pname");
        String imagePath = request.getParameter("imagePath");
        String quantity_raw = request.getParameter("quantity");
        String price_raw = request.getParameter("price");
        String description = request.getParameter("description");
        String cid_raw = request.getParameter("cateID");
        int cid;
        int quantity;
        double price;
        DAO d = new DAO();

        try {
            quantity = Integer.parseInt(quantity_raw);
            price = Double.parseDouble(price_raw);
            cid = (cid_raw == null) ? 0 : Integer.parseInt(cid_raw);
            Categories c = d.getCategoryById(cid);

            //Part de lay du lieu file
            Part filePart = request.getPart("imageFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            //khong có file thi error
            if (fileName == null || fileName.isEmpty()) {
                request.setAttribute("error", "No file uploaded!");
                request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
                return;
            }

            // lay duong dan
            String uploadDir = "D:\\FPT\\semester4\\PRJ301\\ASS\\S1912Mobile\\web\\admin\\img";
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

            //luu phai vao dung duong dan thay vi tu dong luu vao built
            //dung File.separator thay cho \\ cung đuoc
            File uploadedFile = new File(uploadDir + "\\" + fileName);

            if (uploadedFile.exists()) {
                request.setAttribute("error", "File already exists!");
                request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
                return;
            }

            filePart.write(uploadedFile.getAbsolutePath());

            if (!fileName.isEmpty()) {
                imagePath = "admin/img/" + fileName;
            }

            Products p = d.getProductsByPid(prodID);
            if (p == null) {
                Products pNew = new Products(prodID, prodName, imagePath, quantity, price, description, null, c);
                d.addProd(pNew);
                List<Categories> listCate = d.getAll();
                request.setAttribute("cate", listCate);
                response.sendRedirect(request.getContextPath() + "/admin/product/product");
            } else {
                List<Categories> listCate = d.getAll();
                request.setAttribute("cate", listCate);
                request.setAttribute("error", "Product ID " + prodID + " already exists! Please try again.");
                request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            //e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
        }
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
////        DAO d = new DAO();
////        List<Categories> listCate = d.getAll();
////        //HttpSession session = request.getSession();
////        request.setAttribute("cate", listCate);
////        //response.sendRedirect(request.getContextPath() + "/admin/product/product");
////        request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//        try {
//
//            String prodID = request.getParameter("pid");
//            String prodName = request.getParameter("pname");
//            String imagePath = request.getParameter("imagePath");
//            String quantityStr = request.getParameter("quantity");
//            String priceStr = request.getParameter("price");
//            String description = request.getParameter("description");
//            String cid_raw = request.getParameter("cateID");
//
//            // Kiểm tra dữ liệu nhập vào có trống không
//            if (prodID == null || prodID.isEmpty()
//                    || prodName == null || prodName.isEmpty()
//                    || quantityStr == null || quantityStr.isEmpty()
//                    || priceStr == null || priceStr.isEmpty()
//                    || description == null || description.isEmpty()
//                    || cid_raw == null || cid_raw.isEmpty()) {
//
//                request.setAttribute("error", "All fields are required!");
//                request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//                return;
//            }
//            DAO d = new DAO();
//            int quantity = Integer.parseInt(quantityStr);
//            double price = Double.parseDouble(priceStr);
//            int cid = Integer.parseInt(cid_raw);
//
//            Products p = d.getProductsByPid(prodID);
//            Categories c = d.getCategoryById(cid);
//
//            // Xử lý upload file
//            Part filePart = request.getPart("imageFile");
//            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//            if (fileName != null && !fileName.isEmpty()) {
//                String uploadDir = "D:\\FPT\\semester4\\PRJ301\\ASS\\S1912Mobile\\web\\admin\\product\\img";
//                File uploadFolder = new File(uploadDir);
//                if (!uploadFolder.exists()) {
//                    uploadFolder.mkdirs();
//                }
//
//                File uploadedFile = new File(uploadDir + "\\" + fileName);
//                if (uploadedFile.exists()) {
//                    request.setAttribute("error", "File already exists!");
//                    request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//                    return;
//                }
//
//                filePart.write(uploadedFile.getAbsolutePath());
//                imagePath = "img/" + fileName;
//            }
//
//            // Kiểm tra sản phẩm đã tồn tại chưa
//            if (p == null) {
//                Products pNew = new Products(prodID, prodName, imagePath, quantity, price, description, null, c);
//                d.addProd(pNew);
//                response.sendRedirect(request.getContextPath() + "/admin/product/product");
//            } else {
//                request.setAttribute("error", "Product ID already exists, please try again!");
//                request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.setAttribute("error", "Error: " + e.getMessage());
//            request.getRequestDispatcher("/admin/product/add.jsp").forward(request, response);
//        }
//    }
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
