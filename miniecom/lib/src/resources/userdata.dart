import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import '../models/usermodel.dart';
import '../models/productmodel.dart';
import 'package:path/path.dart';

class UserDatabase {
  Database? db;
  UserDatabase() {
    init();
  }
  void init() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      final path = join(documentsDirectory.path, 'user3.db');
      print(path);
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database newDb, int version) async {
          await newDb.execute("""
                    CREATE TABLE Users(
                      id INTEGER PRIMARY KEY,
                      name TEXT,
                      email TEXT,
                      password TEXT
                     
                    )
""");
          await newDb.execute("""
            CREATE TABLE Orders(
                      productId INTEGER PRIMARY KEY,
                      productName TEXT,
                      productPrice INTEGER,
                      email TEXT
                    )

""");
        },
      );
      print("Database initialized successfully");
    } catch (e) {
      print("Error initalizing database $e");
    }
  }

  Future<User?> fetchUser(String? email) async {
    print("Fetching user with email: $email");
    try {
      final maps = await db?.query(
        "Users",
        columns: null,
        where: "email=?",
        whereArgs: [email],
      );

      if (maps!.isNotEmpty) {
        print("$email: ${User.fromDb(maps.first)}");
        return User.fromDb(maps.first);
      }
      print("User not found");
      return null;
    } catch (e) {
      print("Error fetching user from the database: $e");
    }
  }

  addItem(User? user) {
    try {
      db?.insert(
        "Users",
        user!.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      print("User added successfully: ${user!.id},${user.email}");
    } catch (e) {
      print("Error while adding user to database $e");
    }
  }

  addProduct(ProductModel? product) {
    try {
      db?.insert("Orders", product!.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      print("Order added successfully");
    } catch (e) {
      print("Error adding product $e");
    }
  }

  Future<List<ProductModel>?> fetchProducts(String? email) async {
    try {
      final maps = await db?.query("Orders",
          columns: null, where: "email=?", whereArgs: [email]);

      if (maps!.isNotEmpty) {
        // Convert each map in the result set to a ProductModel
        List<ProductModel> products =
            maps.map((map) => ProductModel.fromDb(map)).toList();

        // Print or handle the list of products
        print("$email: $products");

        return products;
      }

      print("User not found");
      return null;
    } catch (e) {
      print("Could not fetch order $e");
      // Handle the exception or return an error response
      return null;
    }
  }


  Future<void> clearOrderByEmail(String? email) async {
    await db!.delete(
      "Orders",
      where: "email = ?",
      whereArgs: [email],
    );
  }
  Future<int> clear() {
    return db!.delete("Users");
  }
}

final userdatabase = UserDatabase();
