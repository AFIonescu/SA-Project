package org.example.ai.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

@Service
public class AIService {

    @Value("${openrouter.api.key:}")
    private String apiKey;

    private final RestTemplate restTemplate = new RestTemplate();
    private static final String OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions";

    public List<String> getBookRecommendations(List<String> existingBooks, String userInput) {
        if (apiKey == null || apiKey.isEmpty()) {
            return List.of("Please configure OpenRouter API key in application.properties");
        }

        String booksContext = existingBooks.isEmpty()
            ? "No books in the library yet."
            : "Current library books: " + String.join(", ", existingBooks);

        String userPreferences = (userInput != null && !userInput.trim().isEmpty())
            ? "\n\nUser preferences: " + userInput
            : "";

        String prompt = String.format(
            "%s%s\n\nBased on the above library%s, recommend 3 new books that would complement this collection. " +
            "First, provide a brief overview paragraph explaining the focus of the library and your recommendation strategy. " +
            "Then list 3 recommendations, numbered 1-3. For each book, include: " +
            "Title by Author (Category), followed by a sentence explaining why it complements the existing collection. " +
            "Use plain text only - no markdown formatting like asterisks, bold, or italic markers.",
            booksContext,
            userPreferences,
            userPreferences.isEmpty() ? "" : " and the user's preferences"
        );

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);

        Map<String, Object> requestBody = Map.of(
            "model", "deepseek/deepseek-v3.2",
            "messages", List.of(
                Map.of("role", "user", "content", prompt)
            )
        );

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

        try {
            @SuppressWarnings("rawtypes")
            ResponseEntity<Map> response = restTemplate.exchange(
                OPENROUTER_URL,
                HttpMethod.POST,
                request,
                Map.class
            );

            @SuppressWarnings("unchecked")
            Map<String, Object> responseBody = response.getBody();
            if (responseBody != null && responseBody.containsKey("choices")) {
                @SuppressWarnings("unchecked")
                List<Map<String, Object>> choices = (List<Map<String, Object>>) responseBody.get("choices");
                if (!choices.isEmpty()) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");
                    String content = (String) message.get("content");
                    String cleanedContent = cleanMarkdown(content);
                    return List.of(cleanedContent.split("\n"));
                }
            }
            return List.of("No recommendations available");
        } catch (Exception e) {
            return List.of("Error getting recommendations: " + e.getMessage());
        }
    }

    private String cleanMarkdown(String text) {
        if (text == null) return "";
        // Remove markdown bold (**text** or __text__)
        text = text.replaceAll("\\*\\*([^*]+)\\*\\*", "$1");
        text = text.replaceAll("__([^_]+)__", "$1");
        // Remove markdown italic (*text* or _text_)
        text = text.replaceAll("\\*([^*]+)\\*", "$1");
        text = text.replaceAll("_([^_]+)_", "$1");
        // Clean up any remaining stray asterisks or underscores
        text = text.replaceAll("\\*+", "");
        text = text.replaceAll("_+", "");
        return text;
    }
}
