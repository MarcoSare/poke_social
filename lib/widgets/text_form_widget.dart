import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class textFormField extends StatefulWidget {
  String label;
  String hint;
  String msgError;
  int inputType;
  int lenght;
  IconData icono;
  var controlador;
  var error = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  textFormField(this.label, this.hint, this.msgError, this.icono,
      this.inputType, this.lenght) {}
  @override
  State<StatefulWidget> createState() => _textFormFieldState();
//State<getDropdownButton> createState() => _getDropdownButtonState(sele);
}

class _textFormFieldState extends State<textFormField> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextFormField(
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.lenght),
                ],
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColorDark)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColorDark)),
                  labelText: widget.label,
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 14),
                  prefixIcon: Container(
                      margin: EdgeInsets.fromLTRB(14, 0, 14, 0),
                      child: Icon(widget.icono, size: 14)),
                  labelStyle: TextStyle(fontSize: 14),
                  errorStyle: TextStyle(fontSize: 14),
                ),
                keyboardType: widget.inputType == 0
                    ? TextInputType.number
                    : TextInputType.text,
                onSaved: (value) {
                  widget.controlador = value;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "fill in this field";
                  } else if (widget.error) {
                    return widget.msgError;
                  }
                },
                onChanged: (value) => setState(() {
                      widget.controlador = value;
                      widget.error = false;
                    }))));
  }
}
