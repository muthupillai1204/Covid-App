//this concept is without model bcoz json starts from array and then objects[{}]
import 'package:covid_23/Pages/detail_page.dart';
import 'package:covid_23/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 136, 149, 223),
        shadowColor: Colors.amber,
        title: const Text("Countries List"),
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Search with country name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: statesServices.fetchCountriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.white,
                                        ))
                                  ],
                                ));
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              // debugPrint(snapshot.data as String?);
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                  )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(
                                          "Cases:- ${snapshot.data![index]['cases']}"),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                  )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(
                                          "Cases:- ${snapshot.data![index]['cases']}"),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }))
        ]),
      ),
    );
  }
}
