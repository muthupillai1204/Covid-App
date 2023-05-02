import 'package:covid_23/Model/world_states.dart';
import 'package:covid_23/Pages/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/states_services.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorLists = <Color>[
    Colors.blue,
    Colors.orange,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 189, 163, 86),
          shadowColor: Colors.pink,
          title: const Text("World statistics"),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            //design for loading
                            color: Colors.black,
                            size: 50.0,
                            controller: _controller,
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            PieChart(
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left),
                                dataMap: {
                                  "Total": double.parse(
                                      snapshot.data!.cases!.toString()),
                                  "Recovered": double.parse(
                                      snapshot.data!.recovered.toString()),
                                  "Deaths": double.parse(
                                      snapshot.data!.deaths.toString()),
                                },
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true),
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                colorList: colorLists),
                            const SizedBox(
                              height: 3,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .03),
                              child: Card(
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    ReusableRow(
                                      title: "Total",
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Deaths",
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Recovered",
                                      value:
                                          snapshot.data!.recovered.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Active",
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Critical",
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Today Cases",
                                      value:
                                          snapshot.data!.todayCases.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Today Deaths",
                                      value:
                                          snapshot.data!.todayDeaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Today Recovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString(),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(240, 50),
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.all(15.0),
                                  // foregroundColor: Colors,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(29.0)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CountriesList()));
                                },
                                child: const Text("Track Countries"))
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Divider()
        ],
      ),
    );
  }
}
