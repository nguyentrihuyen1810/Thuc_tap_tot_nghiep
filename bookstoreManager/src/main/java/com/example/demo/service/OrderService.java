package com.example.demo.service;

import com.example.demo.model.cart.Order;
import com.example.demo.model.cart.ShoppingCart;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface OrderService {
    Order save(ShoppingCart cart);

    void acceptOrder(Long id);

    void cancelOrder(Long id);

    List<Order> findAll();

    Page<Order> findAll (Pageable pageable);

    Page<Order> findByAll(Pageable pageable, String startDate, String endDate);

}
