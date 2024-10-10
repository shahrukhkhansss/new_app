import 'package:flutter/material.dart';
import '../models/model.dart';

class menuDataProvider extends ChangeNotifier {
  Articles? _details;

  Articles? get Details => _details;

  void Detailspage(Articles article) {
    _details = article;
    notifyListeners();
  }
}
