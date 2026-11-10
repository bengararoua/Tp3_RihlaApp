import 'package:flutter/material.dart';
import 'package:rihla/models/avis.dart';
import 'package:rihla/models/destination.dart';

class AvisScreen extends StatefulWidget {
  final Destination destination;
  const AvisScreen({super.key, required this.destination});

  @override
  State<AvisScreen> createState() => _AvisScreenState();
}

class _AvisScreenState extends State<AvisScreen> {
  final _formKey = GlobalKey<FormState>();
  final _prenom = TextEditingController();
  final _commentaire = TextEditingController();
  int _note = 0;
  bool _noteVide = false;

  @override
  void dispose() {
    _prenom.dispose();
    _commentaire.dispose();
    super.dispose();
  }

  void _publier() {
    final ok = _formKey.currentState!.validate();
    setState(() => _noteVide = _note == 0);
    if (!ok || _note == 0) return;

    Navigator.pop(
      context,
      Avis(
        auteur: _prenom.text.trim(),
        note: _note,
        commentaire: _commentaire.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Avis sur ${widget.destination.nom}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      onPressed: () => setState(() {
                        _note = i;
                        _noteVide = false;
                      }),
                      icon: Icon(
                        i <= _note ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 32,
                      ),
                    ),
                ],
              ),
              if (_noteVide)
                Text('Choisissez une note.',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prenom,
                decoration: const InputDecoration(
                    labelText: 'Prénom', border: OutlineInputBorder()),
                validator: (v) => v!.trim().length < 2
                    ? 'Au moins 2 caractères'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _commentaire,
                maxLines: 4,
                maxLength: 300,
                decoration: const InputDecoration(
                    labelText: 'Commentaire',
                    border: OutlineInputBorder()),
                validator: (v) => v!.trim().length < 20
                    ? 'Au moins 20 caractères'
                    : null,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _publier,
                  child: const Text('Publier'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}