package com.backend.backend.service;

import com.backend.backend.model.Panier;
import com.backend.backend.repository.PanierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PanierService {

    @Autowired
    private PanierRepository panierRepository;

    public List<Panier> getAllPaniers() {
        return panierRepository.findAll();
    }

    public Panier getPanierById(Long id) {
        return panierRepository.findById(id).orElse(null);
    }

    public Panier createPanier(Panier panier) {
        return panierRepository.save(panier);
    }

    public Panier updatePanier(Panier panier) {
        return panierRepository.save(panier);
    }

    public void deletePanier(Long id) {
        panierRepository.deleteById(id);
    }

    public List<Panier> getPaniersByClient(Long idClient) {
        return panierRepository.findByClient_IdClient(idClient);
    }

    public Panier getActivePanierByClient(Long idClient) {
        return panierRepository.findByClient_IdClientAndActifTrue(idClient);
    }
}
