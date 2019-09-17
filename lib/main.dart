import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          bottom: makeTabBar(),
        ),
        body: createTabBarView(
          (<Widget>[GridViewElement().build(), SimpleWidget()]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar makeTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.settings_applications),
        )
      ],
      controller: tabController,
    );
  }

  TabBarView createTabBarView(tabs) {
    return TabBarView(
      controller: tabController,
      children: tabs,
    );
  }
}

class SimpleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SimpleWidgetState();
}

class SimpleWidgetState extends State<SimpleWidget> {
  int stepCounter = 0;
  List<Step> steplist = [
    Step(
      title: Text("Take Photo"),
      content: Text("This Is Step One"),
      isActive: true,
    ),
    Step(
      title: Text("Edit Photos"),
      content: Text("dsfasdf"),
      isActive: true,
    ),
    Step(
      title: Text("File Settings"),
      content: Text("This Is Step Three"),
      isActive: true,
    ),
    Step(
      title: Text("Step Four"),
      content: Text("This Is Step Four"),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        currentStep: stepCounter,
        steps: steplist,
        type: StepperType.vertical,
        onStepTapped: (step) {
          setState(() {
            stepCounter = step;
          });
        },
        onStepCancel: () {
          setState(() {
            stepCounter > 0 ? stepCounter -= 1 : stepCounter = 0;
          });
        },
        onStepContinue: () {
          setState(
            () {
              stepCounter < steplist.length - 1
                  ? stepCounter += 1
                  : stepCounter = 0;
            },
          );
        },
      ),
    );
  }
}

class GridViewElement {
  Card createGridCell(String name, IconData icon) {
    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Center(child: Icon(icon)),
          Text(name),
        ],
      ),
    );
  }

  GridView build() {
    return GridView.count(
      primary: true,
      padding: EdgeInsets.all(1.0),
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        createGridCell("Home", Icons.home),
        createGridCell("Home", Icons.home),
        createGridCell("Home", Icons.home),
        createGridCell("Home", Icons.home),
        createGridCell("Home", Icons.home),
        createGridCell("Home", Icons.home),
      ],
    );
  }
}
