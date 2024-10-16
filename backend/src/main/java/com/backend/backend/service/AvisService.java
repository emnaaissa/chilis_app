package com.backend.backend.service;

import com.backend.backend.model.Avis;
import com.backend.backend.repository.AvisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AvisService {

    @Autowired
    private AvisRepository avisRepository;

    public List<Avis> findAll() {
        return avisRepository.findAll();
    }

    public Avis findById(Long id) {
        return avisRepository.findById(id).orElse(null);
    }

    public Avis save(Avis avis) {
        return avisRepository.save(avis);
    }

    public void deleteById(Long id) {
        avisRepository.deleteById(id);
    }

    // Vous pouvez ajouter d'autres méthodes spécifiques si nécessaire
}
