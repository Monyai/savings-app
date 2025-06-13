import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('目標貯金'),
      ),
      body: const Center(
        child: Text(
          '貯金ゲージがここに表示されます',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 入金画面への遷移
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}