package com.backend.backend.service;

import com.backend.backend.model.CodePromo;
import com.backend.backend.repository.CodePromoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CodePromoService {

    @Autowired
    private CodePromoRepository codePromoRepository;

    public List<CodePromo> findAll() {
        return codePromoRepository.findAll();
    }

    public CodePromo findById(Long id) {
        return codePromoRepository.findById(id).orElse(null);
    }

    public CodePromo save(CodePromo codePromo) {
        return codePromoRepository.save(codePromo);
    }

    public void deleteById(Long id) {
        codePromoRepository.deleteById(id);
    }

    // Vous pouvez ajouter d'autres méthodes spécifiques si nécessaire
}
