import 'package:flutter/material.dart';
import 'package:rihla/screens/detail_screen.dart';
import 'package:rihla/widgets/favorite_button.dart';
import '../models/destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        color: cs.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias, // l'effet d'encre suit les coins arrondis
        child: InkWell(
          onTap: () {
        // TODO 1 : Navigator.push vers DetailScreen,
        //          en lui passant la destination de CETTE carte
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(destination: destination)));
      },

      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
  Hero(
  tag: 'image-${destination.nom}',
  child: ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Image.asset(
      destination.image,
      width: 88,
      height: 88,
      fit: BoxFit.cover,
    ),
  ),
),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(destination.nom, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 16),
                      Text(destination.region),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16),
                      Text(destination.note.toString()),
                      const Spacer(),
                      Text('${destination.prix} DT'),
                      const FavoriteButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}