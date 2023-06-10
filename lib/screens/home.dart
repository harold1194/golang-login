import 'package:flutter/material.dart';
import 'package:golang_login/auth/auth_provider.dart';
import 'package:golang_login/screens/add_attendance_screen.dart';
import 'package:golang_login/screens/show_log_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/my_app_bar.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Logout function
  Future<void> _logout() async {
    // Add your logout logic here
    // For example, clear user session data or navigate back to the login screen

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.logout();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isAutoImplyLeading: false,
        title: 'Home',
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Welcome Student!",
                      style: TextStyle(fontSize: 30),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ],
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddAttendanceScreen(),
                        ),
                      );
                    },
                    child: const ListTile(
                      trailing: Icon(Icons.view_list_outlined),
                      title: Text('Attendance'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowLogScreen(),
                        ),
                      );
                    },
                    child: const ListTile(
                      trailing: Icon(Icons.history),
                      title: Text('Show Log'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
                      onPressed: _logout,
                      child: const Icon(Icons.logout),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
