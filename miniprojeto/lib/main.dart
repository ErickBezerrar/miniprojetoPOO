import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniprojeto/code/favorites.dart';
import 'dart:convert';
import 'code/homePage.dart';
import 'code/newAccount.dart';
import 'code/description.dart';
import 'code/cartPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookStore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(149, 206, 207, 1.0),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BookStoreHomePage(), // Tela da página inicial
    CartPageContent(), // Tela do carrinho de compras
    MyForm(), // Tela do formulário
    FavoritesBooksPage(), // Tela do Favoritos
  ];

  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromRGBO(149, 206, 207, 1.0),
        title: Text('BookStore', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(
          icon: Icon(Icons.search, color: Colors.black, weight: 700),
          onPressed: () {
            //Ação do botão
          })
        ],
        leading: _currentIndex != 0
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            )
          : null,
      ),
      body: GestureDetector(
        onTapDown: (_) {
          _animationController?.forward();
        },
        onTapUp: (_) {
          _animationController?.reverse();
        },
        onTapCancel: () {
          _animationController?.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation!,
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorites',
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

