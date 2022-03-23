import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class WeatherData {
  final int longitude;
  final int latitude;
  final Map<String, num> main_data;

  //Constructor
  const WeatherData(
      {required this.longitude,
      required this.latitude,
      required this.main_data});

  @override
  List<Object> get props => [longitude, latitude, main_data];

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    // error check
    // if (map == null) return null;
    return WeatherData(
        longitude: map['longitude'],
        latitude: map['latitude'],
        main_data: map['main']);
  }
}
