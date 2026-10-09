package com.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Exception.ResourceNotFoundException;
import com.model.Restaurant;
import com.model.RestaurantStatus;
import com.repository.CartItemRepository;
import com.repository.FoodItemRepository;
import com.repository.RestaurantRepository;

@Service
public class RestaurantService {

    private final RestaurantRepository restaurantRepository;
    private final FoodItemRepository foodItemRepository;
    private final CartItemRepository cartItemRepository;

    public RestaurantService(RestaurantRepository restaurantRepository,
                             FoodItemRepository foodItemRepository,
                             CartItemRepository cartItemRepository) {
        this.restaurantRepository = restaurantRepository;
        this.foodItemRepository = foodItemRepository;
        this.cartItemRepository = cartItemRepository;
    }

    @Transactional
    public Restaurant addRestaurant(Restaurant restaurant) {

        restaurant.setId(null); // never overwrite an existing restaurant from a form post

        if (restaurant.getStatus() == null) {
            restaurant.setStatus(RestaurantStatus.ACTIVE);
        }

        return restaurantRepository.save(restaurant);
    }

    @Transactional(readOnly = true)
    public List<Restaurant> getAllRestaurants() {
        return restaurantRepository.findAll();
    }

    /** Throws ResourceNotFoundException (404 page) when the restaurant doesn't exist. */
    @Transactional(readOnly = true)
    public Restaurant getRestaurantById(Long id) {
        return restaurantRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Restaurant not found"));
    }

    /** Removes the restaurant, its menu, and any cart rows pointing at that menu. */
    @Transactional
    public void deleteRestaurant(Long id) {
        cartItemRepository.deleteByFoodItemRestaurantId(id);
        foodItemRepository.deleteByRestaurantId(id);
        restaurantRepository.deleteById(id);
    }
}
