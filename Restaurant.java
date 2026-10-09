package com.model;

//import org.hibernate.annotations.processing.Pattern;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "RESTAURANTS")
@Getter
@Setter
public class Restaurant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Restaurant name is required")
    @Size(max = 150, message = "Name must be at most 150 characters")
    private String name;

    @NotBlank(message = "Location is required")
    @Size(max = 255, message = "Location must be at most 255 characters")
    private String location;

    @NotBlank(message = "Cuisine is required")
    @Size(max = 100, message = "Cuisine must be at most 100 characters")
    private String cuisine;

    @Pattern(regexp = "^[0-9+\\- ]{7,15}$", message = "Enter a valid phone number")
    private String phone;

    @Size(max = 255, message = "Image URL must be at most 255 characters")
    @Pattern(regexp = "^https?://\\S+$", message = "Image must be an http(s) URL")
    private String image;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private RestaurantStatus status;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Restaurant other)) return false;
        return id != null && id.equals(other.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}

