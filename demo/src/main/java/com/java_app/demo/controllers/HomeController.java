package com.java_app.demo.controllers;

import com.java_app.demo.entity.HitCounter;
import com.java_app.demo.repository.HitCounterRepository;
import com.java_app.demo.services.IpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Optional;

@RestController
@RequestMapping("/home")
public class HomeController {

    @Autowired
    private HitCounterRepository hitCounterRepository;

    @Autowired
    private IpService ipService; // Inject the service

    @GetMapping
    public String home() {
        return "Welcome to Home!";
    }

    @GetMapping("/count")
    public ResponseEntity<String> getHitCount() {

        String privateIp = ipService.getPrivateIp();

        // Fetch the counter from the database using private IP
        Optional<HitCounter> optionalCounter = hitCounterRepository.findById(privateIp);
        HitCounter counter;

        if (optionalCounter.isPresent()) {
            // If the counter exists, increment it
            counter = optionalCounter.get();
            counter.setHitCount(counter.getHitCount() + 1);
        } else {
            // If the counter doesn't exist, create it
            counter = new HitCounter(privateIp, 1L);
        }

        // Save the updated counter back to the database
        hitCounterRepository.save(counter);

        return ResponseEntity.ok("Instance " + privateIp + " has been hit " + counter.getHitCount() + " times.");
    }
}
