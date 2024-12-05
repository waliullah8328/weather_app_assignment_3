import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart'as http;

import 'package:path_provider/path_provider.dart';
import '../models/weather_model.dart';
import '../servies/weather_servies.dart';
import '../utils/url_utils.dart';

class WeatherController extends GetxController {
  var weatherModel = Rxn<WeatherModel>(); // Observable state
  var isLoading = true.obs;
  var searchText = "Dhaka".obs;
  late Box box;
  List data=[];

  @override
  void onInit() {
    fetchWeather(searchText.value);
    super.onInit();
  }

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox("data");
    return;
  }



  Future<WeatherModel> weatherModelServies(String searchText) async {
    String url = "$base_url&q=$searchText&days=1";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var _jsonDecode = jsonDecode(response.body);
        await putData(_jsonDecode);
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      } else {
        throw "No Data";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  void fetchWeather(String city) async {
    await openBox();
    try {
      isLoading(true);
      WeatherModel? data = await WeatherServies().weatherModelServies(city);

      weatherModel.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch weather data');
    } finally {
      isLoading(false);
    }

    var myMap = box.toMap().values.toList();
    if(myMap.isEmpty){
      data.add("empty");

    }else{
      data = myMap;
    }
  }

  void updateSearchText(String city) {
    searchText.value = city;
    fetchWeather(city);
  }
  Future putData(data) async {
    await  box.clear();
    for( var d in data){
      box.add(d);
    }
  }
}
