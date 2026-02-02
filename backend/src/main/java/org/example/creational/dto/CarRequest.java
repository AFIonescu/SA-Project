package org.example.creational.dto;

import lombok.Data;

@Data
public class CarRequest {
    private String engine;
    private String transmission;
    private String color;
    private String rims;
    private boolean hasLeatherSeats;
    private boolean hasGPS;
    private boolean hasSoundSystem;
    private boolean hasSunroof;
    private boolean hasABS;
    private boolean hasAirbags;
    private boolean hasRearCamera;
}
