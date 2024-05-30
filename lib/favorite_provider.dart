import 'package:flutter/material.dart';
import 'data.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Jam> _favoriteJams = [];

  List<Jam> get favoriteJams => _favoriteJams ?? [];

  get favorites => null;

  void addFavorite(Jam jam) {
    if (!_favoriteJams.contains(jam)) {
      _favoriteJams.add(jam);
      notifyListeners(); // Notify listeners after adding favorite
    }
  }

  void removeFavorite(Jam jam) {
    if (_favoriteJams.contains(jam)) {
      _favoriteJams.remove(jam);
      notifyListeners(); // Notify listeners after removing favorite
    }
  }

  void toggleFavorite(Jam jam) {
    if (_favoriteJams.contains(jam)) {
      removeFavorite(jam);
    } else {
      addFavorite(jam);
    }
  }
}
