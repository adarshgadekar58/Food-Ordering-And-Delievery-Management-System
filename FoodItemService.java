package com.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Exception.ResourceNotFoundException;
import com.model.FoodItem;
import com.model.FoodStatus;
import com.model.Restaurant;
import com.repository.CartItemRepository;
import com.repository.FoodItemRepository;
import com.repository.RestaurantRepository;

@Service
public class FoodItemService {

    private final FoodItemRepository foodItemRepository;
    private final RestaurantRepository restaurantRepository;
    private final CartItemRepository cartItemRepository;

    public FoodItemService(FoodItemRepository foodItemRepository,
                           RestaurantRepository restaurantRepository,
                           CartItemRepository cartItemRepository) {
        this.foodItemRepository = foodItemRepository;
        this.restaurantRepository = restaurantRepository;
        this.cartItemRepository = cartItemRepository;
    }

    @Transactional
    public FoodItem addFoodItem(FoodItem foodItem, Long restaurantId) {

        Restaurant restaurant = restaurantRepository.findById(restaurantId)
                .orElseThrow(() -> new ResourceNotFoundException("Restaurant not found"));

        foodItem.setId(null); // never overwrite an existing item from a form post
        foodItem.setRestaurant(restaurant);

        if (foodItem.getStatus() == null) {
            foodItem.setStatus(FoodStatus.AVAILABLE);
        }

        return foodItemRepository.save(foodItem);
    }

    @Transactional(readOnly = true)
    public List<FoodItem> getAllFoodItems() {
        return foodItemRepository.findAllWithRestaurant();
    }

    @Transactional(readOnly = true)
    public List<FoodItem> getFoodItemsByRestaurant(Long restaurantId) {
        return foodItemRepository.findByRestaurantIdOrderByNameAsc(restaurantId);
    }

    /** Throws ResourceNotFoundException (404 page) when the item doesn't exist. */
    @Transactional(readOnly = true)
    public FoodItem getFoodItemById(Long id) {
        return foodItemRepository.findWithRestaurantById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Food item not found"));
    }

    /** Deletes the item (and removes it from carts). Returns its restaurant id. */
    @Transactional
    public Long deleteFoodItem(Long id) {

        FoodItem item = foodItemRepository.findWithRestaurantById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Food item not found"));

        Long restaurantId = item.getRestaurant().getId();

        cartItemRepository.deleteByFoodItemId(id);
        foodItemRepository.delete(item);

        return restaurantId;
    }
}
