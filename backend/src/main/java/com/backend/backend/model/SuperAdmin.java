package com.backend.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "SuperAdmin")
public class SuperAdmin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idSuperAdmin;

    private String nom;
    private String email;
    private String motDePasse;

    // Constructeurs
    public SuperAdmin() {}

    public SuperAdmin(String nom, String email, String motDePasse) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
    }

    // Getters et Setters
    public Long getIdSuperAdmin() {
        return idSuperAdmin;
    }

    public void setIdSuperAdmin(Long idSuperAdmin) {
        this.idSuperAdmin = idSuperAdmin;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }
}

