package org.example.creational.dto;

import lombok.Data;
import org.example.creational.builder.Car;

@Data
public class CarResponse {
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

    public static CarResponse fromCar(Car car) {
        CarResponse response = new CarResponse();
        response.setEngine(car.getEngine());
        response.setTransmission(car.getTransmission());
        response.setColor(car.getColor());
        response.setRims(car.getRims());
        response.setHasLeatherSeats(car.isHasLeatherSeats());
        response.setHasGPS(car.isHasGPS());
        response.setHasSoundSystem(car.isHasSoundSystem());
        response.setHasSunroof(car.isHasSunroof());
        response.setHasABS(car.isHasABS());
        response.setHasAirbags(car.isHasAirbags());
        response.setHasRearCamera(car.isHasRearCamera());
        return response;
    }
}
