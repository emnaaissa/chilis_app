package com.backend.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Commande_MenuItem")
public class CommandeMenuItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "idCommande", nullable = false)
    private Commande commande;

    @ManyToOne
    @JoinColumn(name = "idItem", nullable = false)
    private MenuItem menuItem;

    private int quantite;

    // Constructeurs
    public CommandeMenuItem() {}

    public CommandeMenuItem(Commande commande, MenuItem menuItem, int quantite) {
        this.commande = commande;
        this.menuItem = menuItem;
        this.quantite = quantite;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Commande getCommande() {
        return commande;
    }

    public void setCommande(Commande commande) {
        this.commande = commande;
    }

    public MenuItem getMenuItem() {
        return menuItem;
    }

    public void setMenuItem(MenuItem menuItem) {
        this.menuItem = menuItem;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }
}

