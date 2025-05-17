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
public class OrderReview {
    private int reviewID;
    private int orderID;
    private int accID;  
    private String username; 
    private boolean isReceived;
    private int rating;
    private String comment;
    private Date create_At;

    public OrderReview() {
    }

    public OrderReview(int reviewID, int orderID, int accID, String username, boolean isReceived, int rating, String comment, Date create_At) {
        this.reviewID = reviewID;
        this.orderID = orderID;
        this.accID = accID;
        this.username = username;
        this.isReceived = isReceived;
        this.rating = rating;
        this.comment = comment;
        this.create_At = create_At;
    }

    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isIsReceived() {
        return isReceived;
    }

    public void setIsReceived(boolean isReceived) {
        this.isReceived = isReceived;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getReviewDate() {
        return create_At;
    }

    public void setReviewDate(Date create_At) {
        this.create_At = create_At;
    }

    
}

