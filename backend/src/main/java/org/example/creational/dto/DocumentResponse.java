package org.example.creational.dto;

import lombok.Data;

@Data
public class DocumentResponse {
    private String type;
    private String content;
    private String display;
}
