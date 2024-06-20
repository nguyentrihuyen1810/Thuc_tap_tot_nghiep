package com.example.demo.service;


import com.example.demo.model.book.Author;

import java.util.List;

public interface IAuthorService {
    List<Author> findAll();
}
