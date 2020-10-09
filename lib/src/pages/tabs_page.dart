import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_news_app/src/pages/tab1_page.dart';
import 'package:provider_news_app/src/pages/tab2_page.dart';

class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Implementamos el Provider
    return ChangeNotifierProvider(
      // Mediante el create, creamos una instancia global de nuestra clase _NavegacionModel, para asi mantener esta instancia global
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _NavigationBar(),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final navigationModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      // Gracias a la instancia global, ya tenemos información de esta, en todos sus hijos
      currentIndex: navigationModel.currentPage, // escuchamos el valor de la pagina actual
      onTap: (i) => navigationModel.currentPage = i, // ...y aqui lo cambiamos
      items: [
        BottomNavigationBarItem( icon: Icon(Icons.person_outline), title: Text('Para ti') ),
        BottomNavigationBarItem( icon: Icon(Icons.public), title: Text('Encabezados') ),
      ]
    );
  }
}

class _Pages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      // physics: BouncingScrollPhysics(), // Estilo para cuando ya no hay mas pages
      physics: NeverScrollableScrollPhysics(), // Inhabilitamos el cambiar de pages mediante swipe
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

// ChangeNotifier:
// Mediante notifyListeners(), nos permite notificar a todos los widgets que esten pendientes del valor
class _NavegacionModel with ChangeNotifier {

  int _currentPage = 0;
  PageController _pageController = new PageController();

  // currentPage
  int get currentPage => this._currentPage;
  set currentPage( int value ) {
    this._currentPage = value;
    _pageController.animateToPage(value, duration: Duration(milliseconds: 250), curve: Curves.easeInOutCirc);
    notifyListeners();
  }

  // PageController
  PageController get pageController => this._pageController;
}