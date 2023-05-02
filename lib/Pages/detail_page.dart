import 'package:covid_23/Pages/world_states.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String name, image;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailPage(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 154, 190, 87),
          shadowColor: Colors.purple,
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  // padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color.fromARGB(255, 188, 203, 209),
                    child: Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableRow(
                          title: "Cases", value: widget.totalCases.toString()),
                      ReusableRow(
                          title: "Total Recovered",
                          value: widget.totalRecovered.toString()),
                      ReusableRow(
                          title: "Active", value: widget.active.toString()),
                      ReusableRow(
                          title: "Critical", value: widget.critical.toString()),
                      ReusableRow(
                          title: "Today Recovered",
                          value: widget.todayRecovered.toString()),
                      ReusableRow(title: "Test", value: widget.test.toString()),
                    ]),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ));
  }
}
