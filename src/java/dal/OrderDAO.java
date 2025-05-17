/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import models.Orders;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import models.OrderDetail;

/**
 *
 * @author LE VAN THUAN
 */
public class OrderDAO extends DBContext {

    public List<Orders> getAllOrders() {
        String sql = "select o.*, r.IsReceived from Orders o left join OrderReview r on o.OrderID = r.OrderID";
        List<Orders> listOrders = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Orders o = new Orders();
                o.setOrderID(rs.getInt("OrderID"));
                o.setAccID(rs.getInt("AccID"));
                o.setCreate_At(rs.getDate("Create_At"));
                o.setStatus(rs.getString("Status"));
                o.setTotalAmount(rs.getDouble("TotalAmount"));
                o.setIsReceived(rs.getBoolean("IsReceived"));
                listOrders.add(o);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listOrders;
    }

    public boolean markAsReceived(int orderID) {
        String checkSql = "select * from OrderReview where OrderID = ?";
        String insertSql = "insert into OrderReview (OrderID, IsReceived) values (?, 1)";
        String updateSql = "update OrderReview set IsReceived = 1 where OrderID = ?";

        try {
            PreparedStatement checkPs = connection.prepareStatement(checkSql);
            checkPs.setInt(1, orderID);
            ResultSet rs = checkPs.executeQuery();

            PreparedStatement ps;
            if (rs.next()) {
                // Nếu đã có review, update trạng thái nhận hàng
                ps = connection.prepareStatement(updateSql);
            } else {
                // Nếu chưa có review, thêm mới
                ps = connection.prepareStatement(insertSql);
            }
            ps.setInt(1, orderID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println(e);
            return false;
        }
    }

//    public List<Orders> getAllOrders() {
//        String sql = "select * from orders";
//        List<Orders> listOrders = new ArrayList<>();
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Orders o = new Orders();
//                o.setOrderID(rs.getInt("orderID"));
//                o.setAccID(rs.getInt("accID"));
//                o.setCreate_At(rs.getDate("create_At"));
//                o.setStatus(rs.getString("status"));
//                o.setTotalAmount(rs.getDouble("totalAmount"));
//                listOrders.add(o);
//            }
//        } catch (SQLException e) {
//            System.err.println(e);
//        }
//        return listOrders;
//    }
    public int createOrder(int accID, String address, String phone, String email) {
        String insertSQL = "INSERT INTO Orders (AccID, Address, PhoneNumber, Email, Create_At, TotalAmount, Status) VALUES (?, ?, ?, ?, GETDATE(), 0, 'Pending')";
        String selectSQL = "SELECT TOP 1 OrderID FROM Orders WHERE AccID = ? ORDER BY OrderID DESC";

        try {
            System.out.println("Creating order with values:");
            System.out.println("AccID: " + accID);
            System.out.println("Address: " + address);
            System.out.println("Phone: " + phone);
            System.out.println("Email: " + email);
            PreparedStatement psInsert = connection.prepareStatement(insertSQL);
            psInsert.setInt(1, accID);
            psInsert.setString(2, address);
            psInsert.setString(3, phone);
            psInsert.setString(4, email);
            psInsert.executeUpdate();

            PreparedStatement psSelect = connection.prepareStatement(selectSQL);
            psSelect.setInt(1, accID);
            ResultSet rs = psSelect.executeQuery();

            if (rs.next()) {
                return rs.getInt("OrderID");
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return -1;
    }

    public void addOrderItems(int orderId, int accID) {
        String sql = "insert into OrderDetail (OrderID, ProdID, Quantity, UnitPrice) "
                + "select ?, i.ProdID, i.Quantity, p.Price "
                + "from Item i "
                + "join Products p on i.ProdID = p.ProdID "
                + "join Cart c on i.CartID = c.CartID "
                + "where c.AccID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, accID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void clearCart(int accID) {
        String sql = "delete from Item where CartID = (select CartID from Cart where AccID = ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void updateTotalAmount(int orderId, double totalAmount) {
        String sql = "update Orders set TotalAmount = ? where OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDouble(1, totalAmount);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public List<Orders> getOrdersByAccID(int accID) {
        List<Orders> listOrders = new ArrayList<>();
        String sql = "select * from Orders where AccID = ? order by create_at desc";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders o = new Orders();
                o.setOrderID(rs.getInt("orderID"));
                o.setAccID(rs.getInt("accID"));
                o.setCreate_At(rs.getDate("create_At"));
                o.setStatus(rs.getString("status"));
                o.setTotalAmount(rs.getDouble("totalAmount"));
                listOrders.add(o);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listOrders;
    }

    public Orders getOrderByOrderId(int orderID) {
        String sql = "select * from Orders where OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Orders o = new Orders();
                o.setOrderID(rs.getInt("OrderID"));
                o.setAccID(rs.getInt("AccID"));
                o.setCreate_At(rs.getDate("Create_At"));
                o.setStatus(rs.getString("Status"));
                o.setTotalAmount(rs.getDouble("TotalAmount"));
                o.setAddress(rs.getString("Address"));
                o.setEmail(rs.getString("Email"));
                o.setPhoneNumber(rs.getString("PhoneNumber"));
                return o;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    public boolean updateOrderAddress(Orders order) {
        String sql = "update Orders set email = ?, phoneNumber = ?, address = ? where orderID = ? and status = 'Pending'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order.getEmail());
            ps.setString(2, order.getPhoneNumber());
            ps.setString(3, order.getAddress());
            ps.setInt(4, order.getOrderID());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean isOrderReceived(int orderID) {
        String sql = "select 1 from OrderReview where OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean cancelOrder(int orderID) {
        String sql = "update Orders set Status = 'Canceled' where OrderID = ? and Status = 'Completed'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean updateOrderStatus(int orderID, String status) {
        String sql = "update Orders set status = ? where OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderID);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    /* || ORDER DETAIL */
    public List<OrderDetail> getOrderDetails(int orderID) {
        List<OrderDetail> listOrderDetail = new ArrayList<>();
        String sql = "select od.OrderDetailID, od.OrderID, od.ProdID, p.ProdName, od.Quantity, od.UnitPrice, od.Subtotal from OrderDetail od join Products p on od.ProdID = p.ProdID where od.OrderID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail odt = new OrderDetail();
                odt.setOrderDetailID(rs.getInt("OrderDetailID"));
                odt.setOrderID(rs.getInt("OrderID"));
                odt.setProdID(rs.getString("ProdID"));
                odt.setProdName(rs.getString("ProdName"));
                odt.setQuantity(rs.getInt("Quantity"));
                odt.setUnitPrice(rs.getDouble("UnitPrice"));
                odt.setSubTotal(rs.getDouble("Subtotal"));
                listOrderDetail.add(odt);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listOrderDetail;
    }

}
