import 'package:flutter/material.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});
  
  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();

}

class _PrincipalScreenState extends State<PrincipalScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Principal Screen!'),
      ),
    );
  }


}
