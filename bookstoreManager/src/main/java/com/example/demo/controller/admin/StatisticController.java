package com.example.demo.controller.admin;

import com.example.demo.model.cart.OrderDetail;
import com.example.demo.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.swing.text.html.Option;
import java.time.LocalDate;
import java.util.Date;
import java.util.Optional;

@Controller
@RequestMapping("/admin/statistic")
public class StatisticController {
    @Autowired
    OrderDetailService orderDetailService;

//    @GetMapping("")
//    public String getList(Model model, @RequestParam(defaultValue = "0") int page,
//                          Optional<String> startDate, Optional<String> endDate) {
//        String startDateValue = null;
//        String endDateValue = null;
//
//        if(startDate.isPresent() && !startDate.get().isEmpty()) {
//            startDateValue = startDate.get();
//        }
//        if(endDate.isPresent() && !endDate.get().isEmpty()) {
//            endDateValue = endDate.get();
//        }
//
//        model.addAttribute("startDate", startDateValue);
//        model.addAttribute("endDate", endDateValue);
//
//        Page<OrderDetail> orderDetails;
//        if (startDateValue != null && endDateValue != null) {
//            orderDetails = orderDetailService.findByAll(PageRequest.of(page, 15), startDateValue, endDateValue);
//        } else {
//            orderDetails = orderDetailService.findAll(PageRequest.of(page, 15));
//        }
//
//        model.addAttribute("orderDetails", orderDetails);
//        return "admin/statistic/book";
//    }

    @GetMapping("")
    public String getOrderDetails(
            Model model,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate) {
        Pageable pageable = PageRequest.of(page, 15);
        Page<OrderDetail> orderDetailsPage;

        if (startDate != null && endDate != null) {
            orderDetailsPage = orderDetailService.findByAll(pageable, startDate, endDate);
        } else {
            orderDetailsPage = orderDetailService.findAll(pageable);
        }

        model.addAttribute("orderDetails", orderDetailsPage);
        return "admin/statistic/book";
    }
}