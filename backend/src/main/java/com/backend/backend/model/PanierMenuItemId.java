package com.backend.backend.model;

import java.io.Serializable;
import java.util.Objects;

public class PanierMenuItemId implements Serializable {
    private Long panier;
    private Long menuItem;

    // Constructors, equals, and hashCode methods

    public PanierMenuItemId() {}

    public PanierMenuItemId(Long panier, Long menuItem) {
        this.panier = panier;
        this.menuItem = menuItem;
    }

    public Long getPanier() {
        return panier;
    }

    public void setPanier(Long panier) {
        this.panier = panier;
    }

    public Long getMenuItem() {
        return menuItem;
    }

    public void setMenuItem(Long menuItem) {
        this.menuItem = menuItem;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PanierMenuItemId)) return false;
        PanierMenuItemId that = (PanierMenuItemId) o;
        return Objects.equals(panier, that.panier) && Objects.equals(menuItem, that.menuItem);
    }

    @Override
    public int hashCode() {
        return Objects.hash(panier, menuItem);
    }
}

