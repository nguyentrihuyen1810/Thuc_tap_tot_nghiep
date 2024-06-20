package com.example.demo.dto;


import com.example.demo.model.book.Author;
import com.example.demo.model.book.Category;
import com.example.demo.model.book.Promotion;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;

import javax.validation.constraints.*;

public class BookDTO {
    private Long bookId;

    @Pattern(regexp = "^BOOK-[0-9]{3}$", message = "Mã chưa đúng định dạng BOOK-XXX")
    private String bookCode;

    @Pattern(regexp = "[a-zA-Z0-9\\s]{3,60}", message = "Tên chứa kí tự khác hoặc quá dài")
    private String bookName;

    private String bookImage;
    private String bookContent;

    @DecimalMin(value = "0.1", message = "Phải nhập số dương và không bắt đầu bằng số 0")
    private Double bookPrice;

    @NotEmpty(message = "Không được để trống")
    private String bookSize;

    @JsonDeserialize(using = LocalDateDeserializer.class)
    @JsonSerialize(using = LocalDateSerializer.class)
    private String bookPublishDate;

    @Positive(message = "Phải nhập số dương và không bắt đầu bằng số 0")
    private Integer bookQuantity;

    private Category categoryId;

    private Author bookAuthorId;

    private Promotion bookPromotionId;

    public BookDTO() {
    }

    public BookDTO(Long bookId, String bookCode, String bookName, String bookImage, String bookContent, Double bookPrice, String bookSize, String bookPublishDate, Integer bookQuantity, Category categoryId, Author bookAuthorId, Promotion bookPromotionId) {
        this.bookId = bookId;
        this.bookCode = bookCode;
        this.bookName = bookName;
        this.bookImage = bookImage;
        this.bookContent = bookContent;
        this.bookPrice = bookPrice;
        this.bookSize = bookSize;
        this.bookPublishDate = bookPublishDate;
        this.bookQuantity = bookQuantity;
        this.categoryId = categoryId;
        this.bookAuthorId = bookAuthorId;
        this.bookPromotionId = bookPromotionId;
    }

    public Long getBookId() {
        return bookId;
    }

    public void setBookId(Long bookId) {
        this.bookId = bookId;
    }

    public String getBookCode() {
        return bookCode;
    }

    public void setBookCode(String bookCode) {
        this.bookCode = bookCode;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getBookImage() {
        return bookImage;
    }

    public void setBookImage(String bookImage) {
        this.bookImage = bookImage;
    }

    public String getBookContent() {
        return bookContent;
    }

    public void setBookContent(String bookContent) {
        this.bookContent = bookContent;
    }

    public Double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(Double bookPrice) {
        this.bookPrice = bookPrice;
    }

    public String getBookSize() {
        return bookSize;
    }

    public void setBookSize(String bookSize) {
        this.bookSize = bookSize;
    }

    public String getBookPublishDate() {
        return bookPublishDate;
    }

    public void setBookPublishDate(String bookPublishDate) {
        this.bookPublishDate = bookPublishDate;
    }

    public Integer getBookQuantity() {
        return bookQuantity;
    }

    public void setBookQuantity(Integer bookQuantity) {
        this.bookQuantity = bookQuantity;
    }

    public Category getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Category categoryId) {
        this.categoryId = categoryId;
    }

    public Author getBookAuthorId() {
        return bookAuthorId;
    }

    public void setBookAuthorId(Author bookAuthorId) {
        this.bookAuthorId = bookAuthorId;
    }

    public Promotion getBookPromotionId() {
        return bookPromotionId;
    }

    public void setBookPromotionId(Promotion bookPromotionId) {
        this.bookPromotionId = bookPromotionId;
    }
}
