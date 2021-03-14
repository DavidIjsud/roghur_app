import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:roghurapp/constants/common_text.dart';

class Fetch {
  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<dynamic> get(String url) async {
    try {
      final response = await http.get(url);
      final resJson = json.decode(response.body);
      if (response.statusCode == 200) return resJson;
      throw new Exception(resJson['message'] ?? CommonText.error);
    } catch (e) {
      if (e.runtimeType == SocketException)
        throw new Exception(CommonText.noConnection);
      throw new Exception(e.message);
    }
  }

  static Future<dynamic> post(String url, dynamic data) async {
    try {
      final response =
          await http.post(url, body: json.encode(data), headers: headers);
      final resJson = json.decode(response.body);
      if (response.statusCode == 200) return resJson;
      throw new Exception(resJson['message'] ?? CommonText.error);
    } catch (e) {
      if (e.runtimeType == SocketException)
        throw new Exception(CommonText.noConnection);
      throw new Exception(e.message);
    }
  }

  static Future<dynamic> put(String url, dynamic data) async {
    try {
      final response =
          await http.put(url, body: json.encode(data), headers: headers);
      final resJson = json.decode(response.body);
      if (response.statusCode == 200) return resJson;
      throw new Exception(resJson['message'] ?? CommonText.error);
    } catch (e) {
      if (e.runtimeType == SocketException)
        throw new Exception(CommonText.noConnection);
      throw new Exception(e.message);
    }
  }

  static Future<dynamic> delete(String url) async {
    try {
      final response = await http.delete(url, headers: headers);
      final resJson = json.decode(response.body);
      if (response.statusCode == 200) return resJson;
      throw new Exception(resJson['message'] ?? CommonText.error);
    } catch (e) {
      if (e.runtimeType == SocketException)
        throw new Exception(CommonText.noConnection);
      throw new Exception(e.message);
    }
  }

  String hasConnection() => 'No hay';
}
