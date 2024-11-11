package com.backend.backend.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;

@RestController
@RequestMapping("/api")
public class ImageUploadController {

    @PostMapping("/upload-image")
    public String uploadImage(@RequestParam("file") MultipartFile file) throws IOException {
        String uploadDir = "C:/wamp64/www/chilis_images/"; // Directory to save images
        String fileName = file.getOriginalFilename();
        Path filePath = Paths.get(uploadDir, fileName);

        // Write the uploaded file bytes to the specified file path
        Files.write(filePath, file.getBytes());

        // Return the direct URL to access the image
        return "http://localhost:9092/" + fileName; // Adjusted URL without /images/ prefix
    }
}
