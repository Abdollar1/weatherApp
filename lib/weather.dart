import 'dart:convert';

import 'package:cloud/model.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class weatherData{

  Future<WeatherResponse> getWeather(String city) async{
// api.openweathermap.org/data/2.5/weather?q=tarkwa&appid=3f4686adb6e7bdc7d83251a2f09959bd

    final query = {
    'q': city,
        'appid' : '3f4686adb6e7bdc7d83251a2f09959bd',
     'units' : 'metric'
  };
  final uri = Uri.https('api.openweathermap.org' , '/data/2.5/weather', query);

 final response = await http.get(uri);
 print(response.body);

 final json = jsonDecode(response.body);

 return WeatherResponse.fromJson(json);
  }

}