library localizer.globals;

double lat;
double long;

/// save weatherResponse
var weatherResponse;

/// save Forecasts Response
var forecastResponse;

///setting a default value
DateTime lastWeatherUpdateDateTime =
    DateTime.now().subtract(Duration(minutes: 30));

/// Global sharedPreferences Keys
const TEMP_UNIT_PREF = 'tempUnitPref';
const WIND_UNIT_PREF = 'windUnitPref';

///----------[Settings]---------///
/// weather  default preferences
const DEFAULT_TEMP_UNIT = 'C';
const DEFAULT_WIND_UNIT = 'mph';

/// weather preferences
var tempUnit = 'C';
var windUnit = 'mph';
///----------[Global Function]---///
/// Avoid Code Duplication
/// calculate Temp
String globalTempPreferredUnit(double value) {
  if (tempUnit != null) {
    if (tempUnit == 'C') {
      var _parsedValue = (value - 273.15).toStringAsFixed(0);
      return '$_parsedValue °C';
    } else if (tempUnit == 'F') {
      var _parsedValue = ((value - 273.15) * 9 / 5 + 32).toStringAsFixed(0);
      return '$_parsedValue °F';
    } else if (tempUnit == 'K') {
      var _parsedValue = value.toStringAsFixed(0);
      return '$_parsedValue K';
    } else {
      return 'N/A';
    }
  } else {
    return 'N/A';
  }
}

/// Calculate Wind Speed
String globalWindPreferredUnit(double value) {
  if (windUnit != null) {
    if (windUnit== 'mph') {
      var _parsedValue = ((value*3.6)*0.621371).toStringAsFixed(0);
      return '$_parsedValue mph';
    } else if (windUnit == 'km/h') {
      var _parsedValue = (value* 3.6).toStringAsFixed(0);
      return '$_parsedValue km/h';
    } else if (windUnit == 'kn') {
      var _parsedValue = ((value*3.6)*0.539957).toStringAsFixed(0);
      return '$_parsedValue kn';
    } else if (windUnit == 'm/s') {
      return '$value m/s';
    } else {
      return 'N/A';
    }
  } else {
    return 'N/A';
  }
}
