import 'dart:convert';
import 'package:carwan_dough/models/menu_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! Menu
class AppCache {
  static Future<void> saveProducts(List<MenuModel> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data.map((p) => p.toMap()).toList());
    await prefs.setString('Menu', jsonString);
  }

  static Future<List<MenuModel>> getMenu() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('Menu');
    if (jsonString == null) return [];
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => MenuModel.fromMap(json)).toList();
  }
}
