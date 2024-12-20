package com.backend.backend.controller;

import com.backend.backend.model.MenuItem;
import com.backend.backend.service.MenuItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/menu")
public class MenuItemController {

    @Autowired
    private MenuItemService menuService;

    // POST: Add a new menu item with category ID
    @PostMapping
    public ResponseEntity<MenuItem> addMenuItem(@RequestBody MenuItem menuItem, @RequestParam Long categoryId) {
        try {
            MenuItem savedMenuItem = menuService.createMenuItem(menuItem, categoryId);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedMenuItem);
        } catch (Exception e) {
            System.err.println("Error adding menu item: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    // GET: Retrieve all menu items
    @GetMapping
    public List<MenuItem> getAllMenuItems() {
        return menuService.getAllMenuItems();
    }

    // GET: Retrieve a specific menu item by ID
    @GetMapping("/{id}")
    public ResponseEntity<MenuItem> getMenuItemById(@PathVariable Long id) {
        return menuService.getMenuItemById(id)
                .map(menuItem -> ResponseEntity.ok(menuItem))
                .orElse(ResponseEntity.notFound().build());
    }

    // PUT: Update an existing menu item by ID with category ID
    @PutMapping("/{id}")
    public ResponseEntity<MenuItem> updateMenuItem(@PathVariable Long id, @RequestBody MenuItem updatedMenuItem, @RequestParam Long categoryId) {
        try {
            MenuItem updated = menuService.updateMenuItem(id, updatedMenuItem, categoryId);
            return ResponseEntity.ok(updated);
        } catch (RuntimeException e) {
            System.err.println("Error updating menu item: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    // DELETE: Remove a menu item by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMenuItem(@PathVariable Long id) {
        try {
            menuService.deleteMenuItem(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            System.err.println("Error deleting menu item: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}
