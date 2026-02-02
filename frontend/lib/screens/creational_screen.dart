import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CreationalScreen extends StatefulWidget {
  const CreationalScreen({super.key});

  @override
  State<CreationalScreen> createState() => _CreationalScreenState();
}

class _CreationalScreenState extends State<CreationalScreen> {
  final ApiService _apiService = ApiService();

  // Factory Pattern
  String _selectedDocType = 'PDF';
  final _contentController = TextEditingController();
  String _documentResult = '';

  // Builder Pattern - Required fields (dropdowns)
  String _selectedEngine = 'V6';
  String _selectedTransmission = 'Automatic';
  String _selectedColor = 'Blue';
  String _selectedRims = 'None';

  // Builder Pattern - Optional features (checkboxes)
  bool _hasGPS = false;
  bool _hasLeatherSeats = false;
  bool _hasSoundSystem = false;
  bool _hasSunroof = false;
  bool _hasABS = false;
  bool _hasAirbags = false;
  bool _hasRearCamera = false;
  String _carResult = '';

  // Dropdown options
  final List<String> _engines = ['V4', 'V6', 'V8', 'Electric'];
  final List<String> _transmissions = ['Automatic', 'Manual'];
  final List<String> _colors = ['Black', 'White', 'Red', 'Blue', 'Silver', 'Gray'];
  final List<String> _rimOptions = ['None', '15-inch Steel', '17-inch Alloy', '19-inch Alloy', '20-inch Sport'];

  // Combined (Car + Document)
  String _combinedDocType = 'PDF';
  String _combinedResult = '';

  void _createDocument() async {
    try {
      final result = await _apiService.createDocument(
        _selectedDocType,
        _contentController.text,
      );
      setState(() {
        _documentResult = result['display'] ?? 'Document created';
      });
    } catch (e) {
      setState(() {
        _documentResult = 'Error: $e';
      });
    }
  }

  void _buildCar() async {
    try {
      final result = await _apiService.buildCar({
        'engine': _selectedEngine,
        'transmission': _selectedTransmission,
        'color': _selectedColor,
        'rims': _selectedRims,
        'hasGPS': _hasGPS,
        'hasLeatherSeats': _hasLeatherSeats,
        'hasSoundSystem': _hasSoundSystem,
        'hasSunroof': _hasSunroof,
        'hasABS': _hasABS,
        'hasAirbags': _hasAirbags,
        'hasRearCamera': _hasRearCamera,
      });
      setState(() {
        _carResult = 'Car built: ${result['engine']} - ${result['color']}';
      });
    } catch (e) {
      setState(() {
        _carResult = 'Error: $e';
      });
    }
  }

  void _buildCarAndCreateDocument() async {
    try {
      // Step 1: Build car (Builder Pattern)
      final carResult = await _apiService.buildCar({
        'engine': _selectedEngine,
        'transmission': _selectedTransmission,
        'color': _selectedColor,
        'rims': _selectedRims,
        'hasGPS': _hasGPS,
        'hasLeatherSeats': _hasLeatherSeats,
        'hasSoundSystem': _hasSoundSystem,
        'hasSunroof': _hasSunroof,
        'hasABS': _hasABS,
        'hasAirbags': _hasAirbags,
        'hasRearCamera': _hasRearCamera,
      });

      // Step 2: Generate car description
      String carDescription = '''Car Configuration Report
========================

Engine: ${carResult['engine']}
Transmission: ${carResult['transmission']}
Color: ${carResult['color']}
Rims: ${carResult['rims']}

Features:
- GPS: ${carResult['hasGPS'] ? 'Yes' : 'No'}
- Leather Seats: ${carResult['hasLeatherSeats'] ? 'Yes' : 'No'}
- Sound System: ${carResult['hasSoundSystem'] ? 'Yes' : 'No'}
- Sunroof: ${carResult['hasSunroof'] ? 'Yes' : 'No'}
- ABS: ${carResult['hasABS'] ? 'Yes' : 'No'}
- Airbags: ${carResult['hasAirbags'] ? 'Yes' : 'No'}
- Rear Camera: ${carResult['hasRearCamera'] ? 'Yes' : 'No'}''';

      // Step 3: Create document with car description (Factory Pattern)
      final docResult = await _apiService.createDocument(
        _combinedDocType,
        carDescription,
      );

      setState(() {
        _combinedResult = docResult['display'] ?? 'Document created';
      });
    } catch (e) {
      setState(() {
        _combinedResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Factory Pattern Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Factory Pattern', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Create different document types'),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    value: _selectedDocType,
                    items: ['PDF', 'WORD', 'HTML'].map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDocType = value!;
                      });
                    },
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(labelText: 'Document Content'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _createDocument,
                    child: const Text('Create Document'),
                  ),
                  if (_documentResult.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(_documentResult, style: const TextStyle(fontFamily: 'monospace')),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Builder Pattern Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Builder Pattern', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Build a custom car'),
                  const SizedBox(height: 16),
                  const Text('Required:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Engine: '),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedEngine,
                        items: _engines.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (value) => setState(() => _selectedEngine = value!),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Transmission: '),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedTransmission,
                        items: _transmissions.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                        onChanged: (value) => setState(() => _selectedTransmission = value!),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Color: '),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedColor,
                        items: _colors.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                        onChanged: (value) => setState(() => _selectedColor = value!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Optional:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Text('Rims: '),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedRims,
                        items: _rimOptions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                        onChanged: (value) => setState(() => _selectedRims = value!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
                  CheckboxListTile(
                    title: const Text('GPS'),
                    value: _hasGPS,
                    onChanged: (value) => setState(() => _hasGPS = value!),
                  ),
                  CheckboxListTile(
                    title: const Text('Leather Seats'),
                    value: _hasLeatherSeats,
                    onChanged: (value) => setState(() => _hasLeatherSeats = value!),
                  ),
                  CheckboxListTile(
                    title: const Text('Sound System'),
                    value: _hasSoundSystem,
                    onChanged: (value) => setState(() => _hasSoundSystem = value!),
                  ),
                  CheckboxListTile(
                    title: const Text('Sunroof'),
                    value: _hasSunroof,
                    onChanged: (value) => setState(() => _hasSunroof = value!),
                  ),
                  CheckboxListTile(
                    title: const Text('ABS'),
                    value: _hasABS,
                    onChanged: (value) => setState(() => _hasABS = value!),
                  ),
                  CheckboxListTile(
                    title: const Text('Airbags'),
                    value: _hasAirbags,
                    onChanged: (value) => setState(() => _hasAirbags = value!),
                  ),
                  CheckboxListTile(
                    title: const Text('Rear Camera'),
                    value: _hasRearCamera,
                    onChanged: (value) => setState(() => _hasRearCamera = value!),
                  ),
                  ElevatedButton(
                    onPressed: _buildCar,
                    child: const Text('Build Car'),
                  ),
                  if (_carResult.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(_carResult),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Combined: Builder + Factory (like Assignment 1)
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Combined: Builder + Factory', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Build a car and generate a document with its configuration'),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    value: _combinedDocType,
                    items: ['PDF', 'WORD', 'HTML'].map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _combinedDocType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _buildCarAndCreateDocument,
                    child: const Text('Build Car & Create Document'),
                  ),
                  if (_combinedResult.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Text(_combinedResult, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
