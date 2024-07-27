import 'dart:convert';

import 'package:covid_app/Models/WorldStats_Model.dart';
import 'package:covid_app/Services/Utilities/AppUrl.dart';
import 'package:http/http.dart' as http;

class StatsService {
  Future<WorldStatsModel> getWorldStats() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatsUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception("Error: Failed to retrieve data from Api");
    }
  }

  Future<List<dynamic>> getCountriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesListUrl));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Error: Failed to retrieve data from Api");
    }
  }
}
