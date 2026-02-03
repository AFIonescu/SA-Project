package org.example.ai.controller;

import org.example.ai.service.AIService;
import org.example.structural.entity.Book;
import org.example.structural.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/ai")
@CrossOrigin(origins = "*")
public class AIController {

    @Autowired
    private AIService aiService;

    @Autowired
    private BookRepository bookRepository;

    @GetMapping("/books/recommend")
    public List<String> getBookRecommendations(@RequestParam(required = false) String userInput) {
        List<Book> existingBooks = bookRepository.findAll();
        List<String> bookTitles = existingBooks.stream()
            .map(book -> book.getTitle() + " by " + book.getAuthor())
            .collect(Collectors.toList());

        return aiService.getBookRecommendations(bookTitles, userInput);
    }
}
