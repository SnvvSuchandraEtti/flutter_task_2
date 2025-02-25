import 'package:flutter/material.dart';
import 'package:yt_shorts/screens/yt_shorts.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // You'll need to create these screens
  final List<Widget> _screens = [
    const HomeScreenPlaceholder(), // Replace with your actual Home screen
    const Home(), // Your Shorts screen
    Container(), // Upload placeholder (or modal)
    const SubscriptionScreenPlaceholder(), // Replace with your Subscription screen
    const ProfileScreenPlaceholder(), // Replace with your Profile/You screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // For the middle "add" button, you might want to show a modal instead
          if (index == 2) {
            _showUploadOptions();
            return;
          }
          
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void _showUploadOptions() {
    // Show a modal bottom sheet or dialog for upload options
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildUploadOption(Icons.videocam, 'Short'),
                  _buildUploadOption(Icons.upload, 'Upload'),
                  _buildUploadOption(Icons.live_tv, 'Go Live'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUploadOption(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[800],
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

// Placeholder screens - replace these with your actual screens
class HomeScreenPlaceholder extends StatelessWidget {
  const HomeScreenPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

class SubscriptionScreenPlaceholder extends StatelessWidget {
  const SubscriptionScreenPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Subscriptions Screen'),
      ),
    );
  }
}

class ProfileScreenPlaceholder extends StatelessWidget {
  const ProfileScreenPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  
  const BottomNavBar({
    Key? key, 
    required this.currentIndex,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.video_collection), label: 'Shorts'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 40), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined), label: 'Subscriptions'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'You'),
      ]
    );
  }
}