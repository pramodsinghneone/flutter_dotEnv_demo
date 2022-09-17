import 'package:flutter/material.dart';
import 'package:flutter_dot_env_demo/auto_complete_prediction.dart';
import 'package:flutter_dot_env_demo/constants.dart';
import 'package:flutter_dot_env_demo/network_utils.dart';
import 'package:flutter_dot_env_demo/search_result_list_tile.dart';

import 'place_auto_complete_response.dart';

class PlacesSearchView extends StatefulWidget {
  PlacesSearchView({Key? key}) : super(key: key);

  @override
  State<PlacesSearchView> createState() => _PlacesSearchViewState();
}

class _PlacesSearchViewState extends State<PlacesSearchView> {
  TextEditingController searchController = TextEditingController();
  List<AutoCompletePrediction>? predictionList = [];

  void placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/autocomplete/json', //unencoder path
      {
        'input': query, // query params
        'key': placesAPIKey,
      },
    );

    String? response = await NetworkUtils.fetchUrl(uri);
    if (response != null) {
      print(response);
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.parseAutoCompleteResult(response);
      if (result.prediction != null) {
        setState(() {
          predictionList = result.prediction;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Places'),
        actions: [
          IconButton(
              onPressed: () {
                placeAutoComplete('Mumbai');
              },
              icon: const Icon(
                Icons.location_searching,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  placeAutoComplete(value);
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: predictionList!.length,
                itemBuilder: (context, index) {
                  return SerchResultListTile(
                    location: predictionList![index].description!,
                    press: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
