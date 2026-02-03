import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  // ============ CREATIONAL PATTERNS ============

  Future<List<String>> getDocumentTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/creational/factory/types'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    }
    throw Exception('Failed to load document types');
  }

  Future<Map<String, dynamic>> createDocument(String type, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/creational/factory/document'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'type': type, 'content': content}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to create document');
  }

  Future<Map<String, dynamic>> buildCar(Map<String, dynamic> carData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/creational/builder/car'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(carData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to build car');
  }

  // ============ BEHAVIORAL PATTERNS ============

  Future<List<dynamic>> getOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/behavioral/orders'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load orders');
  }

  Future<Map<String, dynamic>> placeOrder(String customerName, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/behavioral/orders'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'customerName': customerName,
        'totalAmount': amount,
        'status': 'PENDING'
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to place order');
  }

  Future<Map<String, dynamic>> getOrderById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/behavioral/orders/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load order');
  }

  // ============ STRUCTURAL PATTERNS ============

  Future<List<dynamic>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/structural/books'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load books');
  }

  Future<List<String>> getFeaturedBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/structural/books/featured'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    }
    throw Exception('Failed to load featured books');
  }

  Future<List<String>> getBestsellerBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/structural/books/bestsellers'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    }
    throw Exception('Failed to load bestseller books');
  }

  Future<Map<String, dynamic>> addBook(Map<String, dynamic> bookData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/structural/books'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to add book');
  }

  Future<void> deleteBook(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/structural/books/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  }

  Future<Map<String, dynamic>> getBookById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/structural/books/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load book');
  }

  Future<List<dynamic>> getBooksByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/structural/books/category/$category'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load books by category');
  }

  Future<Map<String, dynamic>> updateBook(int id, Map<String, dynamic> bookData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/structural/books/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to update book');
  }

  // ============ AI FEATURES ============

  Future<List<String>> getAIRecommendations(String userInput) async {
    String url = '$baseUrl/ai/books/recommend';
    if (userInput.isNotEmpty) {
      url += '?userInput=${Uri.encodeComponent(userInput)}';
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    }
    throw Exception('Failed to get AI recommendations');
  }
}
