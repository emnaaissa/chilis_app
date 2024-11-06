package com.backend.backend.model;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;


@Entity
public class Banner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idBanner;
    private String image;
    private boolean etatBanner; // make sure this is boolean if you want to use `isEtatBanner()`

    // Getters and Setters
    public Long getIdBanner() {
        return idBanner;
    }

    public void setIdBanner(Long idBanner) {
        this.idBanner = idBanner;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isEtatBanner() {  // This is the getter that allows you to use `isEtatBanner()`
        return etatBanner;
    }

    public void setEtatBanner(boolean etatBanner) {
        this.etatBanner = etatBanner;
    }
}

