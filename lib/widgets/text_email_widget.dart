import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class emailFormField extends StatefulWidget{
  String label;
  String hint;
  String msgError;
  var controlador;
  var  error = false;
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  emailFormField(this.label,this.hint,this.msgError){
  }
  @override
  State<StatefulWidget> createState() => _emailFormFieldState();
//State<getDropdownButton> createState() => _getDropdownButtonState(sele);
}

class _emailFormFieldState extends State<emailFormField> {
  @override
  Widget build(BuildContext context) {




    return  Form(
        key: widget.formKey,
        child:
        Container(
            margin:  EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                textInputAction: TextInputAction.next,
                style:  TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Theme.of(context).primaryColorDark)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide()),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Theme.of(context).errorColor)),
                  labelText: widget.label,
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 14),
                  prefixIcon: Container(
                      margin:  EdgeInsets.fromLTRB(14, 0, 14, 0),
                      child:
                      Icon(Icons.email, size: 14)
                  ),
                  labelStyle: TextStyle(fontSize: 14),
                  errorStyle:   TextStyle(fontSize: 14),
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: [AutofillHints.email],
                onSaved: (value){
                  widget.controlador = value;
                }, autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter your email";
                  }
                  else
                  if(!EmailValidator.validate(value)){
                    return "Enter a valid email";
                  }
                  else
                  if(widget.error){
                    return widget.msgError;
                  }
                },
                onChanged: (value) => setState((){
                  widget.controlador = value;
                  widget.error=false;
                })
            )));
  }
}