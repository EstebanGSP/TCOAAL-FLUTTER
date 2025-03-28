/// Classe `Post` : Modèle de données représentant un article.
/// Utilisé pour récupérer, stocker et manipuler les données depuis l'API.
class Post {
  final int id;        // ID unique de l'article
  final String title;  // Titre de l'article
  final String body;   // Contenu de l'article

  /// Constructeur de la classe Post
  Post({
    required this.id,
    required this.title,
    required this.body,
  });

  /// Méthode `fromJson` permettant de transformer un Map JSON en objet `Post`.
  /// Utilisée après récupération des données depuis l'API.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
