import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weathercourseapp/models/weaher_model.dart';

class ApiHelper{
    double? lat;
  double? long;
  getWeather(cityName)async{
    int? wid;
    List<WeatherModel>weatherList=[];

    var response1= await http.get(Uri.parse('https://www.metaweather.com/api/location/search/?query=$cityName'));
    var body1=jsonDecode(response1.body);
    wid=body1[0]['woeid'];

     var response2= await http.get(Uri.parse(
         'https://www.metaweather.com/api/location/$wid/'

     ));
    var body2=jsonDecode(response2.body);
     print(body1);
    print(body2);


print(wid);

    body2['consolidated_weather'].forEach((element){
      WeatherModel weathermodel= WeatherModel(
        cityName:body1[0]['title'],
        temp: element['the_temp'],
        icon: element['weather_state_abbr'],
        hightemp:element['max_temp'] ,
        lowtemp:element['min_temp'] ,
        date: element['created'],


      );
      weatherList.add(weathermodel);

    });
//    WeatherModel weathermodel= WeatherModel(
//        cityName:body1[0]['title'],
//      temp: body2['consolidated_weather'][0]['the_temp'],
//      icon: body2['consolidated_weather'][0]['weather_state_abbr'],
//      hightemp:body2['consolidated_weather'][0]['max_temp'] ,
//      lowtemp:body2['consolidated_weather'][0]['min_temp'] ,
//      date: body2['consolidated_weather'][0]['created'],
//
//    );
    //return weathermodel;

    return weatherList;

  }

  getLocation()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat=position.latitude;
    long=position.longitude;
    print(long);
    print(lat);
    var response1= await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=5ce93f0da3131f3c116918200827dced'
    ));
    var body1=jsonDecode(response1.body);
    print(body1);
    String name=body1['name'];
    double temp= body1['main']['temp'];

    print(name);
    print(temp);

    WeatherModel weathermodel= WeatherModel(
        cityName:body1['name'],
       temp: body1['main']['temp'],
    );
    return weathermodel;

  }
}
//'http://api.openweathermap.org/data/2.5/forecast?id=$wid&appid=5ce93f0da3131f3c116918200827dced'

//class ApiHelper{
//  double? lat;
//  double? long;
//  getWeather(cityName)async{
//    int? wid;
//    List<WeatherModel>weatherList=[];
//
//    var response1= await http.get(Uri.parse(
//'https://api.openweathermap.org/data/2.5/weather?lat=31.1123019&lon=30.942966&appid=5ce93f0da3131f3c116918200827dced'
//    ));
//    var body1=jsonDecode(response1.body);
//    wid=body1['id'];
//
//    var response2= await http.get(Uri.parse(
//'http://api.openweathermap.org/data/2.5/forecast?id=$wid&appid=5ce93f0da3131f3c116918200827dced'
//
//    ));
//    var body2=jsonDecode(response2.body);
//    print(body1);
//    print(body2);
//
//
//    print(wid);
//
//    body2['list'].forEach((element){
//      WeatherModel weathermodel= WeatherModel(
//        cityName:body1['name'],
//       temp: element['main']['temp'],
//        icon: element['weather'][0]['icon'],
//       hightemp:element['temp_max'] ,
//        lowtemp:element['temp_min'] ,
//        date: element['dt_txt'],
//
//
//      );
//      weatherList.add(weathermodel);
//
//    });
//
//
//    return weatherList;
//
//  }
//
//  getLocation()async{
//    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    lat=position.latitude;
//    long=position.longitude;
//    print(long);
//    print(lat);
//    var response1= await http.get(Uri.parse(
//        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=5ce93f0da3131f3c116918200827dced'
//    ));
//
//  }
//}