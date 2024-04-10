import 'dart:developer';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Api {
  String token;

  Api(this.token);

  Future<void> postData(String latitude, String longitude) async {
    try {
      var _headers = {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader: 'application/vnd.api+json'
      };

      // inspect(id);

      final url =
          Uri.parse('http://192.168.254.195:8082/api/v1/data/log/update/gps');
      final response = await http.post(
        url,
        headers: _headers,
        body: json.encode({'latitude': latitude, 'longitude': longitude}),
      );
      final extractedData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      inspect(extractedData);
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }

      inspect(extractedData['message']);
    } catch (error) {
      rethrow;
    }
  }
}
