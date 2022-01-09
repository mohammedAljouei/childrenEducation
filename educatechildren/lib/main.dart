// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'screens/letters.dart';
import 'screens/numbers.dart';
import 'screens/childProgress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Directionality(
        // add this
        textDirection: TextDirection.rtl, // عربي
        child: TabsScreen(),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    Letters(
      title: "حروف",
    ),
    Numbers(title: "أرقام")
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: Material(
            color: Color(0xFFEBD8FF),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const SizedBox(
                  height: 48,
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChildProgress()),
                    );
                  },
                  child: Text(
                    'تقدم الطفل',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFFEBD8FF),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.accents[14],
          selectedItemColor: Colors.accents[14],
          currentIndex: _selectedPageIndex,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.sort_by_alpha), title: Text('حـروف')),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_numbered_sharp),
                title: Text('أرقـام')),
          ],
        ),
        body: Stack(
          children: [
            Container(
              // Here the height of the container is 45% of our total height
              height: size.height * .25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Color(0xFFEBD8FF),
              ),
            ),
            SafeArea(
              child: _pages[_selectedPageIndex],
            ),
          ],
        ));
  }
}
