package com.backend.backend.service;

import com.backend.backend.model.MenuItem;
import com.backend.backend.model.Category;
import com.backend.backend.repository.MenuItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MenuItemService {

    @Autowired
    private MenuItemRepository menuRepository;

    @Autowired
    private CategoryService categoryService; // Inject CategoryService

    // Get all menu items
    public List<MenuItem> getAllMenuItems() {
        return menuRepository.findAll();
    }

    // Get a menu item by ID
    public Optional<MenuItem> getMenuItemById(Long id) {
        return menuRepository.findById(id);
    }

    // Create a new menu item
    public MenuItem createMenuItem(MenuItem menuItem, Long categoryId) {
        Optional<Category> category = categoryService.getCategoryById(categoryId);
        if (category.isPresent()) {
            menuItem.setCategory(category.get());
            return menuRepository.save(menuItem);
        } else {
            throw new RuntimeException("Category not found with id " + categoryId);
        }
    }

    // Update an existing menu item
    public MenuItem updateMenuItem(Long id, MenuItem updatedMenuItem, Long categoryId) {
        Optional<MenuItem> existingMenuItem = menuRepository.findById(id);
        if (existingMenuItem.isPresent()) {
            MenuItem menuItem = existingMenuItem.get();
            menuItem.setNom(updatedMenuItem.getNom());
            menuItem.setDescription(updatedMenuItem.getDescription());
            menuItem.setPrix(updatedMenuItem.getPrix());
            menuItem.setImage(updatedMenuItem.getImage());

            // Set the category
            Optional<Category> category = categoryService.getCategoryById(categoryId);
            if (category.isPresent()) {
                menuItem.setCategory(category.get());
            } else {
                throw new RuntimeException("Category not found with id " + categoryId);
            }

            return menuRepository.save(menuItem);
        } else {
            throw new RuntimeException("MenuItem not found with id " + id);
        }
    }

    // Delete a menu item by ID
    public void deleteMenuItem(Long id) {
        menuRepository.deleteById(id);
    }
}
