import 'package:flutter/material.dart';
import 'package:rihla/widgets/destination_card.dart';
import 'package:rihla/widgets/home_header.dart';
import 'package:rihla/widgets/search_box.dart'; 
import 'package:rihla/widgets/hero_banner.dart';
import 'package:rihla/data/destinations.dart';
import 'package:rihla/widgets/section_title.dart'; 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
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
            SectionTitle(title: 'Catégories'),                     
            const SizedBox(height: 12),
            SectionTitle(title: 'Populaires', action: 'Voir tout'), 
            const SizedBox(height: 12),
            for (final d in destinations) DestinationCard(destination: d),
          ],
        ),
      ),
    );
  }
}
