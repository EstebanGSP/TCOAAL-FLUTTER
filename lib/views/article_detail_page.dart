import 'package:flutter/material.dart';
import '../models/post.dart';

/// Page de détail d’un article
/// Affiche le titre et le contenu d’un `Post` avec une animation d’apparition.
class ArticleDetailPage extends StatelessWidget {
  /// Article reçu en paramètre depuis la page précédente
  final Post post;

  const ArticleDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // Récupération des styles de thème
    final titleStyle = Theme.of(context).textTheme.headlineSmall;
    final bodyStyle = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
      // AppBar avec le titre de l’article
      appBar: AppBar(
        title: Text(
          post.title,
          style: titleStyle,
        ),
      ),

      // Corps animé avec Tween + Opacity + translation
      body: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 500),
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)), // effet de "glissement vers le haut"
              child: child,
            ),
          );
        },

        // Contenu : texte du corps de l’article
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            post.body,
            style: bodyStyle,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
