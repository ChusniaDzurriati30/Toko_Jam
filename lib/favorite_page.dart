import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'favorite_provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        final favoriteJams = favoriteProvider.favoriteJams ?? [];
        if (favoriteJams.isEmpty) {
          return Center(child: Text('No favorites yet!'));
        }
        return ListView.builder(
          itemCount: favoriteJams.length,
          itemBuilder: (context, index) {
            final jam = favoriteJams[index];
            return ListTile(
              title: Text(jam.title),
              subtitle: Text(jam.price),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  favoriteProvider.toggleFavorite(jam);
                },
              ),
            );
          },
        );
      },
    );
  }
}
