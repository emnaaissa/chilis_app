package com.backend.backend.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "Avis")
public class Avis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idAvis;

    @ManyToOne
    @JoinColumn(name = "idClient", nullable = false)
    private Client client;

    private String commentaire;

    private LocalDate date;

    private boolean validationAdmin;

    // Constructeurs
    public Avis() {}

    public Avis(Client client, String commentaire, LocalDate date, boolean validationAdmin) {
        this.client = client;
        this.commentaire = commentaire;
        this.date = date;
        this.validationAdmin = validationAdmin;
    }

    // Getters et Setters
    public Long getIdAvis() {
        return idAvis;
    }

    public void setIdAvis(Long idAvis) {
        this.idAvis = idAvis;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public String getCommentaire() {
        return commentaire;
    }

    public void setCommentaire(String commentaire) {
        this.commentaire = commentaire;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public boolean isValidationAdmin() {
        return validationAdmin;
    }

    public void setValidationAdmin(boolean validationAdmin) {
        this.validationAdmin = validationAdmin;
    }
}
