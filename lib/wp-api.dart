import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchwpPosts() async {

final response = await http.get(Uri.parse('https://mwnation.com/wp-json/wp/v2/posts'),
  headers: {"Accept": "application/json"}
);

var convertedDatatoJson = jsonDecode(response.body);
  
  return convertedDatatoJson;
}

Future fetchwpPostImageUrl(href) async {

final response = await http.get(Uri.parse(href),
headers: {"Accept": "application/json"}
);

var convertedDatatoJson = jsonDecode(response.body);
  print('ssss $convertedDatatoJson');
  return convertedDatatoJson;
}


