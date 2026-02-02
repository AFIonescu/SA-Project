package org.example.structural.service;

import jakarta.annotation.PostConstruct;
import org.example.structural.entity.Book;
import org.example.structural.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    @PostConstruct
    public void init() {
        createSampleBooks();
    }

    private void createSampleBooks() {
        Book book1 = new Book();
        book1.setTitle("Clean Code");
        book1.setAuthor("Robert C. Martin");
        book1.setCategory("Programming");
        book1.setPrice(45.99);
        addBook(book1);

        Book book2 = new Book();
        book2.setTitle("Design Patterns");
        book2.setAuthor("Gang of Four");
        book2.setCategory("Programming");
        book2.setPrice(54.99);
        addBook(book2);

        Book book3 = new Book();
        book3.setTitle("Effective Java");
        book3.setAuthor("Joshua Bloch");
        book3.setCategory("Programming");
        book3.setPrice(49.99);
        addBook(book3);
    }

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Book addBook(Book book) {
        return bookRepository.save(book);
    }

    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }

    public Book updateBook(Long id, Book updatedBook) {
        return bookRepository.findById(id)
                .map(book -> {
                    book.setTitle(updatedBook.getTitle());
                    book.setAuthor(updatedBook.getAuthor());
                    book.setCategory(updatedBook.getCategory());
                    book.setPrice(updatedBook.getPrice());
                    return bookRepository.save(book);
                })
                .orElse(null);
    }

    public List<Book> getBooksByCategory(String category) {
        return bookRepository.findByCategory(category);
    }

    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }
}
