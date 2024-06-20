package com.example.demo.service;

import com.example.demo.model.cart.OrderDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;

public interface OrderDetailService {
    List<OrderDetail> findAll();

    Page<OrderDetail> findAll (Pageable pageable);

    Page<OrderDetail> findByAll(Pageable pageable, Date startDate, Date endDate);
}
