package com.controller;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.model.Restaurant;
import com.service.RestaurantService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/restaurants")
public class RestaurantController {

    private final RestaurantService restaurantService;

    public RestaurantController(RestaurantService restaurantService) {
        this.restaurantService = restaurantService;
    }

    @InitBinder("restaurant")
    public void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("id");                              // mass-assignment guard
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true)); // "" -> null
    }

    @GetMapping
    public String restaurants(Model model) {

        model.addAttribute("restaurants", restaurantService.getAllRestaurants());

        return "restaurants";
    }

    // ----- admin only (enforced in WebConfig) -----

    @GetMapping("/add")
    public String showAddRestaurant(Model model) {

        model.addAttribute("restaurant", new Restaurant());

        return "addRestaurant";
    }

    @PostMapping("/save")
    public String saveRestaurant(@Valid @ModelAttribute("restaurant") Restaurant restaurant,
                                 BindingResult result, Model model) {

        if (result.hasErrors()) {
            model.addAttribute("error", result.getAllErrors().get(0).getDefaultMessage());
            return "addRestaurant";
        }

        restaurantService.addRestaurant(restaurant);

        return "redirect:/restaurants";
    }

    @PostMapping("/delete/{id}")
    public String deleteRestaurant(@PathVariable Long id) {

        restaurantService.deleteRestaurant(id);

        return "redirect:/restaurants";
    }

    // ----- any logged-in user -----

    @GetMapping("/{id}")
    public String restaurantDetails(@PathVariable Long id, Model model) {

        // throws a 404 page if the restaurant doesn't exist
        model.addAttribute("restaurant", restaurantService.getRestaurantById(id));

        return "restaurantDetails";
    }
}
