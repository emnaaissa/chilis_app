package com.backend.backend.service;

import com.backend.backend.model.Banner;
import com.backend.backend.repository.BannerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BannerService {
    @Autowired
    private BannerRepository bannerRepository;

    public List<Banner> getAllBanners() {
        return bannerRepository.findAll();
    }

    public Optional<Banner> getBannerById(Long id) {
        return bannerRepository.findById(id);
    }

    public Banner saveBanner(Banner banner) {
        return bannerRepository.save(banner);
    }

    public void deleteBanner(Long id) {
        bannerRepository.deleteById(id);
    }

    public Banner updateBanner(Long id, Banner bannerDetails) {
        return bannerRepository.findById(id).map(banner -> {
            banner.setImage(bannerDetails.getImage());
            banner.setEtatBanner(bannerDetails.isEtatBanner());
            return bannerRepository.save(banner);
        }).orElseThrow(() -> new RuntimeException("Banner not found with id " + id));
    }
}
