package com.java_app.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

@Entity
public class HitCounter implements Serializable {

    @Id
    @Column(name = "private_ip_address")
    private String privateIpAddress; // This will store the EC2 instance's private IP

    @Column(name = "hit_count")
    private long hitCount;

    // Default constructor for JPA
    public HitCounter() {
    }

    public HitCounter(String privateIpAddress, long hitCount) {
        this.privateIpAddress = privateIpAddress;
        this.hitCount = hitCount;
    }

    public String getPrivateIpAddress() {
        return privateIpAddress;
    }

    public void setPrivateIpAddress(String privateIpAddress) {
        this.privateIpAddress = privateIpAddress;
    }

    public long getHitCount() {
        return hitCount;
    }

    public void setHitCount(long hitCount) {
        this.hitCount = hitCount;
    }

    @Override
    public String toString() {
        return "HitCounter{" +
                "privateIpAddress='" + privateIpAddress + '\'' +
                ", hitCount=" + hitCount +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        HitCounter that = (HitCounter) o;
        return Objects.equals(privateIpAddress, that.privateIpAddress);
    }

    @Override
    public int hashCode() {
        return Objects.hash(privateIpAddress);
    }
}