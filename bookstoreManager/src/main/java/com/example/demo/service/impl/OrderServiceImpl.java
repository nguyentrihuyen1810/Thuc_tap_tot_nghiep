package com.example.demo.service.impl;

import com.example.demo.model.cart.CartItem;
import com.example.demo.model.cart.Order;
import com.example.demo.model.cart.OrderDetail;
import com.example.demo.model.cart.ShoppingCart;
import com.example.demo.repository.CartItemRepository;
import com.example.demo.repository.OrderDetailRepository;
import com.example.demo.repository.OrderRepository;
import com.example.demo.repository.ShoppingCartRepository;
import com.example.demo.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ShoppingCartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @Override
    public Order save(ShoppingCart cart) {
        Order order = new Order();
        order.setOrderStatus("Chờ xác nhận ...");
        order.setOrderDate(new Date());
        order.setAccount(cart.getAccount());
        order.setTotalPrice(cart.getTotalPrice());
        order.setQuantity(cart.getTotalItems());
        List<OrderDetail> orderDetailList = new ArrayList<>();
        int totalQuantity = 0; // Tổng số lượng của các mặt hàng
        double totalPrice = 0.0; // Tổng giá trị của các mặt hàng
        for(CartItem item : cart.getCartItem()) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setQuantity(item.getQuantity());
            orderDetail.setBook(item.getBook());
            orderDetail.setUnitPrice(item.getBook().getBookPrice());
            orderDetailRepository.save(orderDetail);
            orderDetailList.add(orderDetail);
            totalQuantity += item.getQuantity(); // Cộng dồn số lượng
            totalPrice += item.getBook().getBookPrice() * item.getQuantity(); // Cộng dồn giá trị
            cartItemRepository.delete(item);
        }
        order.setOrderDetailList(orderDetailList);
        order.setQuantity(totalQuantity); // Cập nhật tổng số lượng cho đơn hàng
        order.setTotalPrice(totalPrice); // Cập nhật tổng giá trị cho đơn hàng
        cart.setCartItem(new HashSet<>());
        cartRepository.save(cart);
        return orderRepository.save(order);
    }


    @Override
    public void acceptOrder(Long id) {
        Order order = orderRepository.findById(id).orElse(null);
        order.setDeliveryDate(new Date());
        order.setOrderStatus("Đang giao hàng");
        orderRepository.save(order);
    }

    @Override
    public void cancelOrder(Long id) {
        orderRepository.deleteById(id);
    }

    @Override
    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    @Override
    public Page<Order> findAll(Pageable pageable) {
        return orderRepository.findAll(pageable);
    }

    @Override
    public Page<Order> findByAll(Pageable pageable, String startDate, String endDate) {
        return orderRepository.search(startDate, endDate, pageable);
    }
}
