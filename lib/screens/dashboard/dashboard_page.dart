import 'package:filimo_app/screens/caegory/category_page.dart';
import 'package:filimo_app/screens/home/home_page.dart';
import 'package:filimo_app/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int _currentIndex=0;

  List<Widget> _widgets=[HomePage(),CategoryPage(),ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('assets/images/fa-filimo-dark-logo.webp',width: 140,)
            
          ],
        ),
        
          elevation: 8,
          backgroundColor: Color(0xff222220),
          automaticallyImplyLeading: false),
      body: _widgets.elementAt(_currentIndex),
      
      backgroundColor: Color(0xff151515),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.blue),

        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'خانه',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'دسته بندی'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified),
              label: 'پروفایل'
          ),
        ],

        onTap: (value) {
          setState(() {
            _currentIndex=value;
          });
        },
        currentIndex: _currentIndex,
        backgroundColor: Color(0xff222220),
      ),
    );
  }
}
