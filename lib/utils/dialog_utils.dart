import 'package:flutter/material.dart';
import 'package:supabase_testing/main.dart';

class DialogUtils {
  static Widget errorDialog({required String msg}) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Text(
              "Something went wrong!",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),

            Text(msg, style: TextStyle(color: Colors.black, fontSize: 14)),

            ElevatedButton(
              onPressed: () {
                Navigator.of(navigationKey.currentContext!).pop();
              },
              child: Text("Okay"),
            ),
          ],
        ),
      ),
    );
  }
}
