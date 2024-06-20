package com.example.demo.service;


import com.example.demo.model.book.Promotion;

import java.util.List;

public interface IPromotionService {
    List<Promotion> findAll();
}
