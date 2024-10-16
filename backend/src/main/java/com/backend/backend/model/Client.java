package com.backend.backend.model;

import jakarta.persistence.*;


@Entity
@Table(name = "Client")
public class Client {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idClient;

    private String nom;
    private String email;
    private String motDePasse;
    private int pointsCadeaux;

    // Getters and Setters

    public Long getIdClient() {
        return idClient;
    }

    public void setIdClient(Long idClient) {
        this.idClient = idClient;
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

    public int getPointsCadeaux() {
        return pointsCadeaux;
    }

    public void setPointsCadeaux(int pointsCadeaux) {
        this.pointsCadeaux = pointsCadeaux;
    }
}

