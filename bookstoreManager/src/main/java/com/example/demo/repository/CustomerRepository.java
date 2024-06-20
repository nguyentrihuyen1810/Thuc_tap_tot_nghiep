package com.example.demo.repository;

import com.example.demo.model.account.Account;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CustomerRepository extends JpaRepository<Account, Long> {
    @Query(value="select * from account where full_name like :customerNameSearch",
            countQuery ="select * from account where full_name like :customerNameSearch",nativeQuery =true)

    Page<Account> search(@Param("customerNameSearch")String customerNameSearch, Pageable pageable);

}
