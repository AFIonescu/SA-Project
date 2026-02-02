package org.example.structural.service;

import org.example.structural.entity.Book;

public class BasicBook implements BookDecorator {
    private final Book book;

    public BasicBook(Book book) {
        this.book = book;
    }

    @Override
    public String getDescription() {
        return book.getDescription();
    }

    @Override
    public double getPrice() {
        return book.getPrice();
    }
}
