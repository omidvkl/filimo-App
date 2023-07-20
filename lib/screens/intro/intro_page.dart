import 'package:filimo_app/screens/authentication/login/login_page.dart';
import 'package:filimo_app/screens/dashboard/dashboard_page.dart';
import 'package:filimo_app/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222220),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/fa-filimo-dark-logo.webp',
            width: 150,
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffc0392b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
              },
              child: Text('Enter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffc0392b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
