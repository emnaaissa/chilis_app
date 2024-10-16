package com.backend.backend.service;

import com.backend.backend.model.CommandeMenuItem;
import com.backend.backend.repository.CommandeMenuItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommandeMenuItemService {

    @Autowired
    private CommandeMenuItemRepository commandeMenuItemRepository;

    public List<CommandeMenuItem> findAll() {
        return commandeMenuItemRepository.findAll();
    }

    public CommandeMenuItem findById(Long id) {
        return commandeMenuItemRepository.findById(id).orElse(null);
    }

    public CommandeMenuItem save(CommandeMenuItem commandeMenuItem) {
        return commandeMenuItemRepository.save(commandeMenuItem);
    }

    public void deleteById(Long id) {
        commandeMenuItemRepository.deleteById(id);
    }

    // Vous pouvez ajouter d'autres méthodes spécifiques si nécessaire
}

