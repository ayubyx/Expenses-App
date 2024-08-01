import 'package:expenses_app/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

var myColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 59, 96, 179));

var myDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 59, 96, 179));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Expenses(),
      themeMode: ThemeMode.system,
      theme: ThemeData().copyWith(
          colorScheme: myColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: myColorScheme.onPrimaryContainer,
            foregroundColor: myColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: myColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: myColorScheme.primaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: myColorScheme.onSecondaryContainer,
                  fontSize: 17))),
      //? darkTheme
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: myDarkColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: myDarkColorScheme.onPrimaryContainer,
            foregroundColor: myDarkColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: myDarkColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: myDarkColorScheme.primaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: myDarkColorScheme.onSecondaryContainer,
                  fontSize: 17)),
          bottomSheetTheme: const BottomSheetThemeData()
              .copyWith(backgroundColor: myDarkColorScheme.background)),
    );
  }
}
