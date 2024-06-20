package com.example.demo.service.impl;

import com.example.demo.model.book.Promotion;
import com.example.demo.repository.PromotionRepository;
import com.example.demo.service.IPromotionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PromotionServiceImpl implements IPromotionService {
    @Autowired
    private PromotionRepository promotionRepository;

    @Override
    public List<Promotion> findAll() {
        return promotionRepository.findAll();
    }
}
