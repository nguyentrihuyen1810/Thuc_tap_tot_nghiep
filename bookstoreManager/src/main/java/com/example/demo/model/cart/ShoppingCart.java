package com.example.demo.model.cart;

import com.example.demo.model.account.Account;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "shopping_cart")
public class ShoppingCart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "shopping_cart_id")
    private Long id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "account_id", referencedColumnName = "account_id")
    private Account account;

    @Column(name = "total_price")
    private double totalPrice;

    private int totalItems;

    @OneToMany(cascade = CascadeType.DETACH, mappedBy = "cart", fetch = FetchType.EAGER)
    private Set<CartItem> cartItem;

    public ShoppingCart() {
        this.totalPrice = 0.0;
        this.totalItems = 0;
        this.cartItem = new HashSet<>();
    }

    public ShoppingCart(Long id, Account account, double totalPrice, int totalItems, Set<CartItem> cartItem) {
        this.id = id;
        this.account = account;
        this.totalPrice = totalPrice;
        this.totalItems = totalItems;
        this.cartItem = cartItem;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }

    public Set<CartItem> getCartItem() {
        return cartItem;
    }

    public void setCartItem(Set<CartItem> cartItem) {
        this.cartItem = cartItem;
    }

    public void updateTotalPrice() {
        double total = 0;
        for (CartItem item : this.cartItem) {
            total += item.getBook().getBookPrice() * item.getQuantity();
        }
        this.totalPrice = total;
    }

    @Override
    public String toString() {
        return "ShoppingCart{" +
                "id=" + id +
                ", account=" + account.getUsername() +
                ", totalPrice=" + totalPrice +
                ", totalItems=" + totalItems +
                ", cartItem=" + cartItem.size() +
                '}';
    }
}
