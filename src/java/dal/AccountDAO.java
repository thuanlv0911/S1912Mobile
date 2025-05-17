/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Account;

/**
 *
 * @author LE VAN THUAN
 */
public class AccountDAO extends DBContext {

    public Account check(String username, String password) {
        String sql = "select * from Account where username = ? and password = ? and isDeleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account au = new Account(rs.getInt("id"), rs.getString("username"), rs.getString("email"), rs.getString("address"), rs.getString("phoneNumber"), rs.getString("password"), rs.getInt("roleID"));
                return au;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    public String register(String username, String email, String address,
            String phoneNumber, String password, int roleID) {
        String sql = "insert into Account (Username, Email, Address, PhoneNumber, Password, RoleID) values (?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, address);
            ps.setString(4, phoneNumber);
            ps.setString(5, password);
            ps.setInt(6, roleID);
            ps.executeUpdate();
            return null;
        } catch (SQLException e) {
            return "Username, Email or PhoneNumber already exists!";
        }
    }

    public List<Account> getAllUser() {
        List<Account> listAcc = new ArrayList<>();
        String sql = "select * from account where isDeleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setEmail(rs.getString("email"));
                a.setAddress(rs.getString("address"));
                a.setPhoneNumber(rs.getString("phoneNumber"));
                a.setPassword(rs.getString("password"));
                a.setRoleID(rs.getInt("roleID"));
                listAcc.add(a);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listAcc;
    }

    public void deleteAccById(int id) {
        String sql = "update account set IsDeleted = 1 where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void updateAddress(Account a) {
        String sql = "update account set email = ?, phoneNumber = ?, address = ? where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, a.getEmail());
            ps.setString(2, a.getPhoneNumber());
            ps.setString(3, a.getAddress());
            ps.setInt(4, a.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public static void main(String[] args) {
        AccountDAO userDAO = new AccountDAO();

        String isRegistered = userDAO.register("user3", "user3@gmail.com", "Danang", "0111111113", "user3pass", 2);

        if (isRegistered == null) {
            System.out.println("Registration successful!");
        } else {
            System.out.println("Registration failed!");
        }

//        AccountDAO accountDAO = new AccountDAO();
//        Account user = accountDAO.getUserByUsername("user1");
//
//        if (user != null) {
//            System.out.println("Tìm thấy user: " + user.getUsername());
//        } else {
//            System.out.println("User không tồn tại!");
//        }
    }

    //CHANGE PASSWORD
    public Account getUserByUsername(String username) {
        String sql = "select * from account where username = ? and isDeleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setEmail(rs.getString("email"));
                a.setAddress(rs.getString("address"));
                a.setPhoneNumber(rs.getString("phoneNumber"));
                a.setPassword(rs.getString("password"));
                a.setRoleID(rs.getInt("roleID"));
                return a;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    public Account getAccountByID(int accID) {
        String sql = "select * from Account where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setEmail(rs.getString("email"));
                a.setAddress(rs.getString("address"));
                a.setPhoneNumber(rs.getString("phoneNumber"));
                a.setPassword(rs.getString("password"));
                a.setRoleID(rs.getInt("roleID"));
                return a;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    public boolean updatePassword(String username, String password) {
        String sql = "update account set password = ? where username = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, password);
            ps.setString(2, username);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    //FORGOT
    public boolean checkEmailExists(String email) {
        String sql = "select * from account where email = ? and isDeleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "update account set password = ? where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }
}
