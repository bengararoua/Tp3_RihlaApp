import 'package:flutter/material.dart';
import '../models/destination.dart';
 
class HeroBanner extends StatelessWidget {
  final Destination destination;
 
  const HeroBanner({super.key, required this.destination});
 
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Couche 1 : l'image
            Image.asset(destination.image, fit: BoxFit.cover),
 
            // Couche 2 : dégradé pour la lisibilité du texte blanc
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
 
            // TODO 1 : Positioned(top: 16, right: 16) contenant un badge blanc
            //          arrondi : étoile ambre + note de la destination
 Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(destination.note.toString()),
                  ],
                ),
              ),
            ),
            // TODO 2 : Positioned(left: 20, right: 130, bottom: 20) contenant
            //          une Column : 'DESTINATION DU MOIS', le nom, la région
             Positioned(
              left: 20,
              right: 130,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('DESTINATION DU MOIS'),
                  Text(destination.nom),
                  Text(destination.region),
                ],
              ),
            ),
                        // TODO 2 : Positioned(left: 20, right: 130, bottom: 20) contenant
            //          une Column : 'DESTINATION DU MOIS', le nom, la région
            Positioned(
              left: 20,
              right: 130,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('DESTINATION DU MOIS'),
                  Text(destination.nom),
                  Text(destination.region),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 20,
              child: FilledButton(
                onPressed: () {},
                child: const Text('Découvrir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    
