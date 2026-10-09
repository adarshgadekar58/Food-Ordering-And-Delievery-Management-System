package com.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.model.CartItem;
import com.model.FoodItem;
import com.model.User;
import com.repository.CartItemRepository;
import com.repository.FoodItemRepository;
import com.repository.UserRepository;

@Service
@Transactional
public class CartService {

    private static final int MAX_QUANTITY = 50;

    private final CartItemRepository cartItemRepository;
    private final FoodItemRepository foodItemRepository;
    private final UserRepository userRepository;

    public CartService(CartItemRepository cartItemRepository,
                       FoodItemRepository foodItemRepository,
                       UserRepository userRepository) {
        this.cartItemRepository = cartItemRepository;
        this.foodItemRepository = foodItemRepository;
        this.userRepository = userRepository;
    }

    public void addToCart(Long userId, Long foodItemId) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        FoodItem foodItem = foodItemRepository.findById(foodItemId)
                .orElseThrow(() -> new IllegalArgumentException("Food item not found"));

        if (!foodItem.isAvailable()) {
            throw new IllegalArgumentException(
                    "\"" + foodItem.getName() + "\" is currently unavailable");
        }

        cartItemRepository.findByUserIdAndFoodItemId(userId, foodItemId)
                .ifPresentOrElse(
                        existing -> {
                            if (existing.getQuantity() < MAX_QUANTITY) {
                                existing.setQuantity(existing.getQuantity() + 1);
                            }
                        },
                        () -> {
                            CartItem item = new CartItem();
                            item.setUser(user);
                            item.setFoodItem(foodItem);
                            item.setQuantity(1);
                            cartItemRepository.save(item);
                        });
    }

    @Transactional(readOnly = true)
    public List<CartItem> getCartItems(Long userId) {
        return cartItemRepository.findByUserIdWithDetails(userId);
    }

    // The three methods below only touch a row that belongs to userId.

    public void increaseQuantity(Long userId, Long cartItemId) {
        cartItemRepository.findByIdAndUserId(cartItemId, userId)
                .ifPresent(item -> {
                    if (item.getQuantity() < MAX_QUANTITY) {
                        item.setQuantity(item.getQuantity() + 1);
                    }
                });
    }

    public void decreaseQuantity(Long userId, Long cartItemId) {
        cartItemRepository.findByIdAndUserId(cartItemId, userId)
                .ifPresent(item -> {
                    if (item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                    } else {
                        cartItemRepository.delete(item);
                    }
                });
    }

    public void removeItem(Long userId, Long cartItemId) {
        cartItemRepository.findByIdAndUserId(cartItemId, userId)
                .ifPresent(cartItemRepository::delete);
    }

    /** Totals an already-loaded cart (one query per page, not two). */
    @Transactional(readOnly = true)
    public BigDecimal calculateTotal(List<CartItem> cartItems) {

        BigDecimal total = BigDecimal.ZERO;

        for (CartItem item : cartItems) {
            total = total.add(item.getFoodItem().getPrice()
                    .multiply(BigDecimal.valueOf(item.getQuantity())));
        }

        return total.setScale(2, RoundingMode.HALF_UP);
    }
}
