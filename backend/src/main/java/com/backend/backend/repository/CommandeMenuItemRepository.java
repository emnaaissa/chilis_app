package com.backend.backend.repository;

import com.backend.backend.model.CommandeMenuItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommandeMenuItemRepository extends JpaRepository<CommandeMenuItem, Long> {
    // Vous pouvez ajouter des méthodes spécifiques si nécessaire
}

