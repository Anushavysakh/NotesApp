import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceApp {


   static storeViewMode(bool isGrid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isGrid", isGrid);
   }

   Future<bool> getGridViewState() async {
     SharedPreferences preferences = await SharedPreferences.getInstance();
      bool gridStatus = preferences.getBool("isGrid") ?? true;
      return gridStatus;
   }
}