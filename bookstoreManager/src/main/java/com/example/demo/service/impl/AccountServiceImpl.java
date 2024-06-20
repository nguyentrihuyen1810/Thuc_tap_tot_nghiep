package com.example.demo.service.impl;

import com.example.demo.dto.AccountDTO;
import com.example.demo.model.account.Account;
import com.example.demo.repository.AccountRepository;
import com.example.demo.repository.RoleRepository;
import com.example.demo.service.AccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;

@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {
    private final AccountRepository accountRepository;
    private final RoleRepository roleRepository;

    @Override
    public Account save(AccountDTO accountDTO) {
        Account account = new Account();
        account.setFullName(accountDTO.getFullName());
        account.setUsername(accountDTO.getUsername());
        account.setPassword(accountDTO.getPassword());
        account.setPhoneNumber(accountDTO.getPhoneNumber());
        account.setImage(account.getImage());
        account.setAddress(accountDTO.getAddress());
        account.setEmail(accountDTO.getEmail());
        account.setRoles(new HashSet<>(Arrays.asList(roleRepository.findByName("ROLE_USER"))));
        return accountRepository.save(account);
    }

    @Override
    public Account findByUsername(String username) {
        return accountRepository.findByUsername(username);
    }

    @Override
    public Account saveInfo(Account account) {
        Account account1 = accountRepository.findByUsername(account.getUsername());
        account1.setUsername(account.getUsername());
        account1.setFullName(account.getFullName());
        account1.setAddress(account.getAddress());
        account1.setEmail(account.getEmail());
        account1.setPhoneNumber(account.getPhoneNumber());
        return accountRepository.save(account1);
    }
}
