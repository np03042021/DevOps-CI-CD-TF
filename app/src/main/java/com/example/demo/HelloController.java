package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.Map;

@RestController
public class HelloController {

  @GetMapping("/hello")
  public Map<String, Object> hello() {
    return Map.of(
        "message", "Hello Again from Spring Boot running on Kubernetes/EKS!",
        "timestamp", Instant.now().toString()
    );
  }
}
