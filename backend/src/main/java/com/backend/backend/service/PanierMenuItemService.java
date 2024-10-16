package com.backend.backend.service;

import com.backend.backend.model.PanierMenuItem;
import com.backend.backend.model.PanierMenuItemId;
import com.backend.backend.repository.PanierMenuItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PanierMenuItemService {

    @Autowired
    private PanierMenuItemRepository panierMenuItemRepository;

    public List<PanierMenuItem> getAllPanierMenuItems() {
        return panierMenuItemRepository.findAll();
    }

    public PanierMenuItem getPanierMenuItemById(PanierMenuItemId id) {
        return panierMenuItemRepository.findById(id).orElse(null);
    }

    public PanierMenuItem createPanierMenuItem(PanierMenuItem panierMenuItem) {
        return panierMenuItemRepository.save(panierMenuItem);
    }

    public PanierMenuItem updatePanierMenuItem(PanierMenuItem panierMenuItem) {
        return panierMenuItemRepository.save(panierMenuItem);
    }

    public void deletePanierMenuItem(PanierMenuItemId id) {
        panierMenuItemRepository.deleteById(id);
    }
}

