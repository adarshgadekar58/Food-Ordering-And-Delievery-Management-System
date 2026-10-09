package com.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.model.CartItem;
import com.service.CartService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    private Long currentUserId(HttpSession session) {
        return (Long) session.getAttribute("userId");
    }

    @GetMapping
    public String viewCart(HttpSession session, Model model) {

        Long userId = currentUserId(session);
        if (userId == null) {
            return "redirect:/login";
        }

        List<CartItem> cartItems = cartService.getCartItems(userId);

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("total", cartService.calculateTotal(cartItems));

        return "cart";
    }

    // All cart changes are POST + CSRF token, and are scoped to the logged-in user.

    @PostMapping("/add/{foodItemId}")
    public String addToCart(@PathVariable Long foodItemId, HttpSession session,
                            RedirectAttributes redirect) {

        Long userId = currentUserId(session);
        if (userId == null) {
            return "redirect:/login";
        }

        try {
            cartService.addToCart(userId, foodItemId);
        } catch (IllegalArgumentException e) {
            redirect.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/cart";
    }

    @PostMapping("/increase/{id}")
    public String increase(@PathVariable Long id, HttpSession session) {

        Long userId = currentUserId(session);
        if (userId == null) {
            return "redirect:/login";
        }

        cartService.increaseQuantity(userId, id);
        return "redirect:/cart";
    }

    @PostMapping("/decrease/{id}")
    public String decrease(@PathVariable Long id, HttpSession session) {

        Long userId = currentUserId(session);
        if (userId == null) {
            return "redirect:/login";
        }

        cartService.decreaseQuantity(userId, id);
        return "redirect:/cart";
    }

    @PostMapping("/remove/{id}")
    public String remove(@PathVariable Long id, HttpSession session) {

        Long userId = currentUserId(session);
        if (userId == null) {
            return "redirect:/login";
        }

        cartService.removeItem(userId, id);
        return "redirect:/cart";
    }
}
