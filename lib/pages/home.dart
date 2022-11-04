import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// 20 qoshish
class _HomeState extends State<Home> {
  final controller = ScrollController();

  List<String> items = List.generate(
    20,
    (index) => 'Assalomu Alaykum ${index + 1}',
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fatch();
      }
    });
  }

// new data qoshilishi
  Future fatch() async {
    final Url = Uri.parse("https://636497347b209ece0f495343.mockapi.io/odam");
    final response = await http.get(Url);

    if (response.statusCode == 200) {
      final List Prosta = json.decode(response.body);
      items.addAll(Prosta.map<String>((item) {
        final name = item['name'];

        return 'item $name';
      }).toList());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.all(10),
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return ListTile(title: Text(item.toString()));
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
