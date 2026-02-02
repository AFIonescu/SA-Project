package org.example.structural.service;

public class FeaturedBookDecorator implements BookDecorator {
    private final BookDecorator decoratedBook;

    public FeaturedBookDecorator(BookDecorator decoratedBook) {
        this.decoratedBook = decoratedBook;
    }

    @Override
    public String getDescription() {
        return decoratedBook.getDescription() + " [FEATURED]";
    }

    @Override
    public double getPrice() {
        return decoratedBook.getPrice();
    }
}
