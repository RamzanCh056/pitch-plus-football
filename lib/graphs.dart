import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pitch_pulse_football_world/football_fix.dart';

class PlayerProgress {
  final String player;
  final int progress;

  PlayerProgress(this.player, this.progress);
}

class PlayerProgressChart extends StatefulWidget {
  @override
  _PlayerProgressChartState createState() => _PlayerProgressChartState();
}

class _PlayerProgressChartState extends State<PlayerProgressChart> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a 2-second loading delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PlayerProgress> data = [
      PlayerProgress('Messi', 90),
      PlayerProgress('Ronaldo', 85),
      PlayerProgress('Neymar', 80),
      PlayerProgress('Mbappe', 75),
      PlayerProgress('Salah', 70),
    ];

    List<PlayerProgress> progress = [
      PlayerProgress('Lewandowski', 70),
      PlayerProgress('Sergio', 85),
      PlayerProgress('Bruyne', 80),
      PlayerProgress('Virgil', 75),
      PlayerProgress('Joshua', 78),
    ];

    var series = [
      charts.Series(
        id: 'Players',
        data: data,
        domainFn: (PlayerProgress player, _) => player.player,
        measureFn: (PlayerProgress player, _) => player.progress,
        colorFn: (PlayerProgress player, _) {
          // Assign different colors to each player
          if (player.player == 'Messi') {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (player.player == 'Ronaldo') {
            return charts.MaterialPalette.yellow.shadeDefault;
          } else if (player.player == 'Neymar') {
            return charts.MaterialPalette.green.shadeDefault;
          } else if (player.player == 'Mbappe') {
            return charts.MaterialPalette.purple.shadeDefault;
          } else {
            return charts.MaterialPalette.red.shadeDefault;
          }
        },
        labelAccessorFn: (PlayerProgress player, _) => '${player.progress}%',
      ),
    ];

    var series1 = [
      charts.Series(
        id: 'Player Progress',
        data: progress,
        domainFn: (PlayerProgress player, _) => player.player,
        measureFn: (PlayerProgress player, _) => player.progress,
        colorFn: (PlayerProgress player, _) {
          // Assign different colors to each player
          if (player.player == 'Lewandowski') {
            return charts.MaterialPalette.red.shadeDefault;
          } else if (player.player == 'Sergio') {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (player.player == 'Bruyne') {
            return charts.MaterialPalette.yellow.shadeDefault;
          } else if (player.player == 'Virgil') {
            return charts.MaterialPalette.purple.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        labelAccessorFn: (PlayerProgress player, _) => '${player.progress}%',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color for the icons
        ),
        backgroundColor: Colors.red.shade900,
        title: Text(
          'Players Progress',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            color: Colors.red.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FootballFix(),
                                ),
                              );
                            },
                            child: Text(
                              'Football Fixtures',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 400,
                        child: charts.BarChart(
                          series,
                          animate: true,
                          barGroupingType: charts.BarGroupingType.grouped,
                          behaviors: [charts.SeriesLegend()],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: 400,
                        child: charts.BarChart(
                          series1,
                          animate: true,
                          barGroupingType: charts.BarGroupingType.grouped,
                          behaviors: [charts.SeriesLegend()],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
