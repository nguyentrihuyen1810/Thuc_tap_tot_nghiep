package com.example.demo.repository;

import com.example.demo.model.cart.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    @Query("SELECT o FROM Order o JOIN FETCH o.orderDetailList WHERE o.id = :id")
    Order findOrderWithDetails(@Param("id") Long id);

    @Query(value="SELECT book_code, book_name, SUM(orders.quantity) as total " +
            "FROM orders " +
            "join order_detail on order_detail.order_id = orders.order_id " +
            "join book on book.book_id = order_detail.book_id " +
            "WHERE DATE(order_date) BETWEEN :startDate AND :endDate " +
            "GROUP BY book_code, book_name",
            countQuery ="SELECT book_code, book_name, SUM(order_detail.quantity) " +
                    "FROM orders " +
                    "JOIN order_detail on order_detail.order_id = orders.order_id " +
                    "JOIN book on book.book_id = order_detail.book_id " +
                    "WHERE DATE(order_date) BETWEEN :startDate AND :endDate " +
                    "GROUP BY book_code, book_name", nativeQuery =true)
    Page<Order> search(@Param("startDate")String startDate, @Param("endDate")String endDate, Pageable pageable);
}
