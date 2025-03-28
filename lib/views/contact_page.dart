import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Page de contact de l'application.
/// Elle contient un formulaire permettant à l'utilisateur
/// de saisir un nom, un email, et un message, avec validation.
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  /// Clé pour valider le formulaire
  final _formKey = GlobalKey<FormState>();

  /// Contrôleurs pour les champs de texte
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  /// Fonction appelée quand l'utilisateur appuie sur "Envoyer"
  /// Elle affiche un message de confirmation si le formulaire est valide
  void _envoyerMessage() {
    if (_formKey.currentState!.validate()) {
      final nom = _nomController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      // Boîte de dialogue de confirmation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Message envoyé",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: Text(
            "Merci $nom !\nNous avons bien reçu votre message.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Fermer",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
      );

      // Réinitialisation des champs
      _nomController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineSmall;

    return Scaffold(
      // Barre supérieure
      appBar: AppBar(
        title: Text(
          "Contact",
          style: textStyle,
        ),
      ),

      // Corps de la page centré + mise en forme
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500), // Largeur max pour lisibilité
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Champ NOM
                  TextFormField(
                    controller: _nomController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      labelStyle: textStyle,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      return null;
                    },
                  ),

                  // Champ EMAIL
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: textStyle,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),

                  // Champ MESSAGE
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      labelStyle: textStyle,
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un message';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Bouton ENVOYER
                  ElevatedButton(
                    onPressed: _envoyerMessage,
                    child: Text(
                      'Envoyer',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red, // Accent TCOAAL
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
