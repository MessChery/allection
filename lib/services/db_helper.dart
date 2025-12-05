import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection userCollection;

  static connect() async {
    try {
      final url = dotenv.env['MONGODB_URL'] ?? '';
      debugPrint("Connecting to: $url");
      db = await Db.create(url);
      await db.open();
      userCollection = db.collection('users');
      debugPrint("Connected to MongoDB");
    } catch (e) {
      debugPrint("MongoDB connection failed: $e");
      rethrow;
    }
  }

  static Future<String> fetchUser(String email) async {
    try {
      var result = await userCollection.findOne({'email': email});
      return result == null ? '' : result.toString();
    } catch (e) {
      throw 'Error fetching user: $e';
    }
  }

  static Future<String> insertUser(
    String email,
    String username,
    String password,
  ) async {
    try {
      var result = await userCollection.insertOne({
        'email': email,
        'username': username,
        'password': password,
        'createdAt': DateTime.now().toString(),
      });
      return 'User inserted with id: ${result.id}';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> fetchLoginUser(String username, String password) async {
    try {
      var result = await userCollection.findOne({
        'username': username,
        'password': password,
      });
      return result == null
          ? 'Incorrect username or password'
          : result.toString();
    } catch (e) {
      throw 'Error fetching login user: $e';
    }
  }
}
