package com.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.model.Role;
import com.model.User;
import com.repository.UserRepository;

/**
 * Creates (or promotes) the first admin from ADMIN_EMAIL / ADMIN_PASSWORD
 * environment variables. Does nothing when ADMIN_EMAIL is not set.
 */
@Component
public class AdminBootstrap implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(AdminBootstrap.class);

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Value("${app.admin.email:}")
    private String adminEmail;

    @Value("${app.admin.password:}")
    private String adminPassword;

    public AdminBootstrap(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {

        if (adminEmail == null || adminEmail.isBlank()) {
            return;
        }

        String email = adminEmail.trim().toLowerCase();
        User user = userRepository.findByEmail(email).orElse(null);

        if (user == null) {
            if (adminPassword == null || adminPassword.length() < 8) {
                log.warn("ADMIN_EMAIL is set but ADMIN_PASSWORD is missing or shorter than 8 characters; admin not created.");
                return;
            }
            user = new User();
            user.setName("Administrator");
            user.setEmail(email);
            user.setPassword(passwordEncoder.encode(adminPassword));
            user.setRole(Role.ADMIN);
            userRepository.save(user);
            log.info("Created admin user {}", email);

        } else if (user.getRole() != Role.ADMIN) {
            user.setRole(Role.ADMIN);
            userRepository.save(user);
            log.info("Promoted {} to ADMIN", email);
        }
    }
}
