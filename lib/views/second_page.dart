import 'package:flutter/material.dart';

/// Page secondaire de l'application.
/// Affiche simplement un texte centré et une AppBar.
/// Cette page sert principalement d'exemple pour la navigation.
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre supérieure avec le titre
      appBar: AppBar(
        title: Text(
          'Seconde Page',
          style: Theme.of(context).textTheme.headlineSmall, // Style cohérent avec le thème
        ),
      ),

      // Corps principal : un texte centré
      body: Center(
        child: Text(
          'Ceci est la seconde page.',
          style: Theme.of(context).textTheme.headlineSmall, // Style du texte central
        ),
      ),
    );
  }
}
