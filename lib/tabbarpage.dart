import 'package:flutter/material.dart';
import 'tabs/images.dart';
import 'tabs/videos.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: TabBar(
                unselectedLabelColor: Colors.white,
                labelColor: Colors.black87,
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                indicator: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(5),
                ),
                tabs: const [
                  Tab(
                    text: 'Photos',
                  ),
                  Tab(
                    text: 'Vidéos',
                  ),
                ]),
          ),
          body: const TabBarView(
            children: [
              ImageTab(),
              VideoTab(),
            ],
          )));
}
