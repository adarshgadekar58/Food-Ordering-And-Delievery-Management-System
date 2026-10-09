package com.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.model.Restaurant;

public interface RestaurantRepository extends JpaRepository<Restaurant, Long> {

}
