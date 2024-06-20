package com.example.demo.service.impl;

import com.example.demo.model.account.Account;
import com.example.demo.repository.AccountRepository;
import com.example.demo.repository.CustomerRepository;
import com.example.demo.repository.RoleRepository;
import com.example.demo.service.ICustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerServiceImpl implements ICustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Override
    public List<Account> findAll() {
        return customerRepository.findAll();
    }

    @Override
    public Page<Account> findAll(Pageable pageable) {
        return customerRepository.findAll(pageable);
    }

    @Override
    public Page<Account> findByAll(Pageable pageable, String customerNameSearch) {
        return customerRepository.search("%" + customerNameSearch + "%", pageable);
    }

    @Override
    public void save(Account customer) {
        customerRepository.save(customer);
    }


    @Override
    public Optional<Account> findById(Long customerId) {
        return customerRepository.findById(customerId);
    }

    @Override
    public Optional<Account> findByAccountId(Long customerAccountId) {
        return customerRepository.findById(customerAccountId);
    }

    @Override
    public void delete(Long customerId) {
        customerRepository.deleteById(customerId);
    }
}
