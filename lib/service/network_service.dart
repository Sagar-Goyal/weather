import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkService {
  NetworkService({required this.url});
  final String url;
  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        Future.error("Some error occured!");
      }
    } catch (e) {
      rethrow;
    }
  }
}
