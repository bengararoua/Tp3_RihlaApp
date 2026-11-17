import 'package:flutter/material.dart';
import '../models/destination.dart';
import 'package:provider/provider.dart'; 
import '../providers/favoris_model.dart';

class FavoriteButton extends StatelessWidget {
  final Destination destination;
  const FavoriteButton({super.key, required this.destination});
 
  @override
  Widget build(BuildContext context) {
    // TODO lire l'état avec context.watch<FavorisModel>()
    final estFavori = context.watch<FavorisModel>().estFavori(destination);
    
    // TODO IconButton : cœur plein ou vide
    return IconButton(
      icon: Icon(
        estFavori ? Icons.favorite : Icons.favorite_border,
        color: estFavori ? Colors.red : null,
      ),
      // TODO onPressed : context.read<FavorisModel>().basculer(...)
      onPressed: () {
        context.read<FavorisModel>().basculer(destination);
      },
    ); 
  } 
} 