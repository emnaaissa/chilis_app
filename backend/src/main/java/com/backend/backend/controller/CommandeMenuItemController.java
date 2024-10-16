package com.backend.backend.controller;

import com.backend.backend.model.CommandeMenuItem;
import com.backend.backend.service.CommandeMenuItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/commande-menu-item")
public class CommandeMenuItemController {

    @Autowired
    private CommandeMenuItemService commandeMenuItemService;

    @GetMapping
    public List<CommandeMenuItem> getAll() {
        return commandeMenuItemService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<CommandeMenuItem> getById(@PathVariable Long id) {
        CommandeMenuItem commandeMenuItem = commandeMenuItemService.findById(id);
        return commandeMenuItem != null ? ResponseEntity.ok(commandeMenuItem) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<CommandeMenuItem> create(@RequestBody CommandeMenuItem commandeMenuItem) {
        CommandeMenuItem created = commandeMenuItemService.save(commandeMenuItem);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        commandeMenuItemService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}

