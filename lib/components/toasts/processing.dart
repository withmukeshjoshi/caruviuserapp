import 'package:flutter/material.dart';

class ProcessingToast extends StatelessWidget {
  final message;
  const ProcessingToast(
      {Key? key, this.message = "Authenticating User. Please wait..."})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.av_timer_outlined),
          SizedBox(
            width: 12.0,
          ),
          Text(this.message),
        ],
      ),
    );
  }
}
