package com.example.demo.controller;

import com.example.demo.model.account.Account;
import com.example.demo.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
public class MyAccountController {
    @Autowired
    private AccountService accountService;

    @GetMapping("/account")
    public String accountHome(Model model, Principal principal) {
        if(principal == null) {
            return "redirect:/login";
        }
        String username = principal.getName();
        Account account = accountService.findByUsername(username);
        model.addAttribute("account", account);
        return "myAccountInfo";
    }

    @RequestMapping(value = "/update-info", method = {RequestMethod.GET, RequestMethod.PUT})
    public String updateAccount(@ModelAttribute("account") Account account, Principal principal,
                                RedirectAttributes redirectAttributes) {
        if(principal == null) {
            return "redirect:/login";
        }
        Account accountSaved = accountService.saveInfo(account);
        redirectAttributes.addFlashAttribute("account", accountSaved);
        redirectAttributes.addFlashAttribute("mess", "Cập nhật thành công");
        return "redirect:/account";
    }
}
