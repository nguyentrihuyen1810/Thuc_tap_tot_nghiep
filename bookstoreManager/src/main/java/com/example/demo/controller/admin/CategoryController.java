package com.example.demo.controller.admin;

import com.example.demo.dto.CategoryDTO;
import com.example.demo.model.book.Category;
import com.example.demo.service.ICategoryService;
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
@RequestMapping("/admin/category")
public class CategoryController {
    @Autowired
    ICategoryService categoryService;

    @ModelAttribute("categoryList")
    private List<Category> categoryList() {
        return categoryService.findAll();
    }

    @GetMapping("")
    public String getList(Model model, @RequestParam(defaultValue = "0") int page,
                          Optional<String> categoryNameSearch) {
        String categoryNameSearchValue = "";
        if(categoryNameSearch.isPresent()) {
            categoryNameSearchValue = categoryNameSearch.get();
        }
        model.addAttribute("categoryNameSearch", categoryNameSearchValue);
        Page<Category> categories = categoryService.findByAll(PageRequest.of(page, 15), categoryNameSearchValue);
        model.addAttribute("categories", categories);
        return "admin/category/listCategory";
    }

    @GetMapping("create")
    public String showCreateCategory(Model model) {
        model.addAttribute("categoryDTO", new CategoryDTO());
        return "admin/category/createCategory";
    }

    @PostMapping("save")
    public String save (@ModelAttribute @Validated CategoryDTO categoryDTO, BindingResult bindingResult, Model model) {
        Category category = new Category();
        if(bindingResult.hasErrors()) {
            model.addAttribute("mess", "Thêm mói thành công");
            return "admin/category/listCategory";
        } else {
            BeanUtils.copyProperties(categoryDTO, category);
            categoryService.save(category);
            model.addAttribute("categoryDTO", categoryDTO);
            model.addAttribute("mess", "Thêm mới không thành công");
        }
        return "redirect:/admin/category";
    }

    @GetMapping("edit")
    public String showEditCategory(Model model, @RequestParam Long categoryId) {
        Category category = categoryService.findById(categoryId).orElse(null);
        model.addAttribute("categoryDTO", category);
        return "/admin/category/editCategory";
    }

    @GetMapping("delete")
    public String deleteCategory(@RequestParam Long idDelete, RedirectAttributes redirectAttributes) {
        categoryService.delete(idDelete);
        redirectAttributes.addFlashAttribute("mess", "Xóa thành công");
        return "redirect:/admin/category";
    }
}