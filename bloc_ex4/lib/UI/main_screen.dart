import 'package:flutter/material.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/UI/location_screen.dart';
import 'package:restaurant_finder/UI/restaurant_screen.dart';
import 'package:restaurant_finder/bloc/location_bloc.dart';
import 'package:restaurant_finder/provider/BlocProvider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1
    return StreamBuilder<Location>(
        stream: BlocProvider.of<LocationBloc>(context).locationStream,
        builder: (context, snapshot) {
          final location = snapshot.data;

          // 2
          if (location == null) {
            return LocationScreen();
          }

          return RestaurantScreen(
            location: location,
          );
        });
  }
}
