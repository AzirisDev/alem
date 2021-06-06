import 'package:intl/intl.dart';

class CityModel {
  final double temp;
  final int pressure;
  final int humidity;
  final double tempMin;
  final double tempMax;
  final String time;
  final bool isDayTime;

  CityModel(this.temp, this.pressure, this.humidity, this.tempMin, this.tempMax,
      this.time, this.isDayTime);

  double get getTemp => temp - 272.5;

  double get getMinTemp => tempMin - 272.5;

  double get getMaxTemp => tempMax - 272.5;

  factory CityModel.fromJson(
      Map<String, dynamic> jsonWeather, Map<String, dynamic> jsonTime) {
    String dateTime = jsonTime['utc_datetime'];
    String offset = jsonTime['utc_offset'];

    String plus = offset.substring(1, 3);

    DateTime now = DateTime.parse(dateTime);

    now = now.add(Duration(hours: int.parse(plus)));

    String time = DateFormat.jm().format(now);

    bool isDayTime = now.hour >= 6 && now.hour < 20 ? true : false;

    return CityModel(
      jsonWeather['temp'] - 272.1,
      jsonWeather['pressure'],
      jsonWeather['humidity'],
      jsonWeather['temp_min'] - 272.1,
      jsonWeather['temp_max'] - 272.1,
      time,
      isDayTime,
    );
  }
}
