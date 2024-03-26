import 'package:flutter/material.dart';
import './Networking.dart';

class CitiesSearchDelegate extends SearchDelegate {
  var citiesList = [];
  var canadianCities = [
    "Toronto, ON, Canada",
    "London, ON, Canada",
    "North York, ON, Canada"
  ];
  Future getAllCityFromAPI(String searchText) async {
    if (searchText.length > 2) {
      var list = await Networking().getAllCities(searchText);
      citiesList = list;
      return list;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
            citiesList = [];
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: getAllCityFromAPI(query),
      builder: (context, snapshot) {
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            title: Text(citiesList[index]),
          ),
          itemCount: citiesList.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: getAllCityFromAPI(query),
      builder: (context, snapshot) {
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (cnx) => AlertDialog(
                        title: const Text('Save to Database?'),
                        content: const Text(
                            "Are you sure you want to save this city to Database?"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Networking.saveCityToFirebase(
                                    citiesList[index] as String);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("Yes")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/weather',
                                    arguments: [
                                      1,
                                      citiesList[index] as String,
                                      0.0,
                                      0.0
                                    ]);
                              },
                              child: const Text("No")),
                        ],
                      ));
            },
            title: Text(citiesList[index]),
          ),
          itemCount: citiesList.length,
        );
      },
    );
    // return ListView.builder(
    //   itemBuilder: (context, index) => ListTile(
    //     onTap: () {},
    //     title: Text(canadianCities[index]),
    //   ),
    //   itemCount: canadianCities.length,
    // );
  }
}
