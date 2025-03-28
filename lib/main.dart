import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/theme_controller.dart';
import 'views/home_page.dart';

/// Point d'entrée de l'application Flutter.
/// On utilise ici `ChangeNotifierProvider` pour gérer le thème global de l'app.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const MyApp(),
    ),
  );
}

/// Fonction qui retourne un thème personnalisé (TCOAAL),
/// avec une ambiance sombre et des accents rouges "sang".
ThemeData getTcoaalTheme() {
  const sang = Color(0xFF7C1F1F); // Couleur rouge sang utilisée comme couleur principale

  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Fond sombre
    fontFamily: 'TcoaalFont', // Police personnalisée
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: sang, // Titres principaux
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: sang, // Sous-titres
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: sang,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white70, // Texte classique
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF1E1E1E),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: sang,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}

/// Widget principal de l'application.
/// Il gère le thème en fonction du choix de l'utilisateur (clair, sombre ou personnalisé).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère le contrôleur de thème
    final themeController = Provider.of<ThemeController>(context);

    // On vérifie si le thème actuel est le thème TCOAAL personnalisé
    final isTcoaal = themeController.currentTheme == AppTheme.tcoaal;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projet Flutter MVC',

      // Définition des thèmes
      theme: ThemeData.light(), // Thème clair
      darkTheme: ThemeData.dark(), // Thème sombre

      // Mode de thème selon le choix de l'utilisateur
      themeMode: isTcoaal
          ? ThemeMode.system // Sera remplacé manuellement ensuite
          : themeController.currentTheme == AppTheme.dark
              ? ThemeMode.dark
              : ThemeMode.light,

      // Si thème TCOAAL : on applique son thème manuellement avec Theme + DefaultTextStyle
      builder: (context, child) {
        return isTcoaal
            ? DefaultTextStyle(
                style: getTcoaalTheme().textTheme.bodyMedium!,
                child: Theme(
                  data: getTcoaalTheme(),
                  child: child!,
                ),
              )
            : child!;
      },

      // Page d'accueil de l'application
      home: const HomePage(),
    );
  }
}
