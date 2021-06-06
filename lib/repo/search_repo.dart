import 'package:alem/src/city_model.dart';
import 'package:alem/src/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SearchRepository {
  Future<CityModel> getInfo({required String city}) async {
    //weather
    final weather = await http.Client().get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    if (weather.statusCode != 200) {
      print('error weather');
      throw Exception();
    }

    //time
    Response time = http.Response('', 404);

    for(int i = 0; i < 9; i++){
      String search = '${timezones[i]}/$city';
      try{
        time = await http.Client().get(
            Uri.parse("http://www.worldtimeapi.org/api/timezone/$search"));
      } catch (e) {
      // ignore: empty_catches
      }

      if(time.statusCode == 200){
        break;
      }

    }

    return parsedJson(weather.body, time.body);
  }

  CityModel parsedJson(final responseWeather, final responseTime) {
    final jsonDecodedWeather = json.decode(responseWeather);

    final jsonWeather = jsonDecodedWeather["main"];

    final Map<String, dynamic> jsonTime = jsonDecode(responseTime);

    return CityModel.fromJson(jsonWeather, jsonTime);
  }
}
