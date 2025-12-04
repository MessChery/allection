import 'package:allection/services/db_helper.dart';
import 'package:allection/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
    debugPrint('.env loaded from asset: .env');
  } catch (e, st) {
    debugPrint('Warning: failed to load .env from assets: $e\n$st');
  }

  await MongoDatabase.connect();

  runApp(
    MaterialApp.router(
      title: "Allection",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(textTheme: GoogleFonts.figtreeTextTheme()),
    ),
  );
}
