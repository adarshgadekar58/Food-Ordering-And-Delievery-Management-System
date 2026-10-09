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
import org.springframework.web.bind.annotation.RequestParam;

import com.model.FoodItem;
import com.service.FoodItemService;
import com.service.RestaurantService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/food")
public class FoodItemController {

    private final FoodItemService foodItemService;
    private final RestaurantService restaurantService;

    public FoodItemController(FoodItemService foodItemService,
                              RestaurantService restaurantService) {
        this.foodItemService = foodItemService;
        this.restaurantService = restaurantService;
    }

    @InitBinder("foodItem")
    public void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("id", "restaurant", "restaurant.*"); // mass-assignment guard
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    // ----- any logged-in user -----

    @GetMapping("/all")
    public String allFood(Model model) {

        model.addAttribute("foodItems", foodItemService.getAllFoodItems());

        return "foodItems";
    }

    @GetMapping("/restaurant/{restaurantId}")
    public String restaurantMenu(@PathVariable Long restaurantId, Model model) {

        model.addAttribute("restaurant", restaurantService.getRestaurantById(restaurantId));
        model.addAttribute("foodItems", foodItemService.getFoodItemsByRestaurant(restaurantId));

        return "restaurantMenu";
    }

    @GetMapping("/{id}")
    public String foodDetails(@PathVariable Long id, Model model) {

        model.addAttribute("foodItem", foodItemService.getFoodItemById(id));

        return "foodDetails";
    }

    // ----- admin only (enforced in WebConfig) -----

    @GetMapping("/add/{restaurantId}")
    public String showAddFood(@PathVariable Long restaurantId, Model model) {

        model.addAttribute("restaurant", restaurantService.getRestaurantById(restaurantId));
        model.addAttribute("foodItem", new FoodItem());

        return "addFood";
    }

    @PostMapping("/save")
    public String saveFood(@Valid @ModelAttribute("foodItem") FoodItem foodItem,
                           BindingResult result,
                           @RequestParam Long restaurantId,
                           Model model) {

        if (result.hasErrors()) {
            model.addAttribute("restaurant", restaurantService.getRestaurantById(restaurantId));
            model.addAttribute("error", result.getAllErrors().get(0).getDefaultMessage());
            return "addFood";
        }

        foodItemService.addFoodItem(foodItem, restaurantId);

        return "redirect:/food/restaurant/" + restaurantId;
    }

    @PostMapping("/delete/{id}")
    public String deleteFood(@PathVariable Long id) {

        Long restaurantId = foodItemService.deleteFoodItem(id);

        return "redirect:/food/restaurant/" + restaurantId;
    }
}
