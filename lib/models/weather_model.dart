class WeatherModel {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherModel({required this.location, required this.current, required this.forecast});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      tzId: json['tz_id'],
      localtime: json['localtime'],
    );
  }
}

class Current {
  final double tempC;
  final double tempF;
  final String conditionText;
  final String conditionIcon;
  final double windKph;
  final int humidity;
  final double feelsLikeC;
  final double pressureMb;

  Current({
    required this.tempC,
    required this.tempF,
    required this.conditionText,
    required this.conditionIcon,
    required this.windKph,
    required this.humidity,
    required this.feelsLikeC,
    required this.pressureMb,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      conditionText: json['condition']['text'],
      conditionIcon: json['condition']['icon'],
      windKph: json['wind_kph'],
      humidity: json['humidity'],
      feelsLikeC: json['feelslike_c'],
      pressureMb: json['pressure_mb'],
    );
  }
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var list = json['forecastday'] as List;
    List<ForecastDay> forecastDaysList = list.map((i) => ForecastDay.fromJson(i)).toList();

    return Forecast(forecastday: forecastDaysList);
  }
}

class ForecastDay {
  final String date;
  final Day day;
  final Astro astro;
  final List<Hour> hour;

  ForecastDay({required this.date, required this.day, required this.astro, required this.hour});

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    var hourList = json['hour'] as List;
    List<Hour> hours = hourList.map((i) => Hour.fromJson(i)).toList();

    return ForecastDay(
      date: json['date'],
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hour: hours,
    );
  }
}

class Day {
  final double maxTempC;
  final double minTempC;
  final String conditionText;
  final String conditionIcon;
  final double uv;

  Day({
    required this.maxTempC,
    required this.minTempC,
    required this.conditionText,
    required this.conditionIcon,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      conditionText: json['condition']['text'],
      conditionIcon: json['condition']['icon'],
      uv: json['uv'],
    );
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonPhase;

  Astro({required this.sunrise, required this.sunset, required this.moonPhase});

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonPhase: json['moon_phase'],
    );
  }
}

class Hour {
  final String time;
  final double tempC;
  final String conditionText;
  final String conditionIcon;
  final double windKph;
  final int humidity;

  Hour({
    required this.time,
    required this.tempC,
    required this.conditionText,
    required this.conditionIcon,
    required this.windKph,
    required this.humidity,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: json['time'],
      tempC: json['temp_c'],
      conditionText: json['condition']['text'],
      conditionIcon: json['condition']['icon'],
      windKph: json['wind_kph'],
      humidity: json['humidity'],
    );
  }
}
