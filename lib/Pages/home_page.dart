import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Payment"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {

        },
        child: const Text(
          "Purchase"
        ),
        ),
      ),
    );
  }
}