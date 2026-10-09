package com.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.model.FoodItem;

public interface FoodItemRepository extends JpaRepository<FoodItem, Long> {

    List<FoodItem> findByRestaurantIdOrderByNameAsc(Long restaurantId);

    // restaurant is LAZY, so pages that print food.restaurant.name need a fetch join
    @Query("select f from FoodItem f join fetch f.restaurant order by f.name")
    List<FoodItem> findAllWithRestaurant();

    @Query("select f from FoodItem f join fetch f.restaurant where f.id = :id")
    Optional<FoodItem> findWithRestaurantById(@Param("id") Long id);

    void deleteByRestaurantId(Long restaurantId);
}
