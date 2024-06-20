package com.example.demo.controller;

import com.example.demo.model.account.Account;
import com.example.demo.model.cart.Order;
import com.example.demo.model.cart.ShoppingCart;
import com.example.demo.repository.OrderRepository;
import com.example.demo.service.AccountService;
import com.example.demo.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.security.Principal;
import java.util.List;

@Controller
public class OrderController {
    @Autowired
    private AccountService accountService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping("/check-out")
    public String checkout(Model model, Principal principal) {
        if(principal == null) {
            return "redirect:/login";
        }
        String username = principal.getName();
        Account account = accountService.findByUsername(username);
        if(account.getEmail().trim().isEmpty() || account.getAddress().trim().isEmpty()
            || account.getPhoneNumber().trim().isEmpty() || account.getFullName().trim().isEmpty()) {
            model.addAttribute("account", account);
            return "myAccountInfo";
        } else {
            model.addAttribute("account", account);
            ShoppingCart cart = account.getShoppingCart();
            cart.updateTotalPrice();
            model.addAttribute("cart", cart);
        }
        return "user/checkout";
    }

    @GetMapping("/order")
    public String order(Principal principal, Model model) {
        if(principal == null) {
            return "redirect:/login";
        }
        String username = principal.getName();
        Account account = accountService.findByUsername(username);
        List<Order> orderList = account.getOrders();
        model.addAttribute("orders", orderList);
        return "user/bill";
    }

    @GetMapping("/orders/{id}")
    public String getOrderWithDetails(@PathVariable Long id, Model model, Principal principal) {
        if(principal == null) {
            return "redirect:/login";
        }
        String username = principal.getName();
        Account account = accountService.findByUsername(username);
        Order order = orderRepository.findOrderWithDetails(id);
        ShoppingCart cart = account.getShoppingCart();
//        cart.updateTotalPrice();
        model.addAttribute("order", order);
        model.addAttribute("cart", cart);
        return "user/billDetail";
    }

    @GetMapping("/save-order")
    public String saveOrder(Principal principal) {
        if(principal == null) {
            return "redirect:/login";
        }
        String username = principal.getName();
        Account account = accountService.findByUsername(username);
        ShoppingCart cart = account.getShoppingCart();
        orderService.save(cart);
        return "redirect:/order";
    }
}
