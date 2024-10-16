package com.backend.backend.controller;

import com.backend.backend.model.SuperAdmin;
import com.backend.backend.service.SuperAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/super-admin")
public class SuperAdminController {

    @Autowired
    private SuperAdminService superAdminService;

    @GetMapping
    public List<SuperAdmin> getAll() {
        return superAdminService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<SuperAdmin> getById(@PathVariable Long id) {
        SuperAdmin superAdmin = superAdminService.findById(id);
        return superAdmin != null ? ResponseEntity.ok(superAdmin) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<SuperAdmin> create(@RequestBody SuperAdmin superAdmin) {
        SuperAdmin created = superAdminService.save(superAdmin);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        superAdminService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
