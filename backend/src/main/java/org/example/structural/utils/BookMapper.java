package org.example.structural.utils;

import org.example.structural.dto.BookDto;
import org.example.structural.entity.Book;

public class BookMapper {

    public static BookDto toDTO(Book book) {
        BookDto dto = new BookDto();
        dto.setId(book.getId());
        dto.setTitle(book.getTitle());
        dto.setAuthor(book.getAuthor());
        dto.setCategory(book.getCategory());
        dto.setPrice(book.getPrice());
        return dto;
    }

    public static Book toEntity(BookDto dto) {
        Book book = new Book();
        book.setId(dto.getId());
        book.setTitle(dto.getTitle());
        book.setAuthor(dto.getAuthor());
        book.setCategory(dto.getCategory());
        book.setPrice(dto.getPrice());
        return book;
    }
}
