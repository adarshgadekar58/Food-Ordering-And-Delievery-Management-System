package com.controller;

import com.model.Role;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model.User;
import com.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    // Mass-assignment guard: a posted form can never set these fields
    @InitBinder("user")
    public void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("id", "role");
    }

    // ========== REGISTRATION ==========

    @GetMapping("/register")
    public String showRegistration(HttpSession session, Model model) {

        if (session.getAttribute("userId") != null) {
            return "redirect:/dashboard";
        }

        model.addAttribute("user", new User());

        return "registration";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("user") User user,
                           BindingResult result, Model model) {

        if (result.hasErrors()) {
            user.setPassword(null); // never send the password back to the page
            model.addAttribute("error", result.getAllErrors().get(0).getDefaultMessage());
            return "registration";
        }

        try {
            userService.register(user);
            return "redirect:/login";

        } catch (IllegalArgumentException e) {
            user.setPassword(null);
            model.addAttribute("error", e.getMessage());
            return "registration";
        }
    }

    // ========== LOGIN ==========

    @GetMapping("/login")
    public String showLogin(HttpSession session) {

        if (session.getAttribute("userId") != null) {
            return "redirect:/dashboard";
        }

        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        HttpServletRequest request, Model model) {

        User user = userService.login(email, password);

        if (user == null) {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }

        HttpSession session = request.getSession(true);
        request.changeSessionId(); // prevents session fixation

        Role role = user.getRole() == null ? Role.CUSTOMER : user.getRole();

        session.setAttribute("userId", user.getId());
        session.setAttribute("userName", user.getName());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("userRole", role.name());

        return "redirect:/dashboard";
    }
}
