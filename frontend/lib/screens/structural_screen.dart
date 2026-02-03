import 'package:flutter/material.dart';
import '../services/api_service.dart';

class StructuralScreen extends StatefulWidget {
  const StructuralScreen({super.key});

  @override
  State<StructuralScreen> createState() => _StructuralScreenState();
}

class _StructuralScreenState extends State<StructuralScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _books = [];
  List<dynamic> _filteredBooks = [];
  List<String> _featuredBooks = [];
  List<String> _bestsellerBooks = [];
  bool _isLoading = false;
  List<String> _aiRecommendations = [];
  bool _isLoadingAI = false;
  final _aiInputController = TextEditingController();

  // Add Book Form Controllers
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedCategory = 'Programming';

  // Category Filter
  String _filterCategory = 'ALL';

  // Search by ID
  final _searchIdController = TextEditingController();
  Map<String, dynamic>? _searchedBook;

  final List<String> _categories = ['Programming', 'Fiction', 'Science', 'History'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    _searchIdController.dispose();
    _aiInputController.dispose();
    super.dispose();
  }

  void _searchById() async {
    if (_searchIdController.text.isEmpty) return;
    try {
      final id = int.parse(_searchIdController.text);
      final book = await _apiService.getBookById(id);
      setState(() => _searchedBook = book);
    } catch (e) {
      setState(() => _searchedBook = null);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book not found or error: $e')),
      );
    }
  }

  void _loadData() async {
    setState(() => _isLoading = true);
    try {
      final books = await _apiService.getBooks();
      final featured = await _apiService.getFeaturedBooks();
      final bestsellers = await _apiService.getBestsellerBooks();
      setState(() {
        _books = books;
        _filteredBooks = books;
        _featuredBooks = featured;
        _bestsellerBooks = bestsellers;
        _isLoading = false;
        _filterCategory = 'ALL';
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterByCategory(String category) async {
    if (category == 'ALL') {
      setState(() {
        _filteredBooks = _books;
        _filterCategory = 'ALL';
      });
      return;
    }

    setState(() => _isLoading = true);
    try {
      final filtered = await _apiService.getBooksByCategory(category);
      setState(() {
        _filteredBooks = filtered;
        _filterCategory = category;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _addBook() async {
    if (_titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        _priceController.text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      await _apiService.addBook({
        'title': _titleController.text,
        'author': _authorController.text,
        'price': double.parse(_priceController.text),
        'category': _selectedCategory,
      });
      _titleController.clear();
      _authorController.clear();
      _priceController.clear();
      _loadData();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book added via Facade Pattern')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _deleteBook(int id) async {
    try {
      await _apiService.deleteBook(id);
      _loadData();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book deleted via Facade Pattern')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _getAIRecommendations() async {
    setState(() => _isLoadingAI = true);
    try {
      final recommendations = await _apiService.getAIRecommendations(_aiInputController.text);
      setState(() {
        _aiRecommendations = recommendations;
        _isLoadingAI = false;
      });
    } catch (e) {
      setState(() => _isLoadingAI = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting AI recommendations: $e')),
      );
    }
  }

  void _showBookDetails(int id) async {
    try {
      final book = await _apiService.getBookById(id);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Book Details (via getBookById)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${book['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Title: ${book['title']}'),
              Text('Author: ${book['author']}'),
              Text('Price: \$${book['price']}'),
              Text('Category: ${book['category']}'),
              const SizedBox(height: 12),
              const Text('Fetched using LibraryFacade.getBookById()',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _showEditDialog(Map<String, dynamic> book) {
    final editTitleController = TextEditingController(text: book['title']);
    final editAuthorController = TextEditingController(text: book['author']);
    final editPriceController = TextEditingController(text: book['price'].toString());
    String editCategory = book['category'] ?? 'Programming';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Book'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: editAuthorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
              TextField(
                controller: editPriceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (context, setDialogState) => DropdownButton<String>(
                  value: editCategory,
                  isExpanded: true,
                  items: _categories.map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() => editCategory = value!);
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              try {
                await _apiService.updateBook(book['id'], {
                  'title': editTitleController.text,
                  'author': editAuthorController.text,
                  'price': double.parse(editPriceController.text),
                  'category': editCategory,
                });
                navigator.pop();
                _loadData();
                messenger.showSnackBar(
                  const SnackBar(content: Text('Book updated via Facade Pattern')),
                );
              } catch (e) {
                messenger.showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Recommendations Card
          Card(
            color: Colors.purple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('AI Book Recommendations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Get AI-powered book suggestions based on your library'),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _aiInputController,
                    decoration: const InputDecoration(
                      labelText: 'Your preferences (optional)',
                      hintText: 'e.g., "I like sci-fi" or "beginner-friendly books"',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _isLoadingAI ? null : _getAIRecommendations,
                    child: _isLoadingAI
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Get AI Recommendations'),
                  ),
                  if (_aiRecommendations.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 8),
                    ..._aiRecommendations.map((rec) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(rec, style: const TextStyle(fontSize: 14)),
                    )),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Add Book Form - Facade Pattern
          Card(
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add Book (Facade Pattern)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Add a new book through LibraryFacade'),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _authorController,
                    decoration: const InputDecoration(
                      labelText: 'Author',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat));
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedCategory = value!),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _addBook,
                    child: const Text('Add Book'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Search by ID - Facade Pattern
          Card(
            color: Colors.cyan.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Search by ID (Facade Pattern)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Get a specific book using LibraryFacade.getBookById()'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchIdController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Book ID',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _searchById,
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                  if (_searchedBook != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.cyan),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${_searchedBook!['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('Title: ${_searchedBook!['title']}'),
                          Text('Author: ${_searchedBook!['author']}'),
                          Text('Price: \$${_searchedBook!['price']}'),
                          Text('Category: ${_searchedBook!['category']}'),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Category Filter - Facade Pattern
          Card(
            color: Colors.purple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filter by Category (Facade Pattern)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Filter books using LibraryFacade.getBooksByCategory()'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('ALL'),
                        selected: _filterCategory == 'ALL',
                        onSelected: (_) => _filterByCategory('ALL'),
                      ),
                      ..._categories.map((cat) => ChoiceChip(
                        label: Text(cat),
                        selected: _filterCategory == cat,
                        onSelected: (_) => _filterByCategory(cat),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Facade Pattern - Books List
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Facade Pattern - Book List${_filterCategory != 'ALL' ? ' ($_filterCategory)' : ''}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(onPressed: _loadData, icon: const Icon(Icons.refresh)),
                    ],
                  ),
                  const Text('Books accessed through LibraryFacade'),
                  const SizedBox(height: 8),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else if (_filteredBooks.isEmpty)
                    const Text('No books found')
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = _filteredBooks[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: Text('${book['id']}'),
                          ),
                          title: Text(book['title'] ?? ''),
                          subtitle: Text('${book['author']} - \$${book['price']} (${book['category']})'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.info_outline, color: Colors.green),
                                onPressed: () => _showBookDetails(book['id']),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showEditDialog(book),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteBook(book['id']),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Decorator Pattern - Featured Books
          Card(
            color: Colors.amber.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Decorator Pattern - Featured',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Books with [FEATURED] tag added by FeaturedBookDecorator'),
                  const SizedBox(height: 8),
                  if (_featuredBooks.isEmpty)
                    const Text('No featured books')
                  else
                    ...List.generate(_featuredBooks.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(_featuredBooks[index]),
                      );
                    }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Decorator Pattern - Bestseller Books
          Card(
            color: Colors.orange.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Decorator Pattern - Bestsellers',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Books with [BESTSELLER] tag added by BestsellerBookDecorator'),
                  const SizedBox(height: 8),
                  if (_bestsellerBooks.isEmpty)
                    const Text('No bestseller books')
                  else
                    ...List.generate(_bestsellerBooks.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(_bestsellerBooks[index]),
                      );
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
