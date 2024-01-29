import 'package:flutter/material.dart';
import 'package:weather/constants/weather_constants.dart';
import 'package:weather/enums/day.dart';

class HourlyWeather extends StatelessWidget {
  const HourlyWeather({
    super.key,
    required this.index,
    required this.day,
    required this.weatherCode,
    required this.temperature,
  });
  final int index;
  final Day day;
  final int weatherCode;
  final int temperature;

  @override
  Widget build(BuildContext context) {
    int time = index <= 12 ? index : index - 12;
    String meredian = index < 12 ? "am" : "pm";
    int currentTime = DateTime.now().hour;
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: index == currentTime && day == Day.today ? null : const Color(0xFF282828),
        gradient: index == currentTime && day == Day.today
            ? const LinearGradient(
                colors: [Color(0xFFDA03F8), Color(0xFF3960F2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "$time $meredian",
            style: TextStyle(
              color:
                  index == currentTime && day == Day.today ? Colors.white : const Color(0xFF6D6D6D),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            flex: 3,
            child: Image.asset(
              weatherCodeToImage[weatherCode]!,
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            "$temperature°",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
