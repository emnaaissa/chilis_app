package com.backend.backend.controller;

import com.backend.backend.model.Commande;
import com.backend.backend.service.CommandeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/commandes")
public class CommandeController {

    @Autowired
    private CommandeService commandeService;

    @GetMapping
    public List<Commande> getAllCommandes() {
        return commandeService.getAllCommandes();
    }

    @GetMapping("/{idCommande}")
    public ResponseEntity<Commande> getCommandeById(@PathVariable Long idCommande) {
        Commande commande = commandeService.getCommandeById(idCommande);
        if (commande == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(commande);
    }

    @PostMapping
    public Commande createCommande(@RequestBody Commande commande) {
        return commandeService.createCommande(commande);
    }

    @PutMapping("/{idCommande}")
    public ResponseEntity<Commande> updateCommande(@PathVariable Long idCommande, @RequestBody Commande commande) {
        commande.setIdCommande(idCommande);
        Commande updatedCommande = commandeService.updateCommande(commande);
        return ResponseEntity.ok(updatedCommande);
    }

    @DeleteMapping("/{idCommande}")
    public ResponseEntity<Void> deleteCommande(@PathVariable Long idCommande) {
        commandeService.deleteCommande(idCommande);
        return ResponseEntity.noContent().build();
    }
}
