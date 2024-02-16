import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pitch_pulse_football_world/player_injuri.dart';

class FootballFix extends StatefulWidget {
  const FootballFix({super.key});

  @override
  State<FootballFix> createState() => _FootballFixState();
}

class _FootballFixState extends State<FootballFix> {
  Map<String, dynamic> footballfix = {};

  bool isScoreLoading = true;

  footballFix() async {
    var headers = {
      'X-RapidAPI-Key': '64a0a0da7emsh85e2fd2975d435fp197eb0jsn2bb9bfebada6',
      'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com'
    };
    var request1 = http.Request(
        'GET',
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v3/fixtures?last=50'));
    request1.headers.addAll(headers);
    http.StreamedResponse response = await request1.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);
      footballfix = body;
      setState(() {
        footballfix;
        print('footballfix = $footballfix');
        isScoreLoading = false;
      });
      if (footballfix.isEmpty) {
        print('No data found.');
      }
    } else {
      print(response.reasonPhrase);
      setState(() {
        isScoreLoading = false;
      });
    }
  }

  @override
  void initState() {
    footballFix();

    super.initState();
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
          'Football Fixture',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Column(
            children: [
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                      color: Colors.red.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerInjuriesChart()));
                      },
                      child: Text(
                        'Players Injuries',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ))
                ],
              ),
              isScoreLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          itemCount: 45,
                          itemBuilder: (context, index) {
                            if (footballfix == null) {
                              return Text('null no data here');
                            } else {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.red.shade100),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                footballfix['response'][index]
                                                    ['league']['logo'],
                                                height: 50,
                                                width: 50,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Name',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              footballfix['response'][index]
                                                  ['league']['name'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Country',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              footballfix['response'][index]
                                                  ['league']['country'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Season',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              footballfix['response'][index]
                                                      ['league']['season']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Round',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              footballfix['response'][index]
                                                  ['league']['round'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
