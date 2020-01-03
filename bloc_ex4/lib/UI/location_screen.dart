import 'package:flutter/material.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/bloc/locationQuery_bloc.dart';
import 'package:restaurant_finder/bloc/location_bloc.dart';
import 'package:restaurant_finder/provider/BlocProvider.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LocationQueryBloc();
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Where do you want to eat?'),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a location'),
                  onChanged: (query) => bloc.submitQuery(query),
                ),
              ),
              Expanded(
                child: _buildResults(bloc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
        stream: bloc.locationStream,
        builder: (context, snapshot) {
          // 1
          final result = snapshot.data;

          if (result == null) {
            return Center(
              child: Text('Enter a location'),
            );
          }

          if (result.isEmpty) {
            return Center(
              child: Text('No Results'),
            );
          }

          return _buildSearchResults(result);
        });
  }

  Widget _buildSearchResults(List<Location> results) {
    // 2
    return ListView.separated(
        itemBuilder: (context, index) {
          final location = results[index];
          return ListTile(
            title: Text(location.title),
            onTap: () {
              // 3
              final locationBloc = BlocProvider.of<LocationBloc>(context);
              locationBloc.selectLocation(location);

              if (isFullScreenDialog) {
                Navigator.of(context).pop();
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: results.length);
  }
}
