import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hint;
  bool obs;
  bool obx;
  bool? input;
  TextInputType type;
  final Color color;
  Function ontap;
  int ? max;
  
  TextEditingController controller;

  CustomTextFormField({
    Key? key,
    required this.hint,
     this.max=2,
    required this.obx,
    required this.ontap,
    required this.type,
    this.input,
    required this.obs,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    if (widget.obx == true) {
      return Container(
        padding: const EdgeInsets.only(right: 16,bottom: 20,left:14),
        decoration:BoxDecoration(
          border:Border.all(color:Colors.black45),
          borderRadius: BorderRadius.circular(2),
          color:Colors.white
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: widget.obs,
          onTap: widget.ontap(),
          controller: widget.controller,
          style: TextStyle(
            color: widget.color,
          ),
          decoration: InputDecoration(
            label: Text(widget.hint,style:const TextStyle(color:Colors.grey,
            )),
            //hintText: widget.hint,
            labelStyle: TextStyle(
              color: widget.color,
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: Icon(
                widget.obs ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  widget.obs = !widget.obs;
                });
              },
            ),
          ),
        ),
      );
    }

    if (widget.obx == false) {
      return Container(
        decoration:BoxDecoration(
            border:Border.all(color:Colors.black45),
            borderRadius: BorderRadius.circular(2),
            color:Colors.white),

        padding: const EdgeInsets.all(11),
        child: TextFormField(
          onTap: widget.ontap(),
          obscureText: widget.obs,
          keyboardType: widget.type,
          maxLines: widget.max,
          controller: widget.controller,
          style: TextStyle(
            color: widget.color,
          ),
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: widget.color,
            ),
            label: Text(widget.hint,style:const TextStyle(color:Colors.grey)),

          //  hintText: widget.hint,
            //hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
          ),
        ),
      );
    }

    if (widget.input == true) {
      return Container(
        padding: const EdgeInsets.all(11),
        decoration:BoxDecoration(
            border:Border.all(color:Colors.black45),
            borderRadius: BorderRadius.circular(2),
            color:Colors.white),
        child: TextFormField(
          onTap: widget.ontap(),
          obscureText: widget.obs,
          keyboardType: TextInputType.number,
          maxLines: widget.max,
          controller: widget.controller,
          style: TextStyle(
            color: widget.color,
          ),
          decoration: InputDecoration(
            label: Text(widget.hint,style:const TextStyle(color:Colors.grey)),
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white,
          ),
        ),
      );
    }

    return Container();
  }
}
