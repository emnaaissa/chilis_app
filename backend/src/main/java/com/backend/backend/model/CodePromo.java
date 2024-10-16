package com.backend.backend.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "CodePromo")
public class CodePromo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idCode;

    private String code;
    private double reduction;
    private LocalDate dateExpiration;

    // Constructeurs
    public CodePromo() {}

    public CodePromo(String code, double reduction, LocalDate dateExpiration) {
        this.code = code;
        this.reduction = reduction;
        this.dateExpiration = dateExpiration;
    }

    // Getters et Setters
    public Long getIdCode() {
        return idCode;
    }

    public void setIdCode(Long idCode) {
        this.idCode = idCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }

    public LocalDate getDateExpiration() {
        return dateExpiration;
    }

    public void setDateExpiration(LocalDate dateExpiration) {
        this.dateExpiration = dateExpiration;
    }
}
