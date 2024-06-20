package com.example.demo.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;


import com.example.demo.model.account.AccountRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class RoleDAO {
    @Autowired
    private EntityManager entityManager;

    public List<String> getRoleNames(Long accountId) {
        String sql = "Select ar.role.name from " + AccountRole.class.getName() + " ar " //
                + " where ar.account.id = :accountId ";

        Query query = this.entityManager.createQuery(sql, String.class);
        query.setParameter("accountId", accountId);
        return query.getResultList();
    }

}
