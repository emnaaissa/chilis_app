package com.backend.backend.service;

import com.backend.backend.model.Category;
import com.backend.backend.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    // Get all categories
    public List<Category> getAllCategories() {
        try {
            return categoryRepository.findAll();
        } catch (Exception e) {
            System.err.println("Error retrieving categories: " + e.getMessage());
            throw e; // Optionally rethrow to handle it in the controller
        }
    }


    // Get a category by ID
    public Optional<Category> getCategoryById(Long id) {
        return categoryRepository.findById(id);
    }

    // Create a new category
    public Category createCategory(Category category) {
        return categoryRepository.save(category);
    }

    // Update an existing category
    public Category updateCategory(Long id, Category updatedCategory) {
        Optional<Category> existingCategory = categoryRepository.findById(id);
        if (existingCategory.isPresent()) {
            Category category = existingCategory.get();
            category.setNomCategorie(updatedCategory.getNomCategorie());
            return categoryRepository.save(category);
        } else {
            throw new RuntimeException("Category not found with id " + id);
        }
    }

    // Delete a category by ID
    public void deleteCategory(Long id) {
        categoryRepository.deleteById(id);
    }
}
