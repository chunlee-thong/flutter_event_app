import 'package:flutter/material.dart';
import 'package:flutter_event_app/constant/text_style.dart';
import 'package:flutter_event_app/models/event_model.dart';
import 'package:flutter_event_app/pages/event_detail_page.dart';
import 'package:flutter_event_app/utils/app_utils.dart';
import 'package:flutter_event_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter_event_app/widgets/home_bg_color.dart';
import 'package:flutter_event_app/widgets/nearby_event_card.dart';
import 'package:flutter_event_app/widgets/ui_helper.dart';
import 'package:flutter_event_app/widgets/upcoming_event_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late ScrollController scrollController;
  late AnimationController controller;
  late AnimationController opacityController;
  late Animation<double> opacity;

  void viewEventDetail(Event event) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: EventDetailPage(event),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    scrollController = ScrollController();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..forward();
    opacityController = AnimationController(vsync: this, duration: const Duration(microseconds: 1));
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset, maxOffset: scrollController.position.maxScrollExtent / 2);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomeBackgroundColor(opacity),
          SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildSearchAppBar(),
                UIHelper.verticalSpace(16),
                buildUpComingEventList(),
                UIHelper.verticalSpace(16),
                buildNearbyConcerts(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomePageButtonNavigationBar(
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(FontAwesomeIcons.qrcode),
      ),
    );
  }

  Widget buildSearchAppBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Widget buildUpComingEventList() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Upcoming Events", style: headerStyle.copyWith(color: Colors.white)),
          UIHelper.verticalSpace(16),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: upcomingEvents.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final event = upcomingEvents[index];
                return UpComingEventCard(event: event, onTap: () => viewEventDetail(event));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNearbyConcerts() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text("Nearby Concerts", style: headerStyle),
              const Spacer(),
              const Icon(Icons.more_horiz),
              UIHelper.horizontalSpace(16),
            ],
          ),
          ListView.builder(
            itemCount: nearbyEvents.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              final event = nearbyEvents[index];
              var animation = Tween<double>(begin: 800.0, end: 0.0).animate(
                CurvedAnimation(
                  parent: controller,
                  curve: Interval((1 / nearbyEvents.length) * index, 1.0, curve: Curves.decelerate),
                ),
              );
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(animation.value, 0.0),
                  child: NearbyEventCard(
                    event: event,
                    onTap: () => viewEventDetail(event),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
