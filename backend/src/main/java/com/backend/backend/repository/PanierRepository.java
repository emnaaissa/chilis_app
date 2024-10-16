package com.backend.backend.repository;

import com.backend.backend.model.Panier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PanierRepository extends JpaRepository<Panier, Long> {
    List<Panier> findByClient_IdClient(Long idClient);
    Panier findByClient_IdClientAndActifTrue(Long idClient);
}

