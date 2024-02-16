import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlayerInjuries {
  final String playerName;
  final int injuries;
  final Color color; // New attribute for color

  PlayerInjuries(this.playerName, this.injuries, this.color);
}

class PlayerInjuriesChart extends StatefulWidget {
  @override
  _PlayerInjuriesChartState createState() => _PlayerInjuriesChartState();
}

class _PlayerInjuriesChartState extends State<PlayerInjuriesChart> {
  Future<bool>? _dataLoaded;

  @override
  void initState() {
    super.initState();
    _dataLoaded = fetchData(); // Function to simulate data loading
  }

  Future<bool> fetchData() async {
    // Simulate data loading delay
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color for the icons
        ),
        backgroundColor: Colors.red.shade900,
        title: Text(
          'Injuries',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: _dataLoaded,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 450,
                    child: charts.BarChart(
                      _createSampleData(),
                      animate: true,
                      barGroupingType: charts.BarGroupingType.grouped,
                      behaviors: [charts.SeriesLegend()],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  List<charts.Series<PlayerInjuries, String>> _createSampleData() {
    final data = [
      PlayerInjuries('Messi', 3, Colors.blue),
      PlayerInjuries('Sergio', 2, Colors.green),
      PlayerInjuries('Ronaldo', 5, Colors.red),
      PlayerInjuries('Virgil', 1, Colors.yellow),
      // Add more data as needed
    ];

    return [
      charts.Series<PlayerInjuries, String>(
        id: 'Injuries',
        domainFn: (PlayerInjuries injuries, _) => injuries.playerName,
        measureFn: (PlayerInjuries injuries, _) => injuries.injuries,
        colorFn: (PlayerInjuries injuries, _) =>
            charts.ColorUtil.fromDartColor(injuries.color),
        data: data,
      ),
    ];
  }
}
