import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/constants/weather_constants.dart';
import 'package:weather/controller/address_controller.dart';
import 'package:weather/controller/location_controller.dart';
import 'package:weather/controller/weather_controller.dart';
import 'package:weather/enums/day.dart';
import 'package:weather/enums/screen_state.dart';
import 'package:weather/model/address_model.dart';
import 'package:weather/model/weather_model.dart';

import '../widgets/day_selector.dart';
import '../widgets/hourly_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Day day = Day.today;
  ScreenState _screenState = ScreenState.loadingData;
  final LocationController _locationController = LocationController();
  var formatter = DateFormat("dd MMMM, EEEE");
  late final WeatherModel _weatherModel;
  late final AddressModel _addressModel;

  late final AnimationController _controller;
  late final Animation<double> _animation;

  Future<void> initData() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        Position position = await _locationController.getLocationData();
        _weatherModel = await WeatherController.getWeather(
            position.latitude, position.longitude);
        _addressModel = await AddressController.getAddress(
            position.latitude, position.longitude);
        _screenState = ScreenState.dataLoaded;
      } on Exception catch (e) {
        print(e);
      }
    } else {
      _screenState = ScreenState.noInternetConnection;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween(
      begin: 0.5,
      end: 0.8,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_screenState == ScreenState.dataLoaded) {
      return Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1F1F1F),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Colors.white,
          ),
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Text(
                _addressModel.city,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                formatter.format(DateTime.now()),
                // "12 September, Sunday",
                style: const TextStyle(
                  color: Color(0xFF6D6D6D),
                  fontSize: 15,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
              ),
              color: Colors.white,
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Flexible(
              flex: 5,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/world_map.png',
                    color: const Color(0xFF2F2F2F),
                    fit: BoxFit.fitWidth,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FadeTransition(
                      opacity: _animation,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Image.asset(
                          weatherCodeToImage[_weatherModel.current.weatherCode]!,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          _weatherModel.current.temperature.round().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 150,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "°",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 150,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xFF282828),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Icon(
                            Icons.air_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "${_weatherModel.current.windSpeed.round()} km/h",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "Wind",
                            style: TextStyle(
                              color: Color(0xFF6D6D6D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Icon(
                            Icons.water_drop_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "${_weatherModel.current.humidity}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "Humidity",
                            style: TextStyle(
                              color: Color(0xFF6D6D6D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Icon(
                            Icons.wb_cloudy_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "${_weatherModel.current.precipitaion}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "Rain",
                            style: TextStyle(
                              color: Color(0xFF6D6D6D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: DaySelector(
                day: day,
                setDay: (Day toSet) {
                  setState(() {
                    day = toSet;
                  });
                },
              ),
            ),
            Flexible(
              flex: 2,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    return HourlyWeather(
                      index: index,
                      day: day,
                      weatherCode: _weatherModel.hourly.weatherCode
                          .elementAt(day == Day.today ? index : index + 24),
                      temperature: _weatherModel.hourly.temperature
                          .elementAt(day == Day.today ? index : index + 24)
                          .round(),
                    );
                  }),
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: const Color(0xFF1F1F1F),
        height: double.infinity,
        width: double.infinity,
        child: _screenState == ScreenState.loadingData
            ? LoadingAnimationWidget.threeArchedCircle(
                color: Colors.white,
                size: 40,
              )
            : AlertDialog(
                title: const Text("Whoops!"),
                content: const Text("No Internet Connection Found"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ),
      );
    }
  }
}
