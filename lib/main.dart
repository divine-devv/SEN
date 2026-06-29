import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/algebraprovider.dart';
import 'screens/quickmathscreen.dart';

void main() => runApp(const QuickMathApp());

class QuickMathApp extends StatelessWidget {
  const QuickMathApp({super.key});
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => AlgebraProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickMath',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006064), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const QuickMathScreen(),
    ),
  );
}
