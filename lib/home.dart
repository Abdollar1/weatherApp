import 'package:flutter/material.dart';
import 'package:cloud/weather.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final _cityTextController = TextEditingController();
  final _weatherData = weatherData();
  String cityName = '-';
  double temp = 0.0;
  String desc = '-';
  String icon = '_';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[600],
        appBar: AppBar(
          title: Text('Weather App'),
          centerTitle: true,
          elevation: 0.3,
          backgroundColor: Colors.black12,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(icon),
              //city Text
              Text(
                '$cityName',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              //temp text
              SizedBox(height: 20),
              Text(
                '$temp' + 'ºC',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              //description text
              Text(
                '${desc.toCapitalize()}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: _cityTextController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter City'.toUpperCase(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          //
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            tooltip: 'Increase volume by 10',
                            onPressed: _search,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //when the search button is pressed
  void _search() async {
    try {
      final response = await _weatherData.getWeather(_cityTextController.text);
      print(response.cityName);
      print(response.iconUrl);
      print(response.tempInfo.temperature);
      print(response.weatherInfo.description);

      setState(() {
        cityName = response.cityName;
        icon = response.iconUrl;
        temp = response.tempInfo.temperature;
        desc = response.weatherInfo.description;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error Message'),
          content: Text('Enter Valid City Name',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

extension CapitalizeEach on String {
  toCapitalize() {
    var names = this.contains(' ') ? this.split(' ') : ['-', '-'];
    return names[0][0].toUpperCase() +
        names[0].substring(1) +
        ' ' +
        names[1][0].toUpperCase() +
        names[1].substring(1);
  }
}
