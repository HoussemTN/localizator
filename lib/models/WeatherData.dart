import '../libraries/globals.dart' as globals;

class WeatherData {
  final DateTime date;
  final String name;
  final String temp;
  final String main;
  final String description;
  final String icon;
  final int humidity;
  final DateTime sunrise;
  final DateTime sunset;
  final String windSpeed;
   var pressure;

  WeatherData(
      {this.date,
      this.name,
      this.temp,
      this.main,
      this.description,
      this.icon,
      this.humidity,
      this.sunrise,
      this.sunset,
      this.windSpeed,
      this.pressure});
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(
        (json['dt'] + json['timezone']) * 1000,
        isUtc: true,
      ),
      name: json['name'],
      temp : globals.globalTempPreferredUnit((double.parse(json['main']['temp'].toString()))),
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      sunrise: new DateTime.fromMillisecondsSinceEpoch(
          (json['sys']['sunrise'] + json['timezone']) * 1000,
          isUtc: true),
      sunset: new DateTime.fromMillisecondsSinceEpoch(
          (json['sys']['sunset'] + json['timezone']) * 1000,
          isUtc: true),
      //converting WindSpeed from m/s to Km/h
      windSpeed:globals.globalWindPreferredUnit((double.parse(json['wind']['speed'].toString()))),
      pressure: num.parse(json['main']['pressure'].toStringAsFixed(0)),
    );
  }

}
