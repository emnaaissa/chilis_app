package com.backend.backend.repository;

import com.backend.backend.model.Avis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AvisRepository extends JpaRepository<Avis, Long> {
    // Vous pouvez ajouter des méthodes spécifiques si nécessaire
}
