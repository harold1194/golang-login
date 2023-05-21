import 'package:flutter/material.dart';

import '../themes/appcolors.dart';

class MyTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final FormFieldValidator<String> validator;
  final TextEditingController textEditingController;
  final TextInputType keyboardtype;
  final bool obscure;
  final bool readonly;
  final bool showicon;
  final int? maxlenght;
  final int? maxline;
  final Function()? ontap;
  const MyTextField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.validator,
    required this.textEditingController,
    this.keyboardtype = TextInputType.text,
    this.obscure = false,
    this.readonly = false,
    this.showicon = true,
    this.maxlenght,
    this.ontap,
    this.maxline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: maxline,
      readOnly: readonly,
      obscureText: obscure,
      keyboardType: keyboardtype,
      onTap: readonly ? ontap : null,
      controller: textEditingController,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 15,
            color: Appcolors.kbleu,
            fontWeight: FontWeight.bold,
          ),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        hintStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 15,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
        prefixIcon: showicon
            ? Icon(
                icon,
                size: 22,
                color: Colors.deepPurple,
              )
            : null,
        suffixIcon: readonly
            ? Icon(
                icon,
                size: 22,
                color: Colors.deepPurple,
              )
            : null,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
