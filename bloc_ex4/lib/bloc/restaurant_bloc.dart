import 'dart:async';

import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

import 'Bloc.dart';

class RestaurantBloc implements Bloc {
  final Location location;
  final _client = ZomatoClient();
  final _contorller = StreamController<List<Restaurant>>();

  Stream<List<Restaurant>> get stream => _contorller.stream;

  RestaurantBloc(this.location);

  void submitQuery(String query) async {
    final results = await _client.fetchRestaurants(location, query);
    _contorller.sink.add(results);
  }

  @override
  void dispose() {
    _contorller.close();
  }
}
