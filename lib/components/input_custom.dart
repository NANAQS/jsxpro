import 'package:flutter/material.dart';

class InputCustom extends StatefulWidget {
  final String text;
  final bool password;
  final Function(String value) validador;
  final TextEditingController inputController;
  const InputCustom(
      {super.key,
      required this.text,
      required this.password,
      required this.validador,
      required this.inputController});

  @override
  State<InputCustom> createState() => _InputCustomState();
}

class _InputCustomState extends State<InputCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(bottom: 30),
      child: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: TextFormField(
          controller: widget.inputController,
          validator: (value) => widget.validador(value!),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.text,
          ),
          obscureText: widget.password,
        ),
      ),
    );
  }
}
