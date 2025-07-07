import 'package:flutter/material.dart';

class MechanicLoginScreen extends StatefulWidget {
  const MechanicLoginScreen({super.key});

  @override
  State<MechanicLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<MechanicLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("App bar")));
  }
}
