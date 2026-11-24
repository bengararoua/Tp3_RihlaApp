import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reglages_model.dart';

class HomeHeader extends StatelessWidget {
  final String prenom;

  const HomeHeader({super.key, required this.prenom});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme; // la palette Material 3 du thème
    final estSombre = context.watch<ReglagesModel>().sombre;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO 1 : Text 'Ahlan, $prenom 👋'
              //          style : bodyLarge, couleur cs.onSurfaceVariant
              Text(
                'Ahlan, $prenom 👋',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              // TODO 2 : Text "Où partez-vous\naujourd'hui ?"
              //          style : headlineSmall en gras
              Text(
                "Où partez-vous\naujourd'hui ?",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: estSombre ? 'Passer en thème clair' : 'Passer en thème sombre',
          onPressed: () => context.read<ReglagesModel>().basculerTheme(),
          icon: Icon(
            estSombre ? Icons.light_mode : Icons.dark_mode,
            color: cs.primary,
          ),
        ),
        const SizedBox(width: 8),
        // TODO 3 : CircleAvatar de rayon 26, fond cs.primaryContainer,
        //          qui affiche l'initiale prenom[0] en gras, taille 22
        CircleAvatar(
          radius: 26,
          backgroundColor: cs.primaryContainer,
          child: Text(
            prenom.isNotEmpty ? prenom[0].toUpperCase() : '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: cs.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}