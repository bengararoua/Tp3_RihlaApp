import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  // TODO 1 : un booléen privé _favori, faux au départ
  bool _favori = false;

  void _basculer() {
    // TODO 2 : inverser _favori avec setState
    setState(() {
      _favori = !_favori;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(_favori ? 'Ajouté aux favoris' : 'Retiré des favoris'),
        duration: const Duration(seconds: 1),
      ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO 3 : IconButton qui appelle _basculer ;
    //          icône favorite (rouge) ou favorite_border selon _favori
    return IconButton(
      onPressed: _basculer,
      icon: Icon(
        _favori ? Icons.favorite : Icons.favorite_border,
        color: _favori ? Colors.red : null,
      ),
    );
  }
}