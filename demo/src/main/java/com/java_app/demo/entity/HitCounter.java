package com.java_app.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class HitCounter {
    
    @Id
    private Long id;
    private Long count;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }
}
