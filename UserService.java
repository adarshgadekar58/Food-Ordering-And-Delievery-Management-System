package com.service;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.model.Role;
import com.model.User;
import com.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public User register(User user) {

        String email = normalize(user.getEmail());

        if (email.isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        if (user.getPassword() == null || user.getPassword().length() < 8) {
            throw new IllegalArgumentException("Password must be at least 8 characters");
        }
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Email already registered");
        }

        user.setId(null);              // a posted form must never overwrite an account
        user.setRole(Role.CUSTOMER);   // self-registration is never an admin
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        try {
            // flush now so a duplicate-email race surfaces inside this try block
            return userRepository.saveAndFlush(user);
        } catch (DataIntegrityViolationException e) {
            throw new IllegalArgumentException("Email already registered");
        }
    }

    /** Returns the user on success, or null on bad credentials. */
    @Transactional(readOnly = true)
    public User login(String email, String password) {

        if (email == null || password == null) {
            return null;
        }

        return userRepository.findByEmail(normalize(email))
                .filter(u -> passwordEncoder.matches(password, u.getPassword()))
                .orElse(null);
    }

    private String normalize(String email) {
        return email == null ? "" : email.trim().toLowerCase();
    }
}
