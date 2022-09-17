import 'dart:convert';

import 'package:flutter_dot_env_demo/auto_complete_prediction.dart';

class PlaceAutoCompleteResponse {
  final String? status;
  final List<AutoCompletePrediction>? prediction;

  PlaceAutoCompleteResponse({this.status, this.prediction});

  factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutoCompleteResponse(
        status: json['status'] as String?,
        prediction: json['prediction'] != null
            ? json['prediction']
                .map<AutoCompletePrediction>(
                    (json) => AutoCompletePrediction.fromJson(json))
                .toList()
            : null);
  }

  static PlaceAutoCompleteResponse parseAutoCompleteResult(
      String responseBody) {
    final parsed = jsonDecode(responseBody).cast<String, dynamic>();
    return PlaceAutoCompleteResponse.fromJson(parsed);
  }
}
