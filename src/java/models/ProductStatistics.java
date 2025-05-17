/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author LE VAN THUAN
 */
public class ProductStatistics {
    private String prodID;
    private String prodName;
    private int totalSold;
    private int quantity;
    private String status;

    public ProductStatistics() {
    }

    public ProductStatistics(String prodID, String prodName, int totalSold, int quantity) {
        this.prodID = prodID;
        this.prodName = prodName;
        this.totalSold = totalSold;
        this.quantity = quantity;
    }

    public String getProdID() {
        return prodID;
    }

    public void setProdID(String prodID) {
        this.prodID = prodID;
    }

    public String getProdName() {
        return prodName;
    }

    public void setProdName(String prodName) {
        this.prodName = prodName;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
