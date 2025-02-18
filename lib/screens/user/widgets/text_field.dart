import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String text;
  final String icon;
  final TextEditingController controller;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePasswordVisibility;

  const TextFieldWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePasswordVisibility,
  });

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Giữ kích thước hợp lý
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? !widget.isPasswordVisible : false,
        keyboardType: widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
        textInputAction: widget.isPassword ? TextInputAction.done : TextInputAction.next,
        autocorrect: !widget.isPassword,
        enableSuggestions: !widget.isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF7F7F7),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Image.asset(widget.icon, height: 20, width: 20),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 50, minHeight: 50),
          labelText: widget.text,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              widget.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: widget.onTogglePasswordVisibility,
          )
              : null,
        ),
      ),
    );
  }
}
