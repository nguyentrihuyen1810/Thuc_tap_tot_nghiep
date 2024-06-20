package com.example.demo.service;

import com.example.demo.model.book.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface IBookService {
    List<Book> findAll();

    Page<Book> findAll(Pageable pageable);

    Page<Book> findByAll(Pageable pageable, String bookNameSearch, String bookCategoryIdSearch);

    void save(Book book);

    Optional<Book> findById(Long bookId);

    Book findByBookCode(String bookCode);

    void delete (Long bookId);
}
