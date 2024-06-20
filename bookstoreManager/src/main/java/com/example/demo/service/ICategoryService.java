package com.example.demo.service;


import com.example.demo.model.book.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface ICategoryService {
    List<Category> findAll();

    Page<Category> findAll(Pageable pageable);

    Page<Category> findByAll(Pageable pageable, String categoryNameSearch);

    void save(Category category);

    Optional<Category> findById(Long bookId);

    void delete (Long categoryId);
}
