import 'package:flutter/material.dart';
import 'second_page.dart';
import 'apropos_page.dart';
import 'contact_page.dart';
import 'articles_page.dart';
import 'package:provider/provider.dart';
import '../controllers/theme_controller.dart';

/// Page d'accueil principale de l'application.
/// Elle contient :
/// - Une AppBar avec sélection du thème (clair / sombre / TCOAAL)
/// - Un Drawer (menu de navigation)
/// - Un corps avec un fond d'image + logo et une citation centrale
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Accès au contrôleur de thème via Provider
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      // Barre du haut
      appBar: AppBar(
        title: Text(
          'Accueil',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          // Boutons pour changer le thème (claire, sombre, TCOAAL)
          IconButton(
            icon: const Icon(Icons.light_mode),
            tooltip: 'Thème clair',
            onPressed: () {
              themeController.setTheme(AppTheme.light);
            },
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode),
            tooltip: 'Thème sombre',
            onPressed: () {
              themeController.setTheme(AppTheme.dark);
            },
          ),
          IconButton(
            icon: const Icon(Icons.bloodtype),
            tooltip: 'Thème TCOAAL',
            onPressed: () {
              themeController.setTheme(AppTheme.tcoaal);
            },
          ),
        ],
      ),

      // Menu latéral (Drawer)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // En-tête du menu avec l'image
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bannermenu.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Navigation vers les différentes pages de l'app
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'Accueil',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              onTap: () {
                Navigator.pop(context); // ferme juste le drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_forward),
              title: Text(
                'Seconde Page',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              onTap: () {
                Navigator.push(context, _createRoute(const SecondPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(
                'À propos',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              onTap: () {
                Navigator.push(context, _createRoute(const AproposPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: Text(
                'Contact',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              onTap: () {
                Navigator.push(context, _createRoute(const ContactPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: Text(
                'Articles',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              onTap: () {
                Navigator.push(context, _createRoute(const ArticlesPage()));
              },
            ),
          ],
        ),
      ),

      // Corps principal de la page
      body: Stack(
        children: [
          // Fond d'image en opacité faible (effet ambiance)
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/accimage.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Contenu par-dessus (logo + texte centré)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/tcoaal.png',
                  width: 500,
                ),
                const SizedBox(height: 20),
                Text(
                  ' I’ll protect you, no matter what. Even if it means hurting everyone else. ',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Fonction permettant de créer une transition animée personnalisée
  /// lorsqu'on ouvre une nouvelle page via Navigator.
  /// transition "fade in"
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
