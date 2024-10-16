package com.backend.backend.model;

import jakarta.persistence.*;


@Entity
@Table(name = "Panier")
public class Panier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idPanier;

    @ManyToOne
    @JoinColumn(name = "idClient", nullable = false)
    private Client client;

    private boolean actif;
    private double total;

    // Constructeur pour initialiser avec l'ID
    public Panier(Long idPanier) {
        this.idPanier = idPanier;
    }

    // Constructeur par défaut
    public Panier() {}

    // Getters and Setters

    public Long getIdPanier() {
        return idPanier;
    }

    public void setIdPanier(Long idPanier) {
        this.idPanier = idPanier;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}
