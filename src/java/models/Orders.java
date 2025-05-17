/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;

/**
 *
 * @author LE VAN THUAN
 */
public class Orders {
    private int orderID;
    private int accID;
    private String address;   
    private String phoneNumber;  
    private String email;  
    private Date create_At;
    private double totalAmount;
    private String status;
    private boolean isReceived;

    public Orders() {
    }

    public Orders(int orderID, int accID, String address, String phoneNumber, String email, Date create_At, double totalAmount, String status, boolean isReceived) {
        this.orderID = orderID;
        this.accID = accID;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.create_At = create_At;
        this.totalAmount = totalAmount;
        this.status = status;
        this.isReceived = isReceived;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getAccID() {
        return accID;
    }

    public void setAccID(int accID) {
        this.accID = accID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreate_At() {
        return create_At;
    }

    public void setCreate_At(Date create_At) {
        this.create_At = create_At;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isIsReceived() {
        return isReceived;
    }

    public void setIsReceived(boolean isReceived) {
        this.isReceived = isReceived;
    }

    
}
