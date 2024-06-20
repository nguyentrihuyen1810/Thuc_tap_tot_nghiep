package com.example.demo.service.impl;

import com.example.demo.model.book.Book;
import com.example.demo.repository.BookRepository;
import com.example.demo.service.IBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookServiceImpl implements IBookService {
    @Autowired
    private BookRepository bookRepository;

    @Override
    public List<Book> findAll() {
        return bookRepository.findAll();
    }

    @Override
    public Page<Book> findAll(Pageable pageable) {
        return bookRepository.findAll(pageable);
    }

    @Override
    public Page<Book> findByAll(Pageable pageable, String bookNameSearch, String bookCategoryIdSearch) {
        return bookRepository.search("%" + bookNameSearch + "%", "%" + bookCategoryIdSearch + "%", pageable);
    }

    @Override
    public void save(Book book) {
        bookRepository.save(book);
    }

    @Override
    public Optional<Book> findById(Long bookId) {
        return bookRepository.findById(bookId);
    }

    @Override
    public Book findByBookCode(String bookCode) {
        return bookRepository.findByBookCode(bookCode);
    }

    @Override
    public void delete(Long bookId) {
        bookRepository.deleteById(bookId);
    }

}
