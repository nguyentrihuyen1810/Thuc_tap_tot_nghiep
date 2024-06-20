package com.example.demo.controller.admin;

import com.example.demo.dto.BookDTO;
import com.example.demo.model.book.Author;
import com.example.demo.model.book.Book;
import com.example.demo.model.book.Category;
import com.example.demo.model.book.Promotion;
import com.example.demo.service.IAuthorService;
import com.example.demo.service.IBookService;
import com.example.demo.service.ICategoryService;
import com.example.demo.service.IPromotionService;
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

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("admin/book")
public class BookController {
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
        if (bookCategoryIdSearch.isPresent()){
            bookNameSearchValue = bookCategoryIdSearch.get();
        }
        model.addAttribute("bookNameSearch", bookNameSearchValue);
        model.addAttribute("bookCategoryIdSearch", bookCategoryIdSearchValue);
        Page<Book> books = iBookService.findByAll(PageRequest.of(page, 15), bookNameSearchValue, bookCategoryIdSearchValue);
        model.addAttribute("books", books);
        return "admin/book/listBook";
    }

    @GetMapping("create")
    public String showCreateBook(Model model) {
        model.addAttribute( "bookDTO", new BookDTO());
        return "admin/book/createBook";
    }

    @PostMapping("save")
    public String save (@ModelAttribute @Validated BookDTO bookDTO, BindingResult bindingResult, Model model) {
        Book book = new Book();
        if (bindingResult.hasErrors()) {
            model.addAttribute("mess", "Thêm mới không thành công");
            return "/admin/book/createBook";
        } else {
            BeanUtils.copyProperties(bookDTO, book);
            iBookService.save(book);
            model.addAttribute("bookDTO", bookDTO);
            model.addAttribute("mess", "Thêm mới thành công");
        }
        return "redirect:/admin/book";
    }

    @GetMapping("edit")
    public String showEditBook(Model model, @RequestParam Long bookId) {
        Book book = iBookService.findById(bookId).orElse(null);
        model.addAttribute("bookDTO", book);
        return "/admin/book/editBook";
    }

    @GetMapping("detail")
    public String showDetailBook(Model model, @RequestParam Long bookId) {
        Book book = iBookService.findById(bookId).orElse(null);
        model.addAttribute("bookDTO", book);
        return "/admin/book/detailBook";
    }

    @GetMapping("delete")
    public String deleteBook(@RequestParam Long idDelete, RedirectAttributes redirectAttributes) {
        iBookService.delete(idDelete);
        redirectAttributes.addFlashAttribute("mess", "Xóa thành công");
        return "redirect:/admin/book";
    }
}

