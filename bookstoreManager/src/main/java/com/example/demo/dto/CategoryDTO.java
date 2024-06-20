package com.example.demo.dto;


import javax.validation.constraints.Pattern;

public class CategoryDTO {
    private Long categoryId;

    @Pattern(regexp = "[a-zA-Z0-9\\s]{3,60}", message = "Tên chứa kí tự khác hoặc quá dài")
    private String categoryName;

    public CategoryDTO() {
    }

    public CategoryDTO(Long categoryId, String categoryName) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}