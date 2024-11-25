import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_monitoring_app/data/DTOs/solar_data_dto.dart';

abstract class CacheDataServiceProtocol {
  Future<void> saveData(String key, Object data);

  Future<List<SolarDataDto>?> getData(String key);

  Future<void> clearAll();
}

class CacheDataService implements CacheDataServiceProtocol {
  /// Save data to the cache as JSON string
  @override
  Future<void> saveData(String key, Object data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(data);
    await prefs.setString(key, jsonData);
  }

  /// Retrieve data from the cache for the provided key
  // TODO: This needs to be abstracted and return a json string instead
  @override
  Future<List<SolarDataDto>?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData != null) {
      final List<dynamic> jsonList = jsonDecode(jsonData);
      return jsonList.map((json) => SolarDataDto.fromJson(json)).toList(); // Convert JSON to SolarDataModel
    }

    return null;
  }

  /// Clear all cached data
  @override
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
