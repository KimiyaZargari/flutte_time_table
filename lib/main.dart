import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_table/presentation/core/config/theme.dart';
import 'package:time_table/presentation/routes/router.dart';
import 'package:time_table/presentation/time_table/screens/time_table.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
        localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
        supportedLocales: const [
          Locale('fa', 'IR'),
        ],
        theme: lightTheme(),
      ),
    );
  }
}
