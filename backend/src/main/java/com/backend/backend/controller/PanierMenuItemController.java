package com.backend.backend.controller;

import com.backend.backend.model.MenuItem;
import com.backend.backend.model.Panier;
import com.backend.backend.model.PanierMenuItem;
import com.backend.backend.model.PanierMenuItemId;
import com.backend.backend.service.PanierMenuItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/panier-menu-items")
public class PanierMenuItemController {

    @Autowired
    private PanierMenuItemService panierMenuItemService;

    @GetMapping
    public List<PanierMenuItem> getAllPanierMenuItems() {
        return panierMenuItemService.getAllPanierMenuItems();
    }

    @GetMapping("/{panierId}/{menuItemId}")
    public ResponseEntity<PanierMenuItem> getPanierMenuItemById(@PathVariable Long panierId, @PathVariable Long menuItemId) {
        PanierMenuItemId id = new PanierMenuItemId(panierId, menuItemId);
        PanierMenuItem panierMenuItem = panierMenuItemService.getPanierMenuItemById(id);
        if (panierMenuItem == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(panierMenuItem);
    }

    @PostMapping
    public PanierMenuItem createPanierMenuItem(@RequestBody PanierMenuItem panierMenuItem) {
        return panierMenuItemService.createPanierMenuItem(panierMenuItem);
    }

    @PutMapping("/{panierId}/{menuItemId}")
    public ResponseEntity<PanierMenuItem> updatePanierMenuItem(@PathVariable Long panierId, @PathVariable Long menuItemId, @RequestBody PanierMenuItem panierMenuItem) {
        panierMenuItem.setPanier(new Panier(panierId)); // Assurez-vous que l'objet Panier est correctement construit
        panierMenuItem.setMenuItem(new MenuItem(menuItemId)); // Assurez-vous que l'objet MenuItem est correctement construit
        PanierMenuItem updatedPanierMenuItem = panierMenuItemService.updatePanierMenuItem(panierMenuItem);
        return ResponseEntity.ok(updatedPanierMenuItem);
    }

    @DeleteMapping("/{panierId}/{menuItemId}")
    public ResponseEntity<Void> deletePanierMenuItem(@PathVariable Long panierId, @PathVariable Long menuItemId) {
        PanierMenuItemId id = new PanierMenuItemId(panierId, menuItemId);
        panierMenuItemService.deletePanierMenuItem(id);
        return ResponseEntity.noContent().build();
    }
}

