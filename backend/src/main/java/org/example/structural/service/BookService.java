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
        // Programming Books
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

        Book book4 = new Book();
        book4.setTitle("The Pragmatic Programmer");
        book4.setAuthor("David Thomas");
        book4.setCategory("Programming");
        book4.setPrice(42.99);
        addBook(book4);

        Book book5 = new Book();
        book5.setTitle("Refactoring");
        book5.setAuthor("Martin Fowler");
        book5.setCategory("Programming");
        book5.setPrice(47.99);
        addBook(book5);

        // Fiction Books
        Book book6 = new Book();
        book6.setTitle("1984");
        book6.setAuthor("George Orwell");
        book6.setCategory("Fiction");
        book6.setPrice(15.99);
        addBook(book6);

        Book book7 = new Book();
        book7.setTitle("To Kill a Mockingbird");
        book7.setAuthor("Harper Lee");
        book7.setCategory("Fiction");
        book7.setPrice(14.99);
        addBook(book7);

        Book book8 = new Book();
        book8.setTitle("The Great Gatsby");
        book8.setAuthor("F. Scott Fitzgerald");
        book8.setCategory("Fiction");
        book8.setPrice(12.99);
        addBook(book8);

        Book book9 = new Book();
        book9.setTitle("Pride and Prejudice");
        book9.setAuthor("Jane Austen");
        book9.setCategory("Fiction");
        book9.setPrice(13.99);
        addBook(book9);

        // Science Books
        Book book10 = new Book();
        book10.setTitle("A Brief History of Time");
        book10.setAuthor("Stephen Hawking");
        book10.setCategory("Science");
        book10.setPrice(18.99);
        addBook(book10);

        Book book11 = new Book();
        book11.setTitle("The Selfish Gene");
        book11.setAuthor("Richard Dawkins");
        book11.setCategory("Science");
        book11.setPrice(16.99);
        addBook(book11);

        Book book12 = new Book();
        book12.setTitle("Cosmos");
        book12.setAuthor("Carl Sagan");
        book12.setCategory("Science");
        book12.setPrice(19.99);
        addBook(book12);

        Book book13 = new Book();
        book13.setTitle("The Origin of Species");
        book13.setAuthor("Charles Darwin");
        book13.setCategory("Science");
        book13.setPrice(17.99);
        addBook(book13);

        // History Books
        Book book14 = new Book();
        book14.setTitle("Sapiens");
        book14.setAuthor("Yuval Noah Harari");
        book14.setCategory("History");
        book14.setPrice(22.99);
        addBook(book14);

        Book book15 = new Book();
        book15.setTitle("Guns, Germs, and Steel");
        book15.setAuthor("Jared Diamond");
        book15.setCategory("History");
        book15.setPrice(20.99);
        addBook(book15);

        Book book16 = new Book();
        book16.setTitle("The History of the Ancient World");
        book16.setAuthor("Susan Wise Bauer");
        book16.setCategory("History");
        book16.setPrice(24.99);
        addBook(book16);

        Book book17 = new Book();
        book17.setTitle("SPQR");
        book17.setAuthor("Mary Beard");
        book17.setCategory("History");
        book17.setPrice(21.99);
        addBook(book17);
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
