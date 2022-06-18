import 'package:flutter/cupertino.dart';
import 'package:restroapp/models/restaurants.dart';

class RestaurantsProvider extends ChangeNotifier {
  List<Restaurants> _restaurants = [];

  List<Restaurants> get restaurants {
    return [..._restaurants];
  }

  void updateRestaurants(List<Restaurants> restaurantsList) {
    _restaurants = restaurantsList;
    notifyListeners();
  }
}
