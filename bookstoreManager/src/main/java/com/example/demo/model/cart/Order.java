package com.example.demo.model.cart;

import com.example.demo.model.account.Account;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Entity
@Table (name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long id;

    private Date orderDate;

    private Date deliveryDate;
    private String orderStatus;
    private double totalPrice;
    private int quantity;
    private String paymentMethod;
    private boolean isAccept;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "account_id", referencedColumnName = "account_id")
    private Account account;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "order")
    private List<OrderDetail> orderDetailList;


    public Order() {
    }

    public Order(Long id, Date orderDate, Date deliveryDate, String orderStatus, double totalPrice, int quantity, String paymentMethod, boolean isAccept, Account account, List<OrderDetail> orderDetailList) {
        this.id = id;
        this.orderDate = orderDate;
        this.deliveryDate = deliveryDate;
        this.orderStatus = orderStatus;
        this.totalPrice = totalPrice;
        this.quantity = quantity;
        this.paymentMethod = paymentMethod;
        this.isAccept = isAccept;
        this.account = account;
        this.orderDetailList = orderDetailList;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getDeliveryDate() {return deliveryDate;}

    public void setDeliveryDate(Date deliveryDate) {this.deliveryDate = deliveryDate;}

    public String getOrderStatus() {return orderStatus;}

    public void setOrderStatus(String orderStatus) {this.orderStatus = orderStatus;}

    public Account getAccount() {return account;}

    public void setAccount(Account account) {this.account = account;}

    public double getTotalPrice() {return totalPrice;}

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {this.paymentMethod = paymentMethod;}

    public boolean isAccept() {
        return isAccept;
    }

    public void setAccept(boolean accept) {isAccept = accept;}

    public Account getCustomer() {
        return account;
    }

    public void setCustomer(Account account) {
        this.account = account;
    }

    public List<OrderDetail> getOrderDetailList() {
        return orderDetailList;
    }

    public void setOrderDetailList(List<OrderDetail> orderDetailList) {
        this.orderDetailList = orderDetailList;
    }
}
