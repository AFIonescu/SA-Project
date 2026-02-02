import 'package:flutter/material.dart';
import 'creational_screen.dart';
import 'behavioral_screen.dart';
import 'structural_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CreationalScreen(),
    const BehavioralScreen(),
    const StructuralScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Patterns'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.build),
            label: 'Creational',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology),
            label: 'Behavioral',
          ),
          NavigationDestination(
            icon: Icon(Icons.architecture),
            label: 'Structural',
          ),
        ],
      ),
    );
  }
}
