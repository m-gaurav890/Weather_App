import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //getting data
    Map info = ModalRoute.of(context)!.settings.arguments as Map;
    String putTemp = ((info["tempValue"]).toString());
    String putAirSpeed = ((info["airSpeedValue"]).toString());

    if (putTemp == "NA") {
      print("No value ");
    } else {
      putTemp = ((info["tempValue"]).toString()).substring(0, 4);
    }
    if (putAirSpeed == "NA") {
      print("no value");
    } else {
      putAirSpeed = ((info["airSpeedValue"]).toString()).substring(0, 4);
    }

    String putIcon = info["iconValue"];
    String putHumidity = info["humidityValue"];
    String putWeatherDescription = info["weatherDescription"];
    String putCity = info["cityValue"];
    //Random city
    List cityName = [
      "Haldwani",
      "Delhi",
      "Chennai",
      "Mumbai",
      "Goa",
      "Gopeshwar"
    ];
    final _random = new Random();
    String city = cityName[_random.nextInt(cityName.length)];
    return Scaffold(
      //This is how we can give static colour to status bar
      // appBar:    PreferredSize(
      //   child: AppBar(
      //     backgroundColor: Colors.blue,
      //   ),
      //    preferredSize: const Size.fromHeight(0),
      // ),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: GradientAppBar(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue,
                      Colors.blue[300]!
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            child: Column(
              children: <Widget>[
                Container(
                  //Search wala container
                  padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black26,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") == "") {
                            print("blank search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading", arguments: {
                              "cityValue": searchController.text,
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, left: 6),
                          child: Icon(
                            Icons.search,
                            color: Colors.blue[400],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Search $city..",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        //second container
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Image.network(
                                "https://openweathermap.org/img/wn/$putIcon@2x.png"),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                Text(
                                  putWeatherDescription,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $putCity",
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        //third Container
                        height: 180,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  putTemp,
                                  style: const TextStyle(fontSize: 70),
                                ),
                                const Text(
                                  "C",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        //fourth Container
                        height: 200,
                        margin: const EdgeInsets.only(left: 20, right: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.wind_beaufort_1),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              putAirSpeed,
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "km/h",
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //fourth Container
                        height: 200,
                        margin: const EdgeInsets.only(right: 20, left: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              putHumidity,
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "percent",
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  padding:const EdgeInsets.all(30),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Made By Gaurav Joshi",
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Data Provided By openweather.org",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
