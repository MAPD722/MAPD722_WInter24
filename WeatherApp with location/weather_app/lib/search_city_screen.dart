import 'package:flutter/material.dart';
import 'package:weather_app/Networking.dart';
import 'package:weather_app/searchDelegate.dart';

class SearchForCityScreen extends StatefulWidget {
  const SearchForCityScreen({super.key});

  @override
  State<SearchForCityScreen> createState() => _SearchForCityScreenState();
}

class _SearchForCityScreenState extends State<SearchForCityScreen> {
  var list = [];

  Future<void> getAllCities() async {
    var dblist = await Networking.getAllCitiesFromDB();
    setState(() {
      list = dblist;
    });
  }

  @override
  initState() {
    super.initState();
    getAllCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fav Cities'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: CitiesSearchDelegate());
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: getAllCities,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(list.elementAt(index)),
                onTap: () {
                  Navigator.pushNamed(context, '/weather', arguments: [
                    1,
                    list.elementAt(index) as String,
                    0.0,
                    0.0
                  ]);
                },
              );
            }),
          ),
        ));
  }
}
