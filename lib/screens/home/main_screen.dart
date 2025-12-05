import 'package:allection/models/menu_button.dart';
import 'package:allection/screens/home/subscreens/calendar_screen.dart';
import 'package:allection/screens/home/subscreens/collections_screensdart';
import 'package:allection/screens/home/subscreens/home_screen.dart';
import 'package:allection/screens/home/subscreens/wishlist_screen.dart';
import 'package:allection/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  String get selectedScreenName {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Collections";
      case 2:
        return "Wishlist";
      case 3:
        return "Calendar";
      default:
        return "Home";
    }
  }

  final List<Widget> _pages = [
    Center(child: HomeScreen()),
    Center(child: CollectionsScreen()),
    Center(child: WishlistScreen()),
    Center(child: CalendarScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: FractionalOffset.center,
            colors: [AllColors.primaryColor, AllColors.secondaryColor],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: View.of(context).padding.top - 70),
            Row(
              children: [
                SizedBox(width: 10),
                // Secção do Icone de Configurações
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 28,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),
                // Secção do Texto 'Home'
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        selectedScreenName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Secção da foto de perfil
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 6),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'lib/images/default_pfp.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomMenuButton(
                          label: 'Home',
                          onTap: () {
                            setState(() {
                              index = 0;
                            });
                          },
                          width: 110,
                          height: 30,
                          borderRadius: 20,
                          isSelected: index == 0,
                        ),
                        SizedBox(width: 10),
                        CustomMenuButton(
                          label: 'Collections',
                          onTap: () {
                            setState(() {
                              index = 1;
                            });
                          },
                          width: 110,
                          height: 30,
                          borderRadius: 20,
                          isSelected: index == 1,
                        ),
                        SizedBox(width: 10),
                        CustomMenuButton(
                          label: 'Wishlist',
                          onTap: () {
                            setState(() {
                              index = 2;
                            });
                          },
                          width: 110,
                          height: 30,
                          borderRadius: 20,
                          isSelected: index == 2,
                        ),
                        SizedBox(width: 10),
                        CustomMenuButton(
                          label: 'Calendar',
                          onTap: () {
                            setState(() {
                              index = 3;
                            });
                          },
                          width: 110,
                          height: 30,
                          borderRadius: 20,
                          isSelected: index == 3,
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Flexible(child: _pages[index]),
          ],
        ),
      ),
    );
  }
}
