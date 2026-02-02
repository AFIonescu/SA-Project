package org.example.creational.factory;

import org.springframework.stereotype.Component;

@Component
public class DocumentFactory {

    public Document createDocument(String type) {
        switch (type.toUpperCase()) {
            case "PDF":
                return new PdfDocument();
            case "WORD":
                return new WordDocument();
            case "HTML":
                return new HtmlDocument();
            default:
                throw new IllegalArgumentException("Unknown document type: " + type);
        }
    }
}
