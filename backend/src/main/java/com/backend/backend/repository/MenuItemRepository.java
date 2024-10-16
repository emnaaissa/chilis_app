package com.backend.backend.repository;

import com.backend.backend.model.MenuItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuItemRepository extends JpaRepository<MenuItem, Long> {
    // Vous pouvez ajouter des méthodes de recherche personnalisées si nécessaire
}
