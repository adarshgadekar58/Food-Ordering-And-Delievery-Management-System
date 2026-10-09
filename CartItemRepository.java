package com.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.model.CartItem;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    Optional<CartItem> findByUserIdAndFoodItemId(Long userId, Long foodItemId);

    // Ownership-scoped lookup: a user can only ever load their own rows
    Optional<CartItem> findByIdAndUserId(Long id, Long userId);

    @Query("select c from CartItem c "
         + "join fetch c.foodItem f "
         + "join fetch f.restaurant "
         + "where c.user.id = :userId order by c.id")
    List<CartItem> findByUserIdWithDetails(@Param("userId") Long userId);

    // Used when a food item or restaurant is deleted, so no FK violations occur
    void deleteByFoodItemId(Long foodItemId);

    void deleteByFoodItemRestaurantId(Long restaurantId);
}
