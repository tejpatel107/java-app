package com.java_app.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.java_app.demo.entity.HitCounter;

@Repository
public interface HitCounterRepository extends JpaRepository<HitCounter, Long> {
}