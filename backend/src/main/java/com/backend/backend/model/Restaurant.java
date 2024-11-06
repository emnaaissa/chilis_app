package com.backend.backend.model;

import jakarta.persistence.*;
@Entity
public class Restaurant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idResto;

    private String localisationRestau;
    private String etatResto; // "open" ou "close"

    public Restaurant() {}

    public Restaurant(String localisationRestau, String etatResto) {
        this.localisationRestau = localisationRestau;
        this.etatResto = etatResto;
    }

    public Long getIdResto() {
        return idResto;
    }

    public void setIdResto(Long idResto) {
        this.idResto = idResto;
    }

    public String getLocalisationRestau() {
        return localisationRestau;
    }

    public void setLocalisationRestau(String localisationRestau) {
        this.localisationRestau = localisationRestau;
    }

    public String getEtatResto() {
        return etatResto;
    }

    public void setEtatResto(String etatResto) {
        this.etatResto = etatResto;
    }
}