import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/search_location.dart';
import '../view_model/weather_view_model.dart';
import '../widgets/hour_weather_list.dart';
import '../widgets/todays_weather.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final WeatherController weatherController = Get.put(WeatherController());
  final SearchLocation searchLocation = SearchLocation();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),

        title: const Text("আমার আবহাওয়া",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: AppColors.denim_,
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () async {
              String text = await searchLocation.searchDialog(context, searchController);
              weatherController.updateSearchText(text);
            },
            icon: const Icon(
              Icons.search,
              size: 40,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (weatherController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherController.weatherModel.value == null) {
            return const Center(child: Text("Something went wrong"));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                TodaysWeather(weatherModel: weatherController.weatherModel.value),
                const SizedBox(height: 15),
                const Text(
                  "প্রতি ঘন্টার আবহাওয়া",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                HourWeatherList(weatherModel: weatherController.weatherModel.value!),
                const SizedBox(height: 15),
              ],
            ),
          );
        }),
      ),
      drawer: CustomDrawer(),
    );
  }
}
