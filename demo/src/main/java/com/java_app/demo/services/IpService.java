package com.java_app.demo.services;

import org.springframework.stereotype.Service;
import java.net.InetAddress;
import java.net.UnknownHostException;

@Service
public class IpService {

    public String getPrivateIp() {
        try {
            return InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            e.printStackTrace();
            return "unknown-ip";
        }
    }
}
