package com.backend.backend.controller;

import com.backend.backend.model.Category;
import com.backend.backend.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    // POST: Add a new category
    @PostMapping
    public ResponseEntity<Category> addCategory(@RequestBody Category category) {
        try {
            Category savedCategory = categoryService.createCategory(category);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedCategory);
        } catch (Exception e) {
            System.err.println("Error adding category: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    // GET: Retrieve all categories
    @GetMapping
    public List<Category> getAllCategories() {
        List<Category> categories = categoryService.getAllCategories();
        System.out.println("Number of categories retrieved: " + categories.size());
        return categories;
    }


    // GET: Retrieve a specific category by ID
    @GetMapping("/{id}")
    public ResponseEntity<Category> getCategoryById(@PathVariable Long id) {
        return categoryService.getCategoryById(id)
                .map(category -> ResponseEntity.ok(category))
                .orElse(ResponseEntity.notFound().build());
    }

    // PUT: Update an existing category by ID
    @PutMapping("/{id}")
    public ResponseEntity<Category> updateCategory(@PathVariable Long id, @RequestBody Category updatedCategory) {
        try {
            Category updated = categoryService.updateCategory(id, updatedCategory);
            return ResponseEntity.ok(updated);
        } catch (RuntimeException e) {
            System.err.println("Error updating category: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    // DELETE: Remove a category by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCategory(@PathVariable Long id) {
        try {
            categoryService.deleteCategory(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            System.err.println("Error deleting category: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}
