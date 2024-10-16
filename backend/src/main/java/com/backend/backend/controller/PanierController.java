package com.backend.backend.controller;

import com.backend.backend.model.Panier;
import com.backend.backend.service.PanierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/paniers")
public class PanierController {

    @Autowired
    private PanierService panierService;

    @GetMapping
    public List<Panier> getAllPaniers() {
        return panierService.getAllPaniers();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Panier> getPanierById(@PathVariable Long id) {
        Panier panier = panierService.getPanierById(id);
        if (panier == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(panier);
    }

    @PostMapping
    public Panier createPanier(@RequestBody Panier panier) {
        return panierService.createPanier(panier);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Panier> updatePanier(@PathVariable Long id, @RequestBody Panier panier) {
        panier.setIdPanier(id);
        Panier updatedPanier = panierService.updatePanier(panier);
        return ResponseEntity.ok(updatedPanier);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePanier(@PathVariable Long id) {
        panierService.deletePanier(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/client/{idClient}")
    public List<Panier> getPaniersByClient(@PathVariable Long idClient) {
        return panierService.getPaniersByClient(idClient);
    }

    @GetMapping("/client/{idClient}/actif")
    public ResponseEntity<Panier> getActivePanierByClient(@PathVariable Long idClient) {
        Panier panier = panierService.getActivePanierByClient(idClient);
        if (panier == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(panier);
    }
}
