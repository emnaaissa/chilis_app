package com.backend.backend.controller;

import com.backend.backend.model.Avis;
import com.backend.backend.service.AvisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/avis")
public class AvisController {

    @Autowired
    private AvisService avisService;

    @GetMapping
    public List<Avis> getAll() {
        return avisService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Avis> getById(@PathVariable Long id) {
        Avis avis = avisService.findById(id);
        return avis != null ? ResponseEntity.ok(avis) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<Avis> create(@RequestBody Avis avis) {
        Avis created = avisService.save(avis);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        avisService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}

