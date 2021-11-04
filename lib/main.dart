import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FutureBuilderExample(title: 'Flutter Demo Home Page'),
    );
  }
}

class FutureBuilderExample extends StatefulWidget {
  const FutureBuilderExample({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FutureBuilderExample> createState() => _FutureBuilderState();
}

class _FutureBuilderState extends State<FutureBuilderExample> {
  Future<ByteData> _wait3SecAndLoadImage() async {
    await Future.delayed(const Duration(seconds: 3));
    return rootBundle.load('images/fa.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text(
            'In this example we first have an async operator that takes'
            '-3 second and succeed with the content of an image from asset.\n'
            'Note this is just for demonstration purposes, normally we just '
            'use `Image.asset()`.',
            style: TextStyle(fontSize: 12),
          ),
          FutureBuilder<ByteData>(
              future: _wait3SecAndLoadImage(),
              builder:
                  (BuildContext context, AsyncSnapshot<ByteData> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error has happened in the future!');
                } else {
                  return Image.memory(snapshot.data!.buffer.asUint8List());
                }
              })
        ],
      ),
    );
  }
}
