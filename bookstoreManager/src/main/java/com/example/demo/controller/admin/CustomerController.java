package com.example.demo.controller.admin;

import com.example.demo.dto.AccountDTO;
import com.example.demo.model.account.Account;
import com.example.demo.service.AccountService;
import com.example.demo.service.ICustomerService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("admin/customer")
public class CustomerController {
    @Autowired
    ICustomerService iCustomerService;

    @Autowired
    AccountService accountService;

//    @ModelAttribute("accountList")
//    private List<Account> accountList() {
//        return accountService.findAll();
//    }

    @GetMapping("")
    public String getList(Model model, @RequestParam(defaultValue = "0") int page,
                          Optional<String> customerNameSearch) {
        String customerNameSearchValue = "";
        if (customerNameSearch.isPresent()){
            customerNameSearchValue = customerNameSearch.get();
        }
        model.addAttribute("customerNameSearch", customerNameSearchValue);
        Page<Account> customers = iCustomerService.findByAll(PageRequest.of(page, 15), customerNameSearchValue);
        model.addAttribute("customers", customers);
        return "admin/customer/listCustomer";
    }

    @GetMapping("create")
    public String showCreateCustomer(Model model) {
        model.addAttribute( "customerDTO", new AccountDTO());
        return "admin/customer/createCustomer";
    }

    @PostMapping("save")
    public String save (@ModelAttribute @Validated AccountDTO customerDTO, BindingResult bindingResult, Model model) {
        Account customer = new Account();
        if (bindingResult.hasErrors()) {
            model.addAttribute("mess", "Thêm mới không thành công");
            return "/admin/customer/createCustomer";
        } else {
            BeanUtils.copyProperties(customerDTO, customer);
            iCustomerService.save(customer);
            model.addAttribute("customerDTO", customerDTO);
            model.addAttribute("mess", "Thêm mới thành công");
        }
        return "redirect:/admin/customer";
    }

    @GetMapping("edit")
    public String showEditCustomer(Model model, @RequestParam Long customerId) {
        Account customer = iCustomerService.findById(customerId).orElse(null);
        model.addAttribute("customerDTO", customer);
        return "/admin/customer/editCustomer";
    }

    @GetMapping("detail")
    public String showDetailCustomer(Model model, @RequestParam Long customerId) {
        Account customer = iCustomerService.findById(customerId).orElse(null);
        model.addAttribute("customerDTO", customer);
        return "/admin/customer/detailCustomer";
    }

    @GetMapping("delete")
    public String deleteCustomer(@RequestParam Long idDelete, RedirectAttributes redirectAttributes) {
        iCustomerService.delete(idDelete);
        redirectAttributes.addFlashAttribute("mess", "Xóa thành công");
        return "redirect:/admin/customer";
    }
}
