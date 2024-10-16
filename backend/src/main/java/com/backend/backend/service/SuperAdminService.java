package com.backend.backend.service;

import com.backend.backend.model.SuperAdmin;
import com.backend.backend.repository.SuperAdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SuperAdminService {

    @Autowired
    private SuperAdminRepository superAdminRepository;

    public List<SuperAdmin> findAll() {
        return superAdminRepository.findAll();
    }

    public SuperAdmin findById(Long id) {
        return superAdminRepository.findById(id).orElse(null);
    }

    public SuperAdmin save(SuperAdmin superAdmin) {
        return superAdminRepository.save(superAdmin);
    }

    public void deleteById(Long id) {
        superAdminRepository.deleteById(id);
    }

    // Vous pouvez ajouter d'autres méthodes spécifiques si nécessaire
}

