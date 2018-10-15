import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'styles.dart' as style;

class TopTabBar extends StatefulWidget {
  @override
  _TopTabBarState createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar>
    with SingleTickerProviderStateMixin {
  final List<Tab> topTabs = [
    Tab(
      text: 'Fusers',
    ),
    Tab(
      text: 'Maint Kits',
    ),
    Tab(
      text: 'Tech Tips',
    ),
    Tab(
      text: 'Instructions',
    ),
  ];

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: TabBar(
          labelStyle: style.tabTextStyle(),
          tabs: topTabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: topTabs.map((Tab tab) {
          return Center(
            child: AutoSizeText(
              tab.text,
              maxLines: 1,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: topTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
