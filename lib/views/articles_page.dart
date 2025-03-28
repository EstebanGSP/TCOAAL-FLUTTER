import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';
import 'article_detail_page.dart';

/// Page "Articles"
/// Cette page récupère des articles (mockés via une API),
/// les affiche dans une liste avec pagination et animation d'entrée.
class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  // Contrôleur de scroll pour détecter le bas de la page
  final ScrollController _scrollController = ScrollController();

  // Liste complète des posts récupérés depuis l'API
  List<Post> _allPosts = [];

  // Liste des posts actuellement affichés
  List<Post> _displayedPosts = [];

  // Pagination
  int _postsPerPage = 20;
  int _currentPage = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAllPosts(); // On récupère les articles
    _scrollController.addListener(_onScroll); // On surveille le scroll
  }

  /// Récupération de tous les articles depuis l'API JSONPlaceholder
  Future<void> _fetchAllPosts() async {
    setState(() => _isLoading = true);

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      _allPosts = jsonData.map((e) => Post.fromJson(e)).toList();
      _loadMore(); // On charge la première page
    } else {
      throw Exception('Erreur de chargement');
    }
  }

  /// Chargement des articles suivants (pagination)
  void _loadMore() {
    final nextPage = _currentPage + 1;
    final startIndex = _currentPage * _postsPerPage;
    final endIndex = startIndex + _postsPerPage;

    if (startIndex < _allPosts.length) {
      setState(() {
        _displayedPosts.addAll(
          _allPosts.sublist(
            startIndex,
            endIndex > _allPosts.length ? _allPosts.length : endIndex,
          ),
        );
        _currentPage = nextPage;
      });
    }

    _isLoading = false;
  }

  /// Détection du scroll en bas de la page
  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoading) {
      _isLoading = true;
      _loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Nettoyage
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineSmall;

    return Scaffold(
      // Barre du haut
      appBar: AppBar(
        title: Text(
          'Articles',
          style: textStyle,
        ),
      ),

      // Corps avec une phrase d’intro + liste animée
      body: Column(
        children: [
          // Titre "newsletter"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'TCOAAL NEWSLETTER',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),

          // Liste des articles avec animation d'apparition
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _displayedPosts.length + 1,
              itemBuilder: (context, index) {
                if (index < _displayedPosts.length) {
                  final post = _displayedPosts[index];
                  final postNumber = index + 1;

                  return TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 400),
                    tween: Tween(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Card(
                        elevation: 2,
                        color: Theme.of(context).cardColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                          // Numéro de l'article dans un cercle
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Text(
                              '$postNumber',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),

                          // Titre de l'article
                          title: Text(
                            post.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          // Navigation vers la page de détails
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ArticleDetailPage(post: post),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  // Affichage d'un loader à la fin (chargement)
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
