package org.example.structural.service;

import org.example.structural.entity.Book;
import org.example.structural.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class LibraryFacade {

    @Autowired
    private BookService bookService;

    @Autowired
    private BookRepository bookRepository;

    public Book addBook(Book book) {
        return bookService.addBook(book);
    }

    public List<Book> findBooksByCategory(String category) {
        return bookService.getBooksByCategory(category);
    }

    public List<BookDecorator> getFeaturedBooks() {
        return bookService.getAllBooks().stream()
                .map(book -> new FeaturedBookDecorator(new BasicBook(book)))
                .collect(Collectors.toList());
    }

    public List<BookDecorator> getBestsellerBooks() {
        return bookService.getAllBooks().stream()
                .map(book -> new BestsellerBookDecorator(new BasicBook(book)))
                .collect(Collectors.toList());
    }

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Book getBookById(Long id) {
        return bookService.getBookById(id).orElse(null);
    }

    public Book updateBook(Long id, Book book) {
        return bookService.updateBook(id, book);
    }

    public void deleteBook(Long id) {
        bookService.deleteBook(id);
    }
}
