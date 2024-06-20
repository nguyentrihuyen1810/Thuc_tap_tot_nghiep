package com.example.demo.controller;

import com.example.demo.model.account.Account;
import com.example.demo.model.book.Book;
import com.example.demo.model.cart.ShoppingCart;
import com.example.demo.service.AccountService;
import com.example.demo.service.IBookService;
import com.example.demo.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.Principal;

@Controller
public class CartController {
    @Autowired
    private AccountService accountService;

    @Autowired
    private ShoppingCartService cartService;

    @Autowired
    private IBookService bookService;

    @GetMapping("/cart")
    public String cart(Model model, Principal principal, HttpSession session) {
        if(principal == null) {
            return "redirect:/login";
        }
        String username = principal.getName();
        Account account = accountService.findByUsername(username);
        ShoppingCart shoppingCart = account.getShoppingCart();
        if(shoppingCart == null) {
            model.addAttribute("check", "Không có sản phẩm này trong giỏ hàng của bạn");
        }
        if (shoppingCart != null) {
            model.addAttribute("grandTotal", shoppingCart.getTotalPrice());
            shoppingCart.updateTotalPrice();
        }
        model.addAttribute("shoppingCart", shoppingCart);
        return "user/myCart";
    }

    @PostMapping("add-to-cart")
    public String addItemToCart(@RequestParam("id") Long bookId, @RequestParam(value = "quantity", required = false, defaultValue = "1") int quantity,
                                Principal principal, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        Book book = bookService.findById(bookId).orElse(null);
        if(principal == null) {
            return "redirect:/login";
        }
        String username = principal.getName();
        Account account = accountService.findByUsername(username);

        ShoppingCart cart = cartService.addItemToCart(book, quantity, account);
        model.addAttribute("cart", cart);

        redirectAttributes.addFlashAttribute("mess", "Sản phẩm đã được thêm vào giỏ hàng thành công.");

        return "redirect:" + request.getHeader("Referer");
    }

    @RequestMapping(value = "/update-cart", method = RequestMethod.POST, params = "action=update")
    public String updateCart(@RequestParam("quantity") int quantity, @RequestParam("id") Long bookId,
                             Model model, Principal principal) {
        if(principal == null) {
            return "redirect:/login";
        } else {
            String username = principal.getName();
            Account account = accountService.findByUsername(username);
            Book book = bookService.findById(bookId).orElse(null);
            ShoppingCart cart = cartService.updateItemCart(book, quantity, account);
            model.addAttribute("shoppingCart", cart);
            return "redirect:/cart";
        }
    }

    @RequestMapping(value = "/update-cart", method = RequestMethod.POST, params = "action=delete")
    public String deleteItemFromCart(@RequestParam("id") Long bookId, Model model, Principal principal) {
        if(principal == null) {
            return "redirect:/login";
        } else {
            String username = principal.getName();
            Account account = accountService.findByUsername(username);
            Book book = bookService.findById(bookId).orElse(null);
            ShoppingCart cart = cartService.deleteItemFromCart(book, account);
            model.addAttribute("shoppingCart", cart);
            return "redirect:/cart";
        }
    }
}
