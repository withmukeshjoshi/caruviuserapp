import 'package:flutter/material.dart';

class ErrorToast extends StatelessWidget {
  final message;
  const ErrorToast({Key? key, this.message = "Opps! Something went wrong"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            this.message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
