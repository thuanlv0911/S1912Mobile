/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.account;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;

/**
 *
 * @author LE VAN THUAN
 */
public class ForgotPassServlet extends HttpServlet {

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
            out.println("<title>Servlet ForgotPassServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPassServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("forgot.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    //private static final long serialVersionUID = 1L;
    private static final int CODE_EXPIRY_TIME = 2 * 60 * 1000;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO ad = new AccountDAO();
        String email = request.getParameter("email");

        if (email != null && request.getParameter("code") == null) {
            //b1 check email 
            if (!ad.checkEmailExists(email)) {
                request.setAttribute("error", "Email not found!");
                request.getRequestDispatcher("forgot.jsp").forward(request, response);
                return;
            }

            //tao ma OTP roi day len session
            //System.currentTimeMillis() thoi gian hien tai tinh bang mili giay
            String code = String.valueOf(100000 + new Random().nextInt(900000));
            session.setAttribute("resetCode", code);
            session.setAttribute("resetTime", System.currentTimeMillis());
            session.setAttribute("email", email);

            //lay ma OTP ở sout
            System.out.println("Verification Code: " + code);
            
            //set verify thi ben JSP doi form khac de nhap OTP
            request.setAttribute("step", "verify");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        } else {
            //b2: check OTP và reset new password
            String code = request.getParameter("code");
            String newPassword = request.getParameter("newPassword");
            String sessionCode = (String) session.getAttribute("resetCode");
            Long resetTime = (Long) session.getAttribute("resetTime");
            email = (String) session.getAttribute("email");

            // check OTP voi OTP duoc lay tu Sout
            if (sessionCode == null || !sessionCode.equals(code)) {
                request.setAttribute("error", "Invalid verification code!");
                request.setAttribute("step", "verify");
                request.setAttribute("email", email);
                request.getRequestDispatcher("forgot.jsp").forward(request, response);
                return;
            }

            //check thoi gian OTP
            if (System.currentTimeMillis() - resetTime > CODE_EXPIRY_TIME) {
                session.removeAttribute("resetCode");
                session.removeAttribute("resetTime");
                request.setAttribute("error", "Verification code expired. Please request a new one.");
                request.getRequestDispatcher("forgot.jsp").forward(request, response);
                return;
            }

            // update password
            boolean updated = ad.updatePasswordByEmail(email, newPassword);
            if (updated) {
                session.removeAttribute("resetCode");
                session.removeAttribute("resetTime");
                session.removeAttribute("email");
                request.setAttribute("success", "Password reset successfully!");
            } else {
                request.setAttribute("error", "Failed to reset password!");
            }
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
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
