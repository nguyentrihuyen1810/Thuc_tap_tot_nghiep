package com.example.demo.repository;

import com.example.demo.model.cart.OrderDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
//    @Query(value="select order_detail_id, order_detail.book_id, order_detail.order_id, book_code, book_name, sum(order_detail.quantity) as total_quantity from order_detail  " +
//            "join book on book.book_id = order_detail.book_id " +
//            "join orders on orders.order_id = order_detail.order_id " +
//            "where date(order_date) between :startDate and :endDate " +
//            "group by order_detail_id, order_detail.book_id, order_detail.order_id, book_code, book_name",
//            countQuery ="select order_detail_id, order_detail.book_id, order_detail.order_id, book_code, book_name, sum(order_detail.quantity) as total_quantity from order_detail  " +
//                    "join book on book.book_id = order_detail.book_id " +
//                    "join orders on orders.order_id = order_detail.order_id " +
//                    "where date(order_date) between :startDate and :endDate " +
//                    "group by order_detail_id, order_detail.book_id, order_detail.order_id, book_code, book_name", nativeQuery =true)
    @Query(value = "SELECT od.order_detail_id, od.book_id, od.order_id, b.book_code, b.book_name, SUM(od.quantity) " +
            "FROM order_detail od " +
            "JOIN book b ON od.book_id = b.book_id " +
            "JOIN orders o ON od.order_id = o.order_id " +
            "WHERE DATE(o.order_date) BETWEEN :startDate AND :endDate " +
            "GROUP BY od.order_detail_id, od.book_id, od.order_id, b.book_code, b.book_name",
            countQuery = "SELECT od.order_detail_id, od.book_id, od.order_id, b.book_code, b.book_name, SUM(od.quantity) " +
                    "FROM order_detail od " +
                    "JOIN book b ON od.book_id = b.book_id " +
                    "JOIN orders o ON od.order_id = o.order_id " +
                    "WHERE DATE(o.order_date) BETWEEN :startDate AND :endDate",
            nativeQuery = true)
    Page<OrderDetail> search(@Param("startDate") Date startDate, @Param("endDate") Date endDate, Pageable pageable);
}