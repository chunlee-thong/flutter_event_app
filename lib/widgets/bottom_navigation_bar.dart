import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageButtonNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const HomePageButtonNavigationBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          label: "Explore",
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          label: "Map",
          icon: Icon(Icons.location_on),
        ),
        BottomNavigationBarItem(
          label: "Ticket",
          icon: Icon(FontAwesomeIcons.ticketAlt),
        ),
        BottomNavigationBarItem(
          label: "User",
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
