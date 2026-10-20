import 'package:flutter/material.dart';
import 'package:rihla/data/destinations.dart';
import 'package:rihla/models/destination.dart';
import 'package:rihla/widgets/destination_card.dart';
import 'package:rihla/widgets/hero_banner.dart';
import 'package:rihla/widgets/home_header.dart';
import 'package:rihla/widgets/search_box.dart';
import 'package:rihla/widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categorie = 'Tout'; // l'état : la catégorie choisie

  // TODO 1 : si _categorie vaut 'Tout', on renvoie tout ;
  // sinon, seulement les destinations de la catégorie choisie.
  List<Destination> get _filtrees {
    if (_categorie == 'Tout') {
      return destinations;
    }
    return destinations.where((d) => d.categorie == _categorie).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                        // TODO 2 : vrai seulement pour la catégorie choisie
                        selected: _categorie == c,
                        onSelected: (_) {
                          // TODO 3 : mémoriser c dans _categorie avec setState
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
            for (final d in _filtrees) DestinationCard(destination: d),
          ],
        ),
      ),
    );
  }
}