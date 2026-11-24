import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/destination.dart';
 
/// Favoris partagés par tous les écrans.
class FavorisModel extends ChangeNotifier {
  // Clé de stockage locale (TP7)
  static const _cle = 'favoris';
  
  final Map<String, Destination> _favoris = {};

  bool estFavori(Destination d) => _favoris.containsKey(d.id);

  List<Destination> get liste => List.unmodifiable(_favoris.values);

  int get nombre => _favoris.length;

  // Charge les favoris depuis le disque au démarrage
  Future<void> charger() async {
    final prefs = await SharedPreferences.getInstance();
    
    // TODO 1 : lire la liste de textes (liste vide si rien n'est stocké)
    final List<String>? liste = prefs.getStringList(_cle);
    
    if (liste != null) {
      // TODO 2 : pour chaque texte : jsonDecode puis Destination.fromJson,
      //          ranger la destination dans _favoris avec son id
      for (final texte in liste) {
        final Map<String, dynamic> json = jsonDecode(texte);
        final destination = Destination.fromJson(json);
        _favoris[destination.id] = destination;
      }
    }
    notifyListeners();
  }

  // Sauvegarde les favoris sur le disque
  Future<void> _sauvegarder() async {
    final prefs = await SharedPreferences.getInstance();
    
    // TODO 3 : transformer chaque destination en texte
    //          (toJson puis jsonEncode) et l'écrire avec setStringList
    final List<String> liste = _favoris.values
        .map((destination) => jsonEncode(destination.toJson()))
        .toList();
        
    await prefs.setStringList(_cle, liste);
  }

  bool basculer(Destination d) {
    // TP7 : La méthode remove renvoie l'élément supprimé, ou null s'il n'existait pas
    final ajoute = _favoris.remove(d.id) == null;
    if (ajoute) {
      _favoris[d.id] = d;
    }
    
    _sauvegarder(); // TP7 : recopie sur le disque
    notifyListeners();
    return ajoute;
  }
}