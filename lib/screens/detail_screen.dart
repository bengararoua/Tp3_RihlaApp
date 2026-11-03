import 'package:flutter/material.dart';
import 'package:rihla/models/destination.dart';
import 'package:rihla/screens/reservation_screen.dart';
import 'package:rihla/widgets/favorite_button.dart';
import 'package:rihla/models/reservation.dart';
class DetailScreen extends StatefulWidget {
  final Destination destination;
  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _voyageurs = 1;
Future<void> _reserver() async {
  final reservation = await Navigator.push<Reservation>(
    context,
    MaterialPageRoute(
      builder: (context) => ReservationScreen(
        destination: widget.destination,
        voyageurs: _voyageurs,
      ),
    ),
  );

  // TODO 3 : si aucune réservation n'est renvoyée, arrêter
  if (reservation == null) return;

  // TODO 4 : vérifier que DetailScreen est toujours affiché
  if (!mounted) return;

  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 48,
      ),
      title: const Text('Réservation confirmée'),
      content: Text(
        'Nom : ${reservation.nom}\n'
        'Destination : ${reservation.destination.nom}\n'
        'Voyageurs : ${reservation.voyageurs}\n'
        'Formule : ${reservation.formule}\n'
        'Total : ${reservation.total} DT\n'
        'E-mail : ${reservation.email}',
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Parfait'),
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final d = widget.destination;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 340,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(d.image, fit: BoxFit.cover),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
  tooltip: 'Retour',
  onPressed: () => Navigator.pop(context),
  icon: const Icon(Icons.arrow_back),
),
                  ),
                ),
                const Positioned(
                  top: 40,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FavoriteButton(),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.nom,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text(d.region),
                        ],
                      ),
                    ),
                    Chip(
                      avatar: const Icon(Icons.star, color: Colors.amber),
                      label: Text('${d.note}'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: cs.outlineVariant),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.schedule, color: cs.primary),
                            const Text('Durée',
                                style: TextStyle(fontSize: 12)),
                            Text(d.duree,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: cs.outlineVariant),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.category, color: cs.primary),
                            const Text('Type',
                                style: TextStyle(fontSize: 12)),
                            Text(d.categorie,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: cs.outlineVariant),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.groups, color: cs.primary),
                            const Text('Groupe',
                                style: TextStyle(fontSize: 12)),
                            const Text('Max 12',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('À propos',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(d.description),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Voyageurs',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    IconButton.outlined(
                      onPressed: _voyageurs > 1
                          ? () => setState(() => _voyageurs--)
                          : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('$_voyageurs',
                          style: const TextStyle(fontSize: 16)),
                    ),
                    IconButton.outlined(
                      onPressed: () => setState(() => _voyageurs++),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total'),
                  Text('${d.prix * _voyageurs} DT',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: cs.primary)),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: FilledButton(
  onPressed: _reserver,
  child: const Text('Réserver'),
),
              ),
            ],
          ),
        ),
      ),
    );
  }
}