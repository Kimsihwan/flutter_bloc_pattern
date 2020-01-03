import 'package:flutter/material.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/restaurant_tile.dart';
import 'package:restaurant_finder/bloc/favorite_bloc.dart';
import 'package:restaurant_finder/provider/BlocProvider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: StreamBuilder<List<Restaurant>>(
          stream: bloc.favoritesStream,
          // 1
          initialData: bloc.favorites,
          builder: (context, snapshot) {
            // 2
            List<Restaurant> favorites =
                (snapshot.connectionState == ConnectionState.waiting)
                    ? bloc.favorites
                    : snapshot.data;

            if (favorites == null || favorites.isEmpty) {
              return Center(
                child: Text('No Favorites'),
              );
            }

            return ListView.separated(
                itemBuilder: (context, index) {
                  final restaurant = favorites[index];
                  return RestaurantTile(
                    restaurant: restaurant,
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: favorites.length);
          },
        ),
      ),
    );
  }
}
