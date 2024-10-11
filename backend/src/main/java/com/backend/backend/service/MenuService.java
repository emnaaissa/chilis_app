package com.backend.backend.service;

import com.backend.backend.model.MenuItem;
import com.backend.backend.repository.MenuItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MenuService {

    @Autowired
    private MenuItemRepository menuItemRepository;

    /**
     * Retrieve all menu items from the repository.
     *
     * @return List of MenuItem objects
     */
    public List<MenuItem> getAllMenuItems() {
        return menuItemRepository.findAll();
    }

    /**
     * Retrieve a specific menu item by its ID.
     *
     * @param id The ID of the menu item
     * @return An Optional containing the MenuItem if found, or empty if not found
     */
    public Optional<MenuItem> getMenuItemById(Long id) {
        return menuItemRepository.findById(id);
    }

    /**
     * Add a new menu item to the repository.
     *
     * @param menuItem The menu item to add
     * @return The saved MenuItem object
     */
    public MenuItem addMenuItem(MenuItem menuItem) {
        if (menuItem.getName() == null || menuItem.getPrice() == null) {
            throw new IllegalArgumentException("Menu item name and price cannot be null");
        }
        return menuItemRepository.save(menuItem);
    }


    /**
     * Update an existing menu item.
     *
     * @param id The ID of the menu item to update
     * @param updatedMenuItem The updated menu item data
     * @return The updated MenuItem object
     */
    public MenuItem updateMenuItem(Long id, MenuItem updatedMenuItem) {
        Optional<MenuItem> existingMenuItem = menuItemRepository.findById(id);
        if (existingMenuItem.isPresent()) {
            MenuItem menuItem = existingMenuItem.get();
            menuItem.setName(updatedMenuItem.getName());
            menuItem.setPrice(updatedMenuItem.getPrice());
            menuItem.setDescription(updatedMenuItem.getDescription());
            menuItem.setImageUrl(updatedMenuItem.getImageUrl());
            return menuItemRepository.save(menuItem);
        } else {
            throw new RuntimeException("MenuItem with ID " + id + " not found");
        }
    }

    /**
     * Delete a menu item by its ID.
     *
     * @param id The ID of the menu item to delete
     */
    public void deleteMenuItem(Long id) {
        menuItemRepository.deleteById(id);
    }
}
