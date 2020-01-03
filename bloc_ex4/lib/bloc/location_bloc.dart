import 'dart:async';

import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/bloc/Bloc.dart';

class LocationBloc implements Bloc {
  Location _location;

  Location get selectedLocation => _location;

  final _locationController = StreamController<Location>();

  get locationStream => _locationController.stream;

  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _locationController.close();
  }
}
