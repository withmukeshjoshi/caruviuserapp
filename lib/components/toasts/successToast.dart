import 'package:flutter/material.dart';

class SuccessToast extends StatelessWidget {
  final message;
  const SuccessToast(
      {Key? key, this.message = "Authenticating User. Please wait..."})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green[900],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
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
