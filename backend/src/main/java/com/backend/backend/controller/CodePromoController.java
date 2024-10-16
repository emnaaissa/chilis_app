package com.backend.backend.controller;

import com.backend.backend.model.CodePromo;
import com.backend.backend.service.CodePromoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/code-promo")
public class CodePromoController {

    @Autowired
    private CodePromoService codePromoService;

    @GetMapping
    public List<CodePromo> getAll() {
        return codePromoService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<CodePromo> getById(@PathVariable Long id) {
        CodePromo codePromo = codePromoService.findById(id);
        return codePromo != null ? ResponseEntity.ok(codePromo) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<CodePromo> create(@RequestBody CodePromo codePromo) {
        CodePromo created = codePromoService.save(codePromo);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        codePromoService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
