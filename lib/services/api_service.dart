import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rihla/models/reservation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';
import '../models/destination.dart';

class ApiService {
  static const _cleCache = 'cache_destinations';
  static bool depuisCache = false;

  static Uri _url(String chemin) => Uri.parse('${ApiConfig.baseUrl}$chemin');

  static List<Destination> _decoder(String corps) =>
      (jsonDecode(corps) as List)
          .map((e) => Destination.fromJson(e as Map<String, dynamic>))
          .toList();

  static Future<List<Destination>> getDestinations() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final reponse = await http
          .get(_url('/destinations'))
          .timeout(ApiConfig.timeout);

      // TODO 4 : si statusCode n'est pas 200, lancer une Exception
      //          avec un message contenant le code
      if (reponse.statusCode != 200) {
        throw Exception(
          'Erreur de chargement des destinations (Code : ${reponse.statusCode})',
        );
      }

      final corps = utf8.decode(reponse.bodyBytes);
      // TODO 4 : mémoriser corps sous la clé _cleCache
      await prefs.setString(_cleCache, corps);
      depuisCache = false;
      return _decoder(corps);
    } catch (e) {
      // TODO 5 : lire le cache ; s'il est null, relancer l'erreur (rethrow)
      final cache = prefs.getString(_cleCache);
      if (cache == null) {
        rethrow;
      }
      // TODO 6 : sinon, signaler depuisCache = true et décoder le cache
      depuisCache = true;
      return _decoder(cache);
    }
  }

  static Future<List<Reservation>> getReservations() async {
    final reponse = await http
        .get(_url('/reservations?_embed=destination'))
        .timeout(ApiConfig.timeout);

    if (reponse.statusCode != 200) {
      throw Exception(
        'Erreur de chargement des réservations (Code : ${reponse.statusCode})',
      );
    }

    final List<dynamic> liste = jsonDecode(utf8.decode(reponse.bodyBytes));
    return liste.map((item) => Reservation.fromJson(item)).toList();
  }

  static Future<String> creerReservation(Reservation reservation) async {
    final reponse = await http
        .post(
          _url('/reservations'),
          headers: {'Content-Type': 'application/json'},
          body:
              // TODO 3 : encoder reservation.toJson() en texte JSON
              jsonEncode(reservation.toJson()),
        )
        .timeout(ApiConfig.timeout);

    // TODO 4 : si le code n'est pas 201, lancer une Exception
    if (reponse.statusCode != 201) {
      throw Exception(
        'Erreur de création de destinations (Code : ${reponse.statusCode})',
      );
    }

    final Map<String, dynamic> creee = jsonDecode(
      utf8.decode(reponse.bodyBytes),
    );
    return creee['id'].toString(); // l'id attribué par le serveur
  }
}