package com.backend.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Panier_MenuItem")
@IdClass(PanierMenuItemId.class) // Clé composite
public class PanierMenuItem {

    @Id
    @ManyToOne
    @JoinColumn(name = "idPanier", nullable = false)
    private Panier panier;

    @Id
    @ManyToOne
    @JoinColumn(name = "idItem", nullable = false)
    private MenuItem menuItem;

    private int quantite;

    // Getters and Setters

    public Panier getPanier() {
        return panier;
    }

    public void setPanier(Panier panier) {
        this.panier = panier;
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

