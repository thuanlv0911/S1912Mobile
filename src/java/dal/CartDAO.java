/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.Categories;
import models.Item;
import models.Products;

/**
 *
 * @author LE VAN THUAN
 */
public class CartDAO extends DBContext {

    public List<Item> getAllItems() {
        List<Item> listItems = new ArrayList<>();
        String sql = "select * from item";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Item i = new Item();
                i.setItemID(rs.getInt("itemID"));

            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listItems;
    }

    public List<Item> getCartItems(int accID) {
        List<Item> ListItems = new ArrayList<>();
        String sql = "select i.itemID, i.cartID, i.prodID, i.quantity, p.price, p.image, p.prodName, p.describe, p.create_At, p.cateID from Item i join Products p on i.prodID = p.prodID join Cart c on i.cartID = c.cartID where c.accID = ? and p.isDeleted = 0";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Item item = new Item();
                item.setItemID(rs.getInt("itemID"));
                item.setCartID(rs.getInt("cartID"));
                item.setProID(rs.getString("prodID"));
                item.setQuantity(rs.getInt("quantity"));

                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));
                DAO d = new DAO();
                Categories c = d.getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);

                item.setProduct(p);

                ListItems.add(item);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return ListItems;
    }

    public void updateItemQuantity(int itemID, int quantity) {
        String sql = "update Item set quantity = ? where itemID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, itemID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void deleteItem(int itemID) {
        String sql = "delete from Item where itemID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, itemID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public int getCartIDByAccID(int accID) {
        String sql = "select cartID from Cart where accID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cartID");
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return -1;
    }

    public int createCartForUser(int accID) {
        String sql = "insert into Cart (accID) values (?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accID);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return -1;
    }

    public Item getItemByCartAndProduct(int cartID, String prodID) {
        String sql = "select * from Item where cartID = ? and prodID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartID);
            ps.setString(2, prodID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Item item = new Item();
                item.setItemID(rs.getInt("itemID"));
                item.setCartID(rs.getInt("cartID"));
                item.setProID(rs.getString("prodID"));
                item.setQuantity(rs.getInt("quantity"));
                return item;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    public void addItemToCart(int cartID, String prodID, int quantity) {
        String sql = "insert into Item (cartID, prodID, quantity) values (?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartID);
            ps.setString(2, prodID);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public Item getItemById(int itemID) {
        String sql = "select i.itemID, i.cartID, i.prodID, i.quantity, p.price, p.image, p.prodName, p.describe, p.create_At, p.quantity as stockQuantity, p.cateID "
                + "from Item i join Products p on i.prodID = p.prodID where i.itemID = ? and p.isDeleted = 0";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, itemID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Item item = new Item();
                item.setItemID(rs.getInt("itemID"));
                item.setCartID(rs.getInt("cartID"));
                item.setProID(rs.getString("prodID"));
                item.setQuantity(rs.getInt("quantity"));

                // Tạo đối tượng sản phẩm
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("stockQuantity")); // Số lượng tồn kho
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));

                DAO d = new DAO();
                Categories c = d.getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);

                item.setProduct(p);
                return item;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

}
