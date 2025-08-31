package com.java_app.demo.services; // or .service

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class DatabaseInitializer {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void resetHitCounterTable() {
        // Drop table if exists
        jdbcTemplate.execute("DROP TABLE IF EXISTS hit_counter");

        // Recreate table
        jdbcTemplate.execute(
                "CREATE TABLE hit_counter (" +
                        "private_ip_address VARCHAR(100) PRIMARY KEY, " +
                        "hit_count BIGINT" +
                        ")"
        );

        System.out.println("hit_counter table dropped and recreated successfully.");
    }
}
