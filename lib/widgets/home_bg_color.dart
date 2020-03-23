import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_event_app/constant/color.dart';

class HomeBackgroundColor extends AnimatedWidget {
  final Animation<double> opacity;
  HomeBackgroundColor(this.opacity) : super(listenable: opacity);

  Animation<double> get progress => listenable;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              height: (MediaQuery.of(context).size.height / 2.5) * progress.value,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(lerpDouble(0.5, 1.0, progress.value)),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
            ),
          ),
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
            top: -80 * (progress.value) - 50 * (1 - progress.value),
            left: -60,
            child: Container(
              width: 150 * (1 - progress.value) + 150,
              height: 150 * (1 - progress.value) + 150,
              decoration: ShapeDecoration(shape: CircleBorder(), color: orange),
            ),
          ),
        ],
      ),
    );
  }
}
