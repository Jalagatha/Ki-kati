import 'package:flutter/material.dart';
import 'package:ki_kati/screens/chat_screen.dart';
import 'package:ki_kati/screens/notification_screen.dart';
import 'package:ki_kati/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To track the currently selected index
  final List<Widget> _screens = [
    const ChatScreen(),
    const ChatScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
    /*
    if (index == 3) {
      // Profile tab index
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.white), // Search icon
          onPressed: () {
            // Add your onPressed code here!
          },
          padding: const EdgeInsets.all(6.0), // Adjust padding for smaller size
          splashColor: Colors.transparent, // Remove splash color
          highlightColor: Colors.transparent, // Remove highlight color
        ),
        title: const Text(
          "Ki-Kati",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.green, // Background color for the settings icon
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.verified_user_rounded),
              color: Colors.white, // Icon color
              onPressed: () {
                // Add your onPressed code here!
              },
            ),
          ),
        ],
      ),

      body: _screens[_selectedIndex], // Display the selected screen

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Set the current index
        selectedItemColor: Colors.green, // Color for the selected item
        onTap: _onItemTapped, // Handle item tap
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
