package org.example.creational.factory;

public interface Document {
    void setContent(String content);
    String getContent();
    String getType();
    void open();
    void save();
    String display();
}
