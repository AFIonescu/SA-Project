package org.example.creational.builder;

public class Car {
    private String engine;
    private String transmission;
    private boolean hasLeatherSeats;
    private boolean hasGPS;
    private boolean hasSoundSystem;
    private String color;
    private String rims;
    private boolean hasSunroof;
    private boolean hasABS;
    private boolean hasAirbags;
    private boolean hasRearCamera;

    private Car(Builder builder) {
        this.engine = builder.engine;
        this.transmission = builder.transmission;
        this.hasLeatherSeats = builder.hasLeatherSeats;
        this.hasGPS = builder.hasGPS;
        this.hasSoundSystem = builder.hasSoundSystem;
        this.color = builder.color;
        this.rims = builder.rims;
        this.hasSunroof = builder.hasSunroof;
        this.hasABS = builder.hasABS;
        this.hasAirbags = builder.hasAirbags;
        this.hasRearCamera = builder.hasRearCamera;
    }

    public String getEngine() {
        return engine;
    }

    public String getTransmission() {
        return transmission;
    }

    public boolean isHasLeatherSeats() {
        return hasLeatherSeats;
    }

    public boolean isHasGPS() {
        return hasGPS;
    }

    public boolean isHasSoundSystem() {
        return hasSoundSystem;
    }

    public String getColor() {
        return color;
    }

    public String getRims() {
        return rims;
    }

    public boolean isHasSunroof() {
        return hasSunroof;
    }

    public boolean isHasABS() {
        return hasABS;
    }

    public boolean isHasAirbags() {
        return hasAirbags;
    }

    public boolean isHasRearCamera() {
        return hasRearCamera;
    }

    @Override
    public String toString() {
        return "Car [engine=" + engine + ", transmission=" + transmission +
               ", hasLeatherSeats=" + hasLeatherSeats + ", hasGPS=" + hasGPS +
               ", hasSoundSystem=" + hasSoundSystem + ", color=" + color +
               ", rims=" + rims + ", hasSunroof=" + hasSunroof +
               ", hasABS=" + hasABS + ", hasAirbags=" + hasAirbags +
               ", hasRearCamera=" + hasRearCamera + "]";
    }

    public static class Builder {
        private String engine;
        private String transmission;
        private boolean hasLeatherSeats;
        private boolean hasGPS;
        private boolean hasSoundSystem;
        private String color;
        private String rims;
        private boolean hasSunroof;
        private boolean hasABS;
        private boolean hasAirbags;
        private boolean hasRearCamera;

        public Builder engine(String engine) {
            this.engine = engine;
            return this;
        }

        public Builder transmission(String transmission) {
            this.transmission = transmission;
            return this;
        }

        public Builder hasLeatherSeats(boolean hasLeatherSeats) {
            this.hasLeatherSeats = hasLeatherSeats;
            return this;
        }

        public Builder hasGPS(boolean hasGPS) {
            this.hasGPS = hasGPS;
            return this;
        }

        public Builder hasSoundSystem(boolean hasSoundSystem) {
            this.hasSoundSystem = hasSoundSystem;
            return this;
        }

        public Builder color(String color) {
            this.color = color;
            return this;
        }

        public Builder rims(String rims) {
            this.rims = rims;
            return this;
        }

        public Builder hasSunroof(boolean hasSunroof) {
            this.hasSunroof = hasSunroof;
            return this;
        }

        public Builder hasABS(boolean hasABS) {
            this.hasABS = hasABS;
            return this;
        }

        public Builder hasAirbags(boolean hasAirbags) {
            this.hasAirbags = hasAirbags;
            return this;
        }

        public Builder hasRearCamera(boolean hasRearCamera) {
            this.hasRearCamera = hasRearCamera;
            return this;
        }

        public Car build() {
            validate();
            return new Car(this);
        }

        private void validate() {
            if (engine == null || engine.isEmpty()) {
                throw new IllegalStateException("Engine is required");
            }
            if (transmission == null || transmission.isEmpty()) {
                throw new IllegalStateException("Transmission is required");
            }
            if (color == null || color.isEmpty()) {
                throw new IllegalStateException("Color is required");
            }
        }
    }
}
