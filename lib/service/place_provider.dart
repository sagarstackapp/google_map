import 'dart:convert';
import 'package:google_map/common/constant/string.dart';
import 'package:google_map/service/suggestion_service.dart';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&components=country:ch&key=${StringResources.AndroidAPIKey}';
    print('url --> $request');
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print('Result --> $result');
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
