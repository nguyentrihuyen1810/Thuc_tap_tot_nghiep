package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccountDTO {
    @Size(min = 3, max = 50, message = "Họ tên chứa từ 3 - 50 kí tự")
    private String fullName;
    @Size(min = 3, max = 20, message = "Tên tài khoản chứa từ 3 - 20 kí tự")
    private String username;
    @Size(min = 5, max = 10, message = "Mật khẩu chứa từ 5 - 50 kí tự")
    private String password;

    private String repeatPassword;
    private String address;

    @Email(regexp = "^[A-Za-z0-9+_.-]+@(.+)$", message = "Email không hợp lệ")
    private String email;

    @Pattern(regexp = "^\\d{10,11}$", message = "Số điện thoại phải là số và có 10 - 11 số")
    private String phoneNumber;

    private String image;
}
