package com.backend.backend.repository;

import com.backend.backend.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminRepository extends JpaRepository<Admin, Long> {
    // Vous pouvez ajouter des méthodes spécifiques si nécessaire
}
