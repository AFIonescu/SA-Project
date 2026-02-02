package org.example.structural.controller;

import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.example.structural.dto.BookDto;
import org.example.structural.entity.Book;
import org.example.structural.service.BookDecorator;
import org.example.structural.service.LibraryFacade;
import org.example.structural.utils.BookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import io.swagger.v3.oas.annotations.Operation;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/structural/books")
@Tag(name = "Structural Patterns", description = "Facade and Decorator pattern endpoints")
public class LibraryController {

    private final LibraryFacade libraryFacade;

    @Autowired
    public LibraryController(LibraryFacade libraryFacade) {
        this.libraryFacade = libraryFacade;
    }

    @Operation(summary = "Retrieve all books", description = "Returns all books using Facade pattern")
    @GetMapping
    public List<BookDto> getAllBooks() {
        return libraryFacade.getAllBooks()
                .stream()
                .map(BookMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Operation(summary = "Get a book by ID", description = "Returns a specific book by ID using Facade pattern")
    @GetMapping("/{id}")
    public BookDto getBookById(@Parameter(description = "ID of the book") @PathVariable Long id) {
        Book book = libraryFacade.getBookById(id);
        return book != null ? BookMapper.toDTO(book) : new BookDto();
    }

    @Operation(summary = "Add a new book", description = "Adds a new book using Facade pattern")
    @PostMapping
    public BookDto addBook(@RequestBody BookDto bookDto) {
        Book book = BookMapper.toEntity(bookDto);
        Book savedBook = libraryFacade.addBook(book);
        return BookMapper.toDTO(savedBook);
    }

    @Operation(summary = "Update a book", description = "Updates an existing book using Facade pattern")
    @PutMapping("/{id}")
    public BookDto updateBook(@PathVariable Long id, @RequestBody BookDto updatedBookDto) {
        Book updatedBook = BookMapper.toEntity(updatedBookDto);
        Book result = libraryFacade.updateBook(id, updatedBook);
        return result != null ? BookMapper.toDTO(result) : new BookDto();
    }

    @Operation(summary = "Delete a book", description = "Deletes a book using Facade pattern")
    @DeleteMapping("/{id}")
    public void deleteBook(@PathVariable Long id) {
        libraryFacade.deleteBook(id);
    }

    @Operation(summary = "Get books by category", description = "Returns books filtered by category using Facade pattern")
    @GetMapping("/category/{category}")
    public List<BookDto> getBooksByCategory(@PathVariable String category) {
        return libraryFacade.findBooksByCategory(category)
                .stream()
                .map(BookMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Operation(summary = "Get featured books", description = "Returns books with Featured decorator applied")
    @GetMapping("/featured")
    public List<String> getFeaturedBooks() {
        return libraryFacade.getFeaturedBooks()
                .stream()
                .map(BookDecorator::getDescription)
                .collect(Collectors.toList());
    }

    @Operation(summary = "Get bestseller books", description = "Returns books with Bestseller decorator applied")
    @GetMapping("/bestsellers")
    public List<String> getBestsellerBooks() {
        return libraryFacade.getBestsellerBooks()
                .stream()
                .map(BookDecorator::getDescription)
                .collect(Collectors.toList());
    }
}
