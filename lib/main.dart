import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_2_go_test/bottombar_navigation_fab_API.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'styles.dart' as styles;
import 'widget_utils.dart' show screenAwareSize;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      title: 'Tab bar test',
      home: DefaultTabController(
          length: 4,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(1, 137, 185, 0.7),
                elevation: 0.0,
                title: TopTabBar(),
              ),
              body: TabBarView(physics: BouncingScrollPhysics(), children: [
                MakeTabItem(title: 'Fusers', image: 'assets/images/fuser.jpg'),
                MakeTabItem(
                  title: 'Maint Kits',
                  image: 'assets/images/kit.jpg',
                ),
                MakeTabItem(
                  title: 'Tech Tips',
                  image: 'assets/images/01.jpg',
                ),
                MakeTabItem(
                  title: 'Instructions',
                  image: 'assets/images/02.jpg',
                ),
              ]),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
                bottomNavigationBar: FABBottomAppBar(
                  notchedShape: CircularNotchedRectangle(),
                  onTabSelected: _selectedTab,
                  color: Colors.blue,
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.white,
                  items: [
                    FABBottomAppBarItem(iconData: MdiIcons.facebook, text: "Facebook"),
                    FABBottomAppBarItem(iconData: MdiIcons.twitter, text: "Twitter"),
                    FABBottomAppBarItem(iconData: MdiIcons.linkedin, text: "LinkedIn"),
                    FABBottomAppBarItem(
                        iconData: MdiIcons.mapMarker, text: "Locations"),
                  ],
                ),
            ),
          )),
    );
  }

  void _selectedTab(int value) {
  }
}

class MakeTabItem extends StatelessWidget {
  final String title;
  final String image;

  const MakeTabItem({Key key, this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
        ),
        Container(
          color: Color.fromRGBO(1, 137, 185, 0.7),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                screenAwareSize(25.0, context),
                0.0,
                screenAwareSize(25.0, context),
                screenAwareSize(50.0, context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: screenAwareSize(10.0, context)),
                    child: AutoSizeText(
                      title.toUpperCase(),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                          letterSpacing: screenAwareSize(7.0, context),
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: screenAwareSize(60.0, context),
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: screenAwareSize(15.0, context)),
                    child: AutoSizeText(
                      "Here's some text to talk about something",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: screenAwareSize(15.0, context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenAwareSize(45.0, context)),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: screenAwareSize(15.0, context)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text(
                        'Click here to learn more',
                        style: TextStyle(
                            color: Color.fromRGBO(1, 137, 185, 1.0),
                            fontSize: screenAwareSize(15.0, context),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TopTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: styles.tabTextStyle(),
      labelPadding: EdgeInsets.symmetric(vertical: 12.0),
      labelColor: Colors.white,
      indicatorColor: Colors.white,
      indicator: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Colors.white, width: 2.0, style: BorderStyle.solid),
              bottom: BorderSide(
                  color: Colors.white, width: 2.0, style: BorderStyle.solid))),
      tabs: [
        Text(
          'Fusers',
        ),
        Text(
          'Maint Kits',
        ),
        Text(
          'Tech Tips',
        ),
        Text(
          'Instructions',
        ),
      ],
    );
  }
}
