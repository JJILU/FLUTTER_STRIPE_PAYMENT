import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:striperpayers/services/stripe_service.dart';

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
      body:SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(onPressed: () {
              StripeService.instance.makePayment();
            },
            child: const Text("Purchsase"),
            ),
          ],),
      )
    );
  }
}