package org.example.creational.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.example.creational.builder.Car;
import org.example.creational.dto.*;
import org.example.creational.factory.Document;
import org.example.creational.factory.DocumentFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/api/creational")
@Tag(name = "Creational Patterns", description = "Factory and Builder pattern endpoints")
public class CreationalController {

    @Autowired
    private DocumentFactory documentFactory;

    @Operation(summary = "Get available document types", description = "Returns list of document types that can be created using Factory pattern")
    @GetMapping("/factory/types")
    public List<String> getDocumentTypes() {
        return Arrays.asList("PDF", "WORD", "HTML");
    }

    @Operation(summary = "Create a document", description = "Creates a document using Factory pattern")
    @PostMapping("/factory/document")
    public DocumentResponse createDocument(@RequestBody DocumentRequest request) {
        Document document = documentFactory.createDocument(request.getType());
        document.setContent(request.getContent());

        DocumentResponse response = new DocumentResponse();
        response.setType(document.getType());
        response.setContent(document.getContent());
        response.setDisplay(document.display());
        return response;
    }

    @Operation(summary = "Build a car", description = "Creates a car using Builder pattern")
    @PostMapping("/builder/car")
    public CarResponse buildCar(@RequestBody CarRequest request) {
        Car car = new Car.Builder()
                .engine(request.getEngine())
                .transmission(request.getTransmission())
                .color(request.getColor())
                .rims(request.getRims())
                .hasLeatherSeats(request.isHasLeatherSeats())
                .hasGPS(request.isHasGPS())
                .hasSoundSystem(request.isHasSoundSystem())
                .hasSunroof(request.isHasSunroof())
                .hasABS(request.isHasABS())
                .hasAirbags(request.isHasAirbags())
                .hasRearCamera(request.isHasRearCamera())
                .build();

        return CarResponse.fromCar(car);
    }

}
