package com.example.demo.repository;


import com.example.demo.model.book.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    @Query(value="select * from category where category_name like :categoryNameSearch",
            countQuery ="select * from category where category_name like :categoryNameSearch",nativeQuery =true)
    Page<Category> search(@Param("categoryNameSearch")String categoryNameSearch, Pageable pageable);
}
