import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  const TransactionAuthDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        obscureText: true,
        controller: _controller,
        maxLength: 4,
        decoration: InputDecoration(border: OutlineInputBorder()),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 64, letterSpacing: 24),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm(_controller.text);
            Navigator.pop(context);
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
