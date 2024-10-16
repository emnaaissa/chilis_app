package com.backend.backend.repository;

import com.backend.backend.model.PanierMenuItem;
import com.backend.backend.model.PanierMenuItemId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PanierMenuItemRepository extends JpaRepository<PanierMenuItem, PanierMenuItemId> {
    // Ajoutez des méthodes de recherche personnalisées si nécessaire
}
