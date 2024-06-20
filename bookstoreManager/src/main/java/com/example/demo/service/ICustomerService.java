package com.example.demo.service;

import com.example.demo.model.account.Account;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface ICustomerService {
    List<Account> findAll();

    Page<Account> findAll(Pageable pageable);

    Page<Account> findByAll(Pageable pageable, String customerNameSearch);

    void save(Account customer);


    Optional<Account> findById(Long id);

    Optional<Account> findByAccountId(Long id);

    void delete (Long id);
}
