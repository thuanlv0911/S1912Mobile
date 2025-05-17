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
public class UpdateProdServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateProdServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProdServlet at " + request.getContextPath() + "</h1>");
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
    //        try {
//            // Lấy pid từ request
//            String pid = request.getParameter("pid");
//            if (pid == null || pid.trim().isEmpty()) {
//                response.setContentType("text/html;charset=UTF-8");
//                response.getWriter().println("Lỗi: pid không được cung cấp");
//                return;
//            }
//
//            // Khởi tạo DAO và lấy dữ liệu
//            DAO d = new DAO();
//            Products p = d.getProductsByPid(pid);
//            if (p == null) {
//                response.setContentType("text/html;charset=UTF-8");
//                response.getWriter().println("Lỗi: Không tìm thấy sản phẩm với pid = " + pid);
//                return;
//            }
//
//            List<Categories> listCate = d.getAll();
//            if (listCate == null) {
//                response.setContentType("text/html;charset=UTF-8");
//                response.getWriter().println("Lỗi: Không tải được danh sách danh mục");
//                return;
//            }
//
//            // Gửi dữ liệu tới JSP
//            request.setAttribute("cate", listCate);
//            request.setAttribute("prod", p);
//            request.getRequestDispatcher("/admin/product/update.jsp").forward(request, response);
//        } catch (Exception e) {
//            // Ghi lỗi chi tiết
//            response.setContentType("text/html;charset=UTF-8");
//            PrintWriter out = response.getWriter();
//            out.println("Lỗi xảy raa :" + e.getMessage());
//            e.printStackTrace(out);
//            out.close();
//        }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pid = request.getParameter("pid");
        DAO d = new DAO();
        Products p = d.getProductsByPid(pid);
        List<Categories> listCate = d.getAll();
        request.setAttribute("cate", listCate);
        request.setAttribute("prod", p);
        request.getRequestDispatcher("/admin/product/update.jsp").forward(request, response);
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
        try {
            String prodID = request.getParameter("pid");
            String prodName = request.getParameter("pname");
            String imagePath = request.getParameter("imagePath");
            String quantity_raw = request.getParameter("quantity");
            String price_raw = request.getParameter("price");
            String description = request.getParameter("description");
            String cid_raw = request.getParameter("cateID");

            System.out.println("cateID from form: " + cid_raw);

            int cid = 0;
            int quantity;
            double price;
            DAO d = new DAO();

//            if (cid_raw != null && !cid_raw.isEmpty()) {
//                cid = Integer.parseInt(cid_raw);
//            } else {
//                throw new NumberFormatException("Category ID is required");
//            }
            Products oldProduct = d.getProductsByPid(prodID);
            if (oldProduct == null) {
                request.setAttribute("error", "Product not found!");
                request.getRequestDispatcher("/admin/product/update.jsp").forward(request, response);
                return;
            }

            if (prodName == null || prodName.isEmpty()) {
                prodName = oldProduct.getProdName();
            }

            quantity = oldProduct.getQuantity();
            if (quantity_raw != null && !quantity_raw.isEmpty()) {
                quantity = Integer.parseInt(quantity_raw);
            }

            price = oldProduct.getPrice();
            if (price_raw != null && !price_raw.isEmpty()) {
                price = Double.parseDouble(price_raw);
            }

            if (description == null || description.isEmpty()) {
                description = oldProduct.getDescribe();
            }

            Categories c = oldProduct.getCategory();
            if (cid_raw != null && !cid_raw.isEmpty()) {
                cid = Integer.parseInt(cid_raw);
                c = d.getCategoryById(cid);
            }
            
            //Part de lay du lieu file
            Part filePart = request.getPart("imageFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (fileName != null && !fileName.isEmpty()) {
                String uploadDir = "D:\\FPT\\semester4\\PRJ301\\ASS\\S1912Mobile\\web\\admin\\img";
                File uploadFolder = new File(uploadDir);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs();
                }

                File uploadedFile = new File(uploadDir + "\\" + fileName);
                if (uploadedFile.exists()) {
                    request.setAttribute("error", "File already exists!");
                    request.getRequestDispatcher("/admin/product/update.jsp").forward(request, response);
                    return;
                }

                filePart.write(uploadedFile.getAbsolutePath());
                imagePath = "admin/img/" + fileName;
            } else if ((imagePath == null || imagePath.isEmpty())) {
                imagePath = oldProduct.getImage();
            }
            Products pNew = new Products(prodID, prodName, imagePath, quantity, price, description, null, c);
            d.updateProd(pNew);
            response.sendRedirect(request.getContextPath() + "/admin/product/product");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format: " + e.getMessage());
            request.getRequestDispatcher("/admin/product/update.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error occurred: " + e.getMessage());
            request.getRequestDispatcher("/admin/product/update.jsp").forward(request, response);
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
