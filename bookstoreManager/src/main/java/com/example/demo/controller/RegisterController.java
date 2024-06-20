package com.example.demo.controller;

import com.example.demo.dto.AccountDTO;
import com.example.demo.model.account.Account;
import com.example.demo.service.AccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class RegisterController {
    private final AccountService accountService;

    private final BCryptPasswordEncoder passwordEncoder;

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("title", "Register");
        model.addAttribute("page", "Register");
        model.addAttribute("accountDTO", new AccountDTO());
        return "user/register";
    }

    @PostMapping("/do-register")
    public String registerAccount(@Valid @ModelAttribute("accountDTO") AccountDTO accountDTO,
                                   BindingResult result,
                                   Model model) {
        try {
            if (result.hasErrors()) {
                model.addAttribute("accountDTO", accountDTO);
                return "user/register";
            }
            String username = accountDTO.getUsername();
            Account account = accountService.findByUsername(username);
            if (account != null) {
                model.addAttribute("accountDTO", accountDTO);
                model.addAttribute("error", "Email đã được đăng ký");
                return "user/register";
            }
            if (accountDTO.getPassword().equals(accountDTO.getRepeatPassword())) {
                accountDTO.setPassword(passwordEncoder.encode(accountDTO.getPassword()));
                accountService.save(accountDTO);
                model.addAttribute("success", "Đăng ký thành công!");
            } else {
                model.addAttribute("error", "Mật khẩu không đúng");
                model.addAttribute("accountDTO", accountDTO);
                return "user/register";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Hệ thống đang lỗi, vui lòng thử lại sau");
        }
        return "user/register";
    }
}
