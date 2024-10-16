package com.backend.backend.repository;

import com.backend.backend.model.SuperAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SuperAdminRepository extends JpaRepository<SuperAdmin, Long> {
    // Vous pouvez ajouter des méthodes spécifiques si nécessaire
}

