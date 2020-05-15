import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'favorite_screen.dart';
import '../components/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeal;

  const TabsScreen(this.favoriteMeal);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {'title': 'Lista de Categorias', 'screen': CategoryScreen()},
      {'title': 'Favoritos', 'screen': FavoriteScreen(widget.favoriteMeal)},
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          _screens[_selectedScreenIndex]['title'],
          textAlign: TextAlign.center,
        )),
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        unselectedItemColor: Colors.white, //item nao selecionado
        selectedItemColor: Colors.white, //item selecionado
        currentIndex: _selectedScreenIndex, //saber qual item foi selecionado
        type: BottomNavigationBarType.shifting, //animação
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: Icon(
              Icons.category,
              color: Colors.white,
            ),
            title: Text(
              'Categorias',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            title: Text(
              'Favoritos',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
