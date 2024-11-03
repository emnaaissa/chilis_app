package com.backend.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "MenuItem")
public class MenuItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idItem;

    private String nom;
    private String description;
    private double prix;
    private String image;

    @ManyToOne
    @JoinColumn(name = "id_categorie", nullable = false)
    private Category category;

    // Constructors
    public MenuItem() {}

    public MenuItem(Long idItem) {
        this.idItem = idItem;
    }

    // Getters and Setters
    public Long getIdItem() {
        return idItem;
    }

    public void setIdItem(Long idItem) {
        this.idItem = idItem;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}
