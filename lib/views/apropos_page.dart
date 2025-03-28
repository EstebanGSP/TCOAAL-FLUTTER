import 'package:flutter/material.dart';

/// Page "À propos"
/// Affiche un avatar (image circulaire) et un texte de description
/// Permet d'informer l'utilisateur sur le contexte du projet.
class AproposPage extends StatelessWidget {
  const AproposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre supérieure avec le titre
      appBar: AppBar(
        title: const Text('À propos'),
      ),

      // Corps principal centré verticalement
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Image circulaire (avatar)
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/apropos.png'),
            ),
            SizedBox(height: 20),

            // Texte d'information
            Text(
              'Cette application a été développée dans le cadre du projet Flutter.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
