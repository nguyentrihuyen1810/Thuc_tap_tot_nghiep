package com.example.demo.controller.admin;

import com.example.demo.model.book.Author;
import com.example.demo.model.book.Book;
import com.example.demo.model.book.Category;
import com.example.demo.model.book.Promotion;
import com.example.demo.service.IAuthorService;
import com.example.demo.service.IBookService;
import com.example.demo.service.ICategoryService;
import com.example.demo.service.IPromotionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/manager")
public class PageAdminController {
    @Autowired
    IBookService iBookService;

    @Autowired
    IAuthorService authorService;

    @Autowired
    IPromotionService promotionService;

    @Autowired
    ICategoryService categoryService;

    @ModelAttribute("authorList")
    private List<Author> authorList() {
        return authorService.findAll();
    }

    @ModelAttribute("promotionList")
    private List<Promotion> promotionList() {
        return promotionService.findAll();
    }

    @ModelAttribute("categoryList")
    private List<Category> categoryList() {
        return categoryService.findAll();
    }

    @ModelAttribute("bookList")
    public List<Book> bookList() {
        return iBookService.findAll();
    }

    @GetMapping("")
    public String getList(Model model, @RequestParam(defaultValue = "0") int page,
                          Optional<String> bookNameSearch, Optional<String> bookCategoryIdSearch) {
        String bookNameSearchValue = "";
        String bookCategoryIdSearchValue = "";
        if (bookNameSearch.isPresent()){
            bookNameSearchValue = bookNameSearch.get();
        }
        if (bookCategoryIdSearch.isPresent()) {
            bookCategoryIdSearchValue = bookCategoryIdSearch.get();
        }
        model.addAttribute("bookNameSearch", bookNameSearchValue);
        model.addAttribute("bookCategoryIdSearch", bookCategoryIdSearchValue);
        Page<Book> books = iBookService.findByAll(PageRequest.of(page, 15), bookNameSearchValue, bookCategoryIdSearchValue);
        model.addAttribute("books", books);
        return "welcomePageAdmin";
    }

    @GetMapping("sortByPriceAsc")
    public String getListSortAsc(Model model, @RequestParam(defaultValue = "0") int page,
                                 Optional<String> bookNameSearch, Optional<String> bookCategoryIdSearch) {
        String bookNameSearchValue = "";
        String bookCategoryIdSearchValue = "";
        if(bookNameSearch.isPresent()) {
            bookCategoryIdSearchValue = bookNameSearch.get();
        }
        if(bookCategoryIdSearch.isPresent()) {
            bookCategoryIdSearchValue = bookCategoryIdSearch.get();
        }
        model.addAttribute("bookNameSearch", bookNameSearchValue);
        model.addAttribute("bookCategoryIdSearch", bookCategoryIdSearchValue);
        Page<Book> bookPriceAsc = iBookService.findByAll(PageRequest.of(page, 15, Sort.by(Sort.Direction.ASC, "book_price")), bookNameSearchValue, bookCategoryIdSearchValue);
        model.addAttribute("bookPriceAsc", bookPriceAsc);
        return "user/homeSortPriceAsc";
    }

    @GetMapping("sortByPriceDesc")
    public String getListSortDesc(Model model, @RequestParam(defaultValue = "0") int page,
                                  Optional<String> bookNameSearch, Optional<String> bookCategoryIdSearch) {
        String bookNameSearchValue = "";
        String bookCategoryIdSearchValue = "";
        if(bookNameSearch.isPresent()) {
            bookNameSearchValue = bookNameSearch.get();
        }
        if(bookCategoryIdSearch.isPresent()) {
            bookCategoryIdSearchValue = bookCategoryIdSearch.get();
        }
        model.addAttribute("bookNameSearch", bookNameSearchValue);
        model.addAttribute("bookCategoryIdSearch", bookCategoryIdSearchValue);
        Page<Book> bookPriceDesc = iBookService.findByAll(PageRequest.of(page, 15, Sort.by(Sort.Direction.DESC, "book_price")), bookNameSearchValue, bookCategoryIdSearchValue);
        model.addAttribute("bookPriceDesc", bookPriceDesc);
        return "user/homeSortPriceDesc";
    }
}
