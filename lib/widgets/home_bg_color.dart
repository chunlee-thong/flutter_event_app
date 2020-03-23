import 'package:flutter/material.dart';
import 'package:flutter_event_app/constant/color.dart';

class HomeBackgroundColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -50,
            right: -10,
            child: Container(
              width: 150,
              height: 150,
              decoration: ShapeDecoration(shape: CircleBorder(), color: lime),
            ),
          ),
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 150,
              height: 150,
              decoration: ShapeDecoration(shape: CircleBorder(), color: orange),
            ),
          ),
          Positioned(
            top: -25,
            left: 70,
            child: Container(
              width: 45,
              height: 45,
              decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.white.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
