import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class CustomToast {
  static void showSuccessToast(String message) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (cancel) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.green.shade700),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.green),
                onPressed: cancel,
              ),
            ],
          ),
        );
      },
    );
  }

  static void showInfoToast(String message) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (cancel) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.blue),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.blue.shade700),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.blue),
                onPressed: cancel,
              ),
            ],
          ),
        );
      },
    );
  }

  static void showWarningToast(String message) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (cancel) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.yellow),
          ),
          child: Row(
            children: [
              Icon(Icons.warning, color: Colors.yellow.shade900),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.yellow.shade900),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.yellow.shade900),
                onPressed: cancel,
              ),
            ],
          ),
        );
      },
    );
  }

  static void showErrorToast(String message) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (cancel) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red),
          ),
          child: Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.red.shade700),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: cancel,
              ),
            ],
          ),
        );
      },
    );
  }
}
