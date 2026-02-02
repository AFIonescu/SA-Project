package org.example.structural.service;

public class BestsellerBookDecorator implements BookDecorator {
    private final BookDecorator decoratedBook;

    public BestsellerBookDecorator(BookDecorator decoratedBook) {
        this.decoratedBook = decoratedBook;
    }

    @Override
    public String getDescription() {
        return decoratedBook.getDescription() + " [BESTSELLER]";
    }

    @Override
    public double getPrice() {
        return decoratedBook.getPrice();
    }
}
