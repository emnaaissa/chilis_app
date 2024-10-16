package com.backend.backend.repository;

import com.backend.backend.model.CodePromo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CodePromoRepository extends JpaRepository<CodePromo, Long> {
    // Vous pouvez ajouter des méthodes spécifiques si nécessaire
}
