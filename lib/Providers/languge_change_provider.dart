import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LangugeChangeProvider with ChangeNotifier {
  Locale? _languageCode;
  Locale? get languageCode => _languageCode;

  Future<void> chageLanguge(Locale locale) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _languageCode = locale;
    if (locale == const Locale('en')) {
      await sp.setString('langugeCode', 'en');
    } else {
      await sp.setString('langugeCode', 'ur');
    }
    notifyListeners();
  }
}
