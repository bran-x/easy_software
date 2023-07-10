import 'package:easy_software/tables/config.dart';
import 'package:example/screens/charts.dart';
import 'package:example/screens/googlemap.dart';
import 'package:example/screens/login.dart';
import 'package:example/screens/tables.dart';
import 'package:flutter/material.dart';

void main() {
  // Setup config for PaginatedTable
  PaginatedTableConfig.headerBackgroundColor = Colors.deepPurple;
  PaginatedTableConfig.headerTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  PaginatedTableConfig.rowTextStyle = const TextStyle(
    fontSize: 16,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    TablesExamples(),
    GoogleMapExample(),
    LoginPageExample(),
    ChartsExample(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Easy Software Example'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.table_rows),
            label: 'Tables',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Google Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Charts',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
