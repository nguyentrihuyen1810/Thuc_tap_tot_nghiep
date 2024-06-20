package com.example.demo.service.impl;

import com.example.demo.model.account.Account;
import com.example.demo.model.book.Book;
import com.example.demo.model.cart.CartItem;
import com.example.demo.model.cart.ShoppingCart;
import com.example.demo.repository.CartItemRepository;
import com.example.demo.repository.ShoppingCartRepository;
import com.example.demo.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {
    @Autowired
    private CartItemRepository itemRepository;

    @Autowired
    private ShoppingCartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @Override
    public ShoppingCart addItemToCart(Book book, int quantity, Account account) {
        ShoppingCart cart = account.getShoppingCart();
        if(cart == null) {
            cart = new ShoppingCart();
        }
        Set<CartItem> cartItems = cart.getCartItem();
        CartItem cartItem = findCartItem(cartItems, book.getBookId());

        double unitPrice = book.getBookPrice();
        int itemQuantity = 0;

        if (cartItems == null) {
            cartItems = new HashSet<>();
            if(cartItem == null) {
                cartItem = new CartItem();
                cartItem.setBook(book);
//                cartItem.setTotalPrice(quantity * book.getBookPrice());
                cartItem.setTotalPrice(unitPrice);
                cartItem.setQuantity(quantity);
                cartItem.setCart(cart);
                cartItems.add(cartItem);
                itemRepository.save(cartItem);
            } else {
                itemQuantity = cartItem.getQuantity() + quantity;
                cartItem.setQuantity(itemQuantity);
                itemRepository.save(cartItem);
            }
        } else {
            if (cartItem == null) {
                cartItem = new CartItem();
                cartItem.setBook(book);
                cartItem.setTotalPrice(unitPrice);
                cartItem.setQuantity(quantity);
                cartItem.setCart(cart);
                cartItems.add(cartItem);
                itemRepository.save(cartItem);
            } else {
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                cartItem.setTotalPrice(cartItem.getTotalPrice() + (quantity * book.getBookPrice()));
                itemRepository.save(cartItem);
            }
        }
        cart.setCartItem(cartItems);

        int totalItems = totalItems(cart.getCartItem());
        double totalPrice = totalPrice(cart.getCartItem());

        cart.setTotalPrice(totalPrice);
        cart.setTotalItems(totalItems);
        cart.setAccount(account);

        return cartRepository.save(cart);
    }

    @Override
    public ShoppingCart updateItemCart(Book book, int quantity, Account account) {
        ShoppingCart cart = account.getShoppingCart();
        Set<CartItem> cartItems = cart.getCartItem();
        CartItem item = findCartItem(cartItems, book.getBookId());
        item.setQuantity(quantity);
        item.setTotalPrice(quantity * book.getBookPrice());
        itemRepository.save(item);
        int totalItems = totalItems(cartItems);
        double totalPrice = totalPrice(cartItems);

        cart.setTotalItems(totalItems);
        cart.setTotalPrice(totalPrice);
        return cartRepository.save(cart);
    }

    @Override
    public ShoppingCart deleteItemFromCart(Book book, Account account) {
        ShoppingCart cart = account.getShoppingCart();
        Set<CartItem> cartItems = cart.getCartItem();
        CartItem item = findCartItem(cartItems, book.getBookId());
        cartItems.remove(item);
        itemRepository.delete(item);

        double totalPrice = totalPrice(cartItems);
        int totalItems = totalItems(cartItems);

        cart.setCartItem(cartItems);
        cart.setTotalItems(totalItems);
        cart.setTotalPrice(totalPrice);

        return cartRepository.save(cart);
    }

    private CartItem findCartItem(Set<CartItem> cartItems, Long bookId) {
        if(cartItems == null) {
            return null;
        }
        CartItem cartItem = null;
        for(CartItem item : cartItems) {
            if(item.getBook().getBookId() == bookId) {
                cartItem = item;
            }
        }
        return cartItem;
    }

    private int totalItems(Set<CartItem> cartItems) {
        int totalItems = 0;
        for(CartItem item : cartItems) {
            totalItems += item.getQuantity();
        }
        return totalItems;
    }

    private double totalPrice(Set<CartItem> cartItems) {
        double totalPrice = 0.0;
        for(CartItem item : cartItems) {
            totalPrice += item.getTotalPrice();
        }
        return totalPrice;
    }
}
