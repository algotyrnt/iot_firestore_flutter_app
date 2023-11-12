import 'package:flutter/foundation.dart';

@immutable
class Sensor {
  const Sensor({
    required this.humidity,
    required this.temperature,
    required this.voltage,
    required this.isSwitchedOn,
  });

  Sensor.fromJson(Map<String, Object?> json)
      : this(
          humidity: (json['humidity'] as num).toDouble(),
          temperature: (json['temperature'] as num).toDouble(),
          voltage: (json['voltage'] as num).toDouble(),
          isSwitchedOn: json['switch'] as bool,
        );

  final double humidity;
  final double temperature;
  final double voltage;
  final bool isSwitchedOn;

  Map<String, Object?> toJson() {
    return {
      'humidity': humidity,
      'temperature': temperature,
      'voltage': voltage,
      'switch': isSwitchedOn,
    };
  }
}
