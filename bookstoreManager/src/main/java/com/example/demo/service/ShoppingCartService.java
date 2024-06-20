package com.example.demo.service;

import com.example.demo.model.account.Account;
import com.example.demo.model.book.Book;
import com.example.demo.model.cart.ShoppingCart;

public interface ShoppingCartService {
    ShoppingCart addItemToCart(Book book, int quantity, Account account);

    ShoppingCart updateItemCart(Book book, int quantity, Account account);

    ShoppingCart deleteItemFromCart(Book book, Account account);

}
