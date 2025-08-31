package com.java_app.demo.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/home")
public class HomeController {

    @GetMapping("/count")
    public ResponseEntity<String> countVisit() {
        return ResponseEntity.ok("You visited this page : " );
    }
}
