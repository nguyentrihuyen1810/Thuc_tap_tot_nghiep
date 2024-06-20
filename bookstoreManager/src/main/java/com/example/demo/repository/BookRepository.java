package com.example.demo.repository;

import com.example.demo.model.book.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface BookRepository extends JpaRepository<Book, Long> {
    @Query(value="select * from book where book_name like :bookNameSearch and book_category_id like :bookCategoryIdSearch",
            countQuery ="select * from book where book_name like :bookNameSearch and book_category_id like :bookCategoryIdSearch",nativeQuery =true)
    Page<Book> search(@Param("bookNameSearch")String bookNameSearch, @Param("bookCategoryIdSearch")String bookCategoryIdSearch , Pageable pageable);

    Book findByBookCode(String bookCode);
}