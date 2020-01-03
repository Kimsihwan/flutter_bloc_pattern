import 'package:flutter/material.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/favorite_screen.dart';
import 'package:restaurant_finder/UI/location_screen.dart';
import 'package:restaurant_finder/bloc/restaurant_bloc.dart';
import 'package:restaurant_finder/provider/BlocProvider.dart';

import 'restaurant_tile.dart';

class RestaurantScreen extends StatelessWidget {
  final Location location;

  const RestaurantScreen({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(location.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => FavoriteScreen())),
            )
          ],
        ),
        body: _buildSearch(context),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit_location),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LocationScreen(
                    isFullScreenDialog: true,
                  ),
              fullscreenDialog: true)),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    final bloc = RestaurantBloc(location);

    return BlocProvider<RestaurantBloc>(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What do you want eat?'),
              onChanged: (query) => bloc.submitQuery(query),
            ),
          ),
          Expanded(child: _buildStreamBuilder(bloc)),
        ],
      ),
    );
  }

  Widget _buildStreamBuilder(RestaurantBloc bloc) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('Enter a restaurant name or cuisine type'));
        }

        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }

        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Restaurant> results) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final restaurant = results[index];
          return RestaurantTile(restaurant: restaurant);
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: results.length);
  }
}
