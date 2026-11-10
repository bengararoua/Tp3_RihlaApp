import 'package:flutter/material.dart';
import 'package:rihla/data/destinations.dart';
import 'package:rihla/models/destination.dart';
import 'package:rihla/widgets/destination_card.dart';
import 'package:rihla/widgets/hero_banner.dart';
import 'package:rihla/widgets/home_header.dart';
import 'package:rihla/widgets/search_box.dart';
import 'package:rihla/widgets/section_title.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categorie = 'Tout'; // état 1 : la catégorie choisie
  int _onglet = 0;

  late Future<List<Destination>> _futurDestinations;

  @override
  void initState() {
    super.initState();
    // TODO 1 : lancer la requête et stocker le Future
    _futurDestinations = ApiService.getDestinations();
  }

  List<Destination> _filtrer(List<Destination> toutes) => _categorie == 'Tout'
      ? toutes
      : toutes.where((d) => d.categorie == _categorie).toList();

  Widget _construireExplorer() {
    return FutureBuilder<List<Destination>>(
      future: _futurDestinations,
      builder: (context, snapshot) {
        // TODO 2 : en attente (waiting) et pas encore de données
        //             -> CircularProgressIndicator centré
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        // TODO 3 : erreur (snapshot.hasError) -> ErreurReseau(...)
  
        if (snapshot.hasError) {
          return ErreurReseau(
            message: 'Impossible de charger les destinations.',
            onReessayer: _recharger,
          );
        }
        final destinations = snapshot.data!;

        // Dans _construireExplorer, cas « données » :
        return RefreshIndicator(
          onRefresh: _recharger,
          child: _construireAccueil(destinations),
        );
      },
    );
  }

  Widget _construireAccueil(List<Destination> destinations) {
    final filtres = _filtrer(destinations);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        const HomeHeader(prenom: 'Roua'),
        const SizedBox(height: 20),
        const SearchBox(),
        const SizedBox(height: 20),
        HeroBanner(destination: destinations.first),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Catégories'),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final c in categories)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: _categorie == c,
                    onSelected: (_) {
                      setState(() {
                        _categorie = c;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Populaires', action: 'Voir tout'),
        const SizedBox(height: 12),
        for (final d in filtres)
          DestinationCard(key: ValueKey(d.id), destination: d),
      ],
    );
  }

  Future<void> _recharger() async {
    final futur = ApiService.getDestinations();
    setState(() {
      _futurDestinations = futur; // FutureBuilder écoute le nouveau Future
    });
    try {
      await futur; // RefreshIndicator attend la fin
    } catch (_) {} // l'erreur est affichée par FutureBuilder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _onglet == 0
            ? _construireExplorer()
            : const Center(child: Text('Bientôt disponible')),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _onglet,
        onDestinationSelected: (index) {
          setState(() {
            _onglet = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explorer',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class ErreurReseau extends StatelessWidget {
  final String message;
  final VoidCallback onReessayer;

  const ErreurReseau({
    super.key,
    required this.message,
    required this.onReessayer,
  });

  @override
  Widget build(BuildContext context) {
    // TODO 4 : Column centrée : Icon(Icons.cloud_off) en couleur d'erreur,
    //          le message, « Vérifiez que json-server est lancé. »,
    //          et un FilledButton.tonalIcon « Réessayer » qui appelle onReessayer
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              size: 60,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Vérifiez que json-server est lancé.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: onReessayer,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}