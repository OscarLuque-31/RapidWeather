import 'package:flutter/material.dart';

class FavoritasScreen extends StatefulWidget {
  const FavoritasScreen({super.key});

  @override
  State<FavoritasScreen> createState() => _FavoritasScreenState();
}


class _FavoritasScreenState extends State<FavoritasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localizaciones Favoritas'),
      ),
      body: const Center(
        child: Text('Aquí se mostrarán tus localizaciones favoritas.'),
      ),
    );
  }
}