import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BehavioralScreen extends StatefulWidget {
  const BehavioralScreen({super.key});

  @override
  State<BehavioralScreen> createState() => _BehavioralScreenState();
}

class _BehavioralScreenState extends State<BehavioralScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _orders = [];
  bool _isLoading = false;

  final _customerController = TextEditingController();
  final _amountController = TextEditingController();

  // Search by ID
  final _searchIdController = TextEditingController();
  Map<String, dynamic>? _searchedOrder;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  @override
  void dispose() {
    _customerController.dispose();
    _amountController.dispose();
    _searchIdController.dispose();
    super.dispose();
  }

  void _loadOrders() async {
    setState(() => _isLoading = true);
    try {
      final orders = await _apiService.getOrders();
      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _placeOrder() async {
    if (_customerController.text.isEmpty || _amountController.text.isEmpty) return;

    try {
      await _apiService.placeOrder(
        _customerController.text,
        double.parse(_amountController.text),
      );
      _customerController.clear();
      _amountController.clear();
      _loadOrders();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _searchById() async {
    if (_searchIdController.text.isEmpty) return;
    try {
      final id = int.parse(_searchIdController.text);
      final order = await _apiService.getOrderById(id);
      setState(() => _searchedOrder = order);
    } catch (e) {
      setState(() => _searchedOrder = null);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order not found or error: $e')),
      );
    }
  }

  void _showOrderDetails(int id) async {
    try {
      final order = await _apiService.getOrderById(id);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${order['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Customer: ${order['customerName']}'),
              Text('Amount: \$${order['totalAmount']}'),
              Text('Status: ${order['status']}'),
              const SizedBox(height: 12),
              const Text('Patterns used:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const Text('• Command: PlaceOrderCommand',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Text('• Chain: Validation handlers',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Text('• Strategy: Payment processing',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Text('• Observer: Notifications',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Place Order
          Card(
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Place Order (Command Pattern)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Demonstrates: Chain of Responsibility, Command, Observer, Strategy'),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _customerController,
                    decoration: const InputDecoration(
                      labelText: 'Customer Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _placeOrder,
                    child: const Text('Place Order'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Search by ID
          Card(
            color: Colors.cyan.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Search by ID',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Get a specific order by ID'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchIdController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Order ID',
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
                  if (_searchedOrder != null) ...[
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
                          Text('ID: ${_searchedOrder!['id']}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('Customer: ${_searchedOrder!['customerName']}'),
                          Text('Amount: \$${_searchedOrder!['totalAmount']}'),
                          Text('Status: ${_searchedOrder!['status']}'),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Orders List
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Orders List',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: _loadOrders,
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else if (_orders.isEmpty)
                    const Text('No orders')
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _orders.length,
                      itemBuilder: (context, index) {
                        final order = _orders[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: Text('${order['id']}'),
                          ),
                          title: Text(order['customerName'] ?? 'Unknown'),
                          subtitle: Text('Amount: \$${order['totalAmount']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Chip(
                                label: Text(order['status'] ?? 'PENDING',
                                  style: const TextStyle(fontSize: 12)),
                                backgroundColor: order['status'] == 'CONFIRMED'
                                    ? Colors.green[100]
                                    : Colors.orange[100],
                              ),
                              IconButton(
                                icon: const Icon(Icons.info_outline, color: Colors.green),
                                onPressed: () => _showOrderDetails(order['id']),
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
        ],
      ),
    );
  }
}
