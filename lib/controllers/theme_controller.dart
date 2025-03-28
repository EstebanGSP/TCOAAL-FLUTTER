import 'package:flutter/material.dart';

/// Enumération représentant les trois types de thèmes disponibles dans l'app.
enum AppTheme {
  tcoaal,  // Thème personnalisé sombre et rouge
  light,   // Thème clair classique
  dark,    // Thème sombre classique
}

/// Contrôleur de thème global (utilisé avec Provider).
/// Il permet de changer dynamiquement le thème de l'application.
class ThemeController extends ChangeNotifier {
  /// Thème actuellement sélectionné (par défaut : TCOAAL).
  AppTheme _currentTheme = AppTheme.tcoaal;

  /// Getter pour accéder au thème actuel.
  AppTheme get currentTheme => _currentTheme;

  /// Méthode permettant de définir manuellement un thème.
  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners(); // Notifie tous les widgets dépendants du changement
  }

  /// Méthode utilitaire pour basculer entre clair et sombre.
  /// N'affecte pas le thème TCOAAL.
  void toggleLightDark() {
    _currentTheme =
        _currentTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    notifyListeners();
  }

  /// Permet de savoir si le thème actuel est sombre.
  /// (Utile pour changer certaines icônes ou effets visuels)
  bool get isDarkMode => _currentTheme == AppTheme.dark;
}
