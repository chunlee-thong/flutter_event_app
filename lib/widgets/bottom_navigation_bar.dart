import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageButtonNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  HomePageButtonNavigationBar({@required this.currentIndex, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          title: Text("Explore"),
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          title: Text("Map"),
          icon: Icon(Icons.location_on),
        ),
        BottomNavigationBarItem(
          title: Text("Ticket"),
          icon: Icon(FontAwesomeIcons.ticketAlt),
        ),
        BottomNavigationBarItem(
          title: Text("User"),
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
