import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latres/model/restaurant.dart';
import 'package:latres/service/base_network.dart';
import 'detail.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Restaurant> favoriteRestaurants = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Ambil semua key yang mengandung 'favorite_' dan bernilai true
    final keys =
        prefs
            .getKeys()
            .where((k) => k.startsWith('favorite_') && prefs.getBool(k) == true)
            .toList();

    final allRestaurants = await BaseNetwork.getAll('list');
    final all = allRestaurants.map((e) => Restaurant.fromJson(e)).toList();

    setState(() {
      favoriteRestaurants =
          all.where((r) => keys.contains('favorite_${r.id}')).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite Page')),
      body:
          favoriteRestaurants.isEmpty
              ? const Center(child: Text('Belum ada favorite'))
              : ListView.builder(
                itemCount: favoriteRestaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = favoriteRestaurants[index];
                  return Card(
                    color: Colors.purple[50],
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          BaseNetwork.getImageUrl(restaurant.pictureId),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        restaurant.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${restaurant.city} • Rating: ${restaurant.rating}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DetailPage(restaurant: restaurant),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
