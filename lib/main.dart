import 'package:allection/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp.router(
      title: "Allection",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(textTheme: GoogleFonts.figtreeTextTheme()),
    ),
  );
}
