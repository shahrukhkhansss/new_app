import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  
  final String baseUrl = 'https://newsapi.org/v2';
  
  get data => null;

  Future<dynamic> getNews(String query) async {
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=$data&apiKey=eb0dd195d0e44cafae75d3ebb28fa34e',
    );

    final response = await http.get(url);
    print(url.toString());

    if (response.statusCode == 200) {
      var dataResponse = jsonDecode(response.body);
      print("Data Response: $dataResponse");
      return dataResponse;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}
