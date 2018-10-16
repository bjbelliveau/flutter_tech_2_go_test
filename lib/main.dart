import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_2_go_test/bottombar_navigation_fab_API.dart';
import 'package:flutter_tech_2_go_test/maint_kit_pdf.dart';
import 'package:flutter_tech_2_go_test/pdf_list.dart';
import 'package:flutter_tech_2_go_test/product_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'styles.dart' as styles;
import 'widget_utils.dart' show screenAwareSize;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech 2 Go',
      home: MyHomePage(
        title: 'Tech 2 Go',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(1, 52, 136, 0.7),
          /*appBar: AppBar(
            backgroundColor: Color.fromRGBO(1, 137, 185, 0.7),
            elevation: 0.0,
            title: TopTabBar(),
          ),*/
          body: TabBarView(physics: BouncingScrollPhysics(), children: [
            MakeTabItem(title: 'Fusers', image: 'assets/images/fuser.jpg'),
            MakeTabItem(
              title: 'Maint Kits',
              image: 'assets/images/kit.jpg',
            ),
            MakeTabItem(
              title: 'Tech Tips',
              image: 'assets/images/techtips.png',
            ),
            MakeTabItem(
              title: 'Instructions',
              image: 'assets/images/instructions.jpg',
            ),
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromRGBO(224, 178, 11, 1.0),
            onPressed: () {},
            child: Icon(Icons.contact_phone),
          ),
          bottomNavigationBar: FABBottomAppBar(
//            notchedShape: CircularNotchedRectangle(),
            onTabSelected: (int) {},
            color: Color.fromRGBO(1, 57, 136, 1.0),
            selectedColor: Color.fromRGBO(1, 57, 136, 1.0),
            backgroundColor: Colors.white,
            items: [
              FABBottomAppBarItem(
                  iconData: MdiIcons.facebook, text: "Facebook"),
              FABBottomAppBarItem(iconData: MdiIcons.twitter, text: "Twitter"),
              FABBottomAppBarItem(
                  iconData: MdiIcons.linkedin, text: "LinkedIn"),
              FABBottomAppBarItem(
                  iconData: MdiIcons.mapMarker, text: "Locations"),
            ],
          ),
        ),
      ),
    );
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
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color.fromRGBO(1, 52, 136, 0.7), BlendMode.srcATop)),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: screenAwareSize(10.0, context)),
            child: TopTabBar(),
          ),
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
                          fontWeight: FontWeight.w500),
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
                        horizontal: screenAwareSize(25.0, context)),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: screenAwareSize(15.0, context)),
                      onPressed: () {
                        Navigator.push(context, getPageRoute(title));
                      },
                      color: Colors.white,
                      child: Text(
                        'CLICK HERE TO LEARN MORE',
                        style: TextStyle(
                            color: Color.fromRGBO(1, 52, 136, 1.0),
                            fontSize: screenAwareSize(13.0, context),
                            fontFamily: 'Montserrat',
                            ),
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

  navigateToListPage(String title) {}

  MaterialPageRoute getPageRoute(String title) {
    if (title.toLowerCase() == 'fusers' ||
        title.toLowerCase() == 'maint kits') {
      return MaterialPageRoute(
          builder: (context) => ProductList(
                title: title,
              ));
    } else if (title.toLowerCase() == "tech tips") {
      return MaterialPageRoute(
          builder: (context) => PdfList(
                title: title,
              ));
    } else {
      return MaterialPageRoute(
          builder: (context) => MaintKitPdfList(
                title: "Maint Kits",
              ));
    }
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
