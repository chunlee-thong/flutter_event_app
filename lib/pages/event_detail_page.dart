import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_event_app/constant/color.dart';
import 'package:flutter_event_app/constant/text_style.dart';
import 'package:flutter_event_app/models/event_model.dart';
import 'package:flutter_event_app/utils/datetime_utils.dart';
import 'package:flutter_event_app/widgets/ui_helper.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;
  EventDetailPage(this.event);
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> with SingleTickerProviderStateMixin {
  Event event;
  AnimationController controller;
  Animation<double> scale;
  bool isFavorite = false;
  @override
  void initState() {
    event = widget.event;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildHeaderImage(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildEventTitle(),
                          UIHelper.verticalSpace(16),
                          buildEventDate(),
                          UIHelper.verticalSpace(24),
                          buildAboutEvent(),
                          UIHelper.verticalSpace(24),
                          buildOrganizeInfo(),
                          UIHelper.verticalSpace(24),
                          buildEventLocation(),
                          UIHelper.verticalSpace(100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                child: buildPriceInfo(),
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderImage() {
    double maxHeight = MediaQuery.of(context).size.height;
    double minimumScale = 0.8;
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        controller.value += detail.primaryDelta / maxHeight * 2;
      },
      onVerticalDragEnd: (detail) {
        if (scale.value > minimumScale) {
          controller.reverse();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.5,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Hero(
                tag: event.image,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
                  child: Image.network(
                    event.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            buildHeaderButton(),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderButton() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.only(left: 16, top: 16),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            color: Colors.white60,
          ),
          Card(
            shape: CircleBorder(),
            margin: EdgeInsets.only(right: 16, top: 16),
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () => setState(() => isFavorite = !isFavorite),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
              ),
            ),
            color: Theme.of(context).primaryColor.withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  Widget buildEventTitle() {
    return Container(
      child: Text(
        event.name,
        style: headerStyle.copyWith(fontSize: 32),
      ),
    );
  }

  Widget buildEventDate() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("${DateTimeUtils.getMonth(event.eventDate)}", style: monthStyle),
                Text("${DateTimeUtils.getDayOfMonth(event.eventDate)}", style: titleStyle),
              ],
            ),
          ),
          UIHelper.horizontalSpace(12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(DateTimeUtils.getDayOfWeek(event.eventDate), style: titleStyle),
              UIHelper.verticalSpace(4),
              Text("10:00 - 12:00 PM", style: subtitleStyle),
            ],
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: ShapeDecoration(shape: StadiumBorder(), color: primaryLight),
            child: Row(
              children: <Widget>[
                UIHelper.horizontalSpace(8),
                Text("Add To Calendar", style: subtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAboutEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("About", style: headerStyle),
        UIHelper.verticalSpace(),
        Text(event.description, style: subtitleStyle),
        UIHelper.verticalSpace(8),
        InkWell(
          child: Text(
            "Read more...",
            style: TextStyle(color: Theme.of(context).primaryColor, decoration: TextDecoration.underline),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget buildOrganizeInfo() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          child: Text(event.organizer[0]),
        ),
        UIHelper.horizontalSpace(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.organizer, style: titleStyle),
            UIHelper.verticalSpace(4),
            Text("Organizer", style: subtitleStyle),
          ],
        ),
        Spacer(),
        FlatButton(
          child: Text("Follow", style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () {},
          shape: StadiumBorder(),
          color: primaryLight,
        )
      ],
    );
  }

  Widget buildEventLocation() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/map.jpg',
        height: MediaQuery.of(context).size.height / 3,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildPriceInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Price", style: subtitleStyle),
              UIHelper.verticalSpace(8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "\$${event.price}", style: titleStyle.copyWith(color: Theme.of(context).primaryColor)),
                    TextSpan(text: "/per person", style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          RaisedButton(
            onPressed: () {},
            shape: StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: Theme.of(context).primaryColor,
            child: Text(
              "Get a Ticket",
              style: titleStyle.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
