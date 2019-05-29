class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final String main;
 final String description ;
  final String icon;
  final int humidity ;
  final DateTime sunrise ;
  final DateTime sunset ;

  WeatherData({this.date, this.name, this.temp, this.main,this.description, this.icon,this.humidity,this.sunrise,this.sunset});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt']*1000, isUtc: false),
      name: json['name'],
      temp: json['main']['temp'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      sunrise:  new DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise']*1000, isUtc: false),
      sunset: new DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset']*1000, isUtc: false),
    );
  }
}