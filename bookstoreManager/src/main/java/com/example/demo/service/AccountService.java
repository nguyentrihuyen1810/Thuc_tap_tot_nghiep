package com.example.demo.service;

import com.example.demo.dto.AccountDTO;
import com.example.demo.model.account.Account;

public interface AccountService {
    Account save(AccountDTO accountDTO);

    Account findByUsername(String username);

    Account saveInfo(Account account);

}
