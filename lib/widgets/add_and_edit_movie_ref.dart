// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//Title of fields

Widget addAndEditMovieTitile(String name) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: Text(
      name,
      style: GoogleFonts.ubuntu(
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
    ),
  );
}

//Textformfield

Widget addAndEditMovieTextField(
    String hintText,
    TextEditingController controller,
    String errormessage,
    TextInputType keyboardtype) {
  return Container(
    width: 170,
    decoration: const BoxDecoration(),
    child: Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          maxLines: null,
          keyboardType: keyboardtype,
          validator: (value) {
            if (value!.isEmpty) {
              return errormessage;
            } else {
              return null;
            }
          },
          controller: controller,
          style: const TextStyle(fontSize: 15, color: Colors.white),
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 39, 38, 38),
              filled: true,
              contentPadding: const EdgeInsets.only(left: 20),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey, width: 2)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 247, 247, 247),
                ),
              )),
        ),
      ],
    ),
  );
}

//date textformfield

class DateTextformField extends StatefulWidget {
  final dateFocusNode;
  final dateController;
  const DateTextformField(
      {super.key, required this.dateFocusNode, required this.dateController});

  @override
  State<DateTextformField> createState() => _DateTextformFieldState();
}

class _DateTextformFieldState extends State<DateTextformField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: widget.dateFocusNode,
      readOnly: true,
      onTap: () {
        widget.dateFocusNode.requestFocus();
        _selectDate(context);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Date is Needed';
        } else {
          return null;
        }
      },
      controller: widget.dateController,
      style: const TextStyle(fontSize: 15, color: Colors.white),
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 39, 38, 38),
          filled: true,
          contentPadding: const EdgeInsets.only(left: 13),
          hintText: 'Select Date',
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey, width: 2)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          )),
    );
  }

//date picker

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        widget.dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }
}

//movie review textformfield

reviewTextformField(reviewcontroller) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    style: const TextStyle(color: Colors.white),
    keyboardType: TextInputType.multiline,
    controller: reviewcontroller,
    maxLines: null,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field is needed';
      } else {
        return null;
      }
    },
    decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 39, 38, 38),
        filled: true,
        hintText: 'Write review...',
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(30)),
        border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 189, 188, 188)),
            borderRadius: BorderRadius.circular(30))),
  );
}

//genre and language dropdown textfield

class DropdownFormField extends StatefulWidget {
  final String selectedGenre;
  final ValueChanged<String> onGenreChanged;
  final List<String> options;
  final String hintText;
  final String? initialvalue;
  const DropdownFormField(
      {super.key,
      required this.selectedGenre,
      required this.onGenreChanged,
      required this.options,
      required this.hintText,
      this.initialvalue});

  @override
  State<DropdownFormField> createState() => _dropdownFormFieldState();
}

class _dropdownFormFieldState extends State<DropdownFormField> {
  String? selectedvalue;

  @override
  void initState() {
    selectedvalue = widget.initialvalue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        children: [
          DropdownButtonFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Genre is needed';
                } else {
                  return null;
                }
              },
              value: selectedvalue,
              dropdownColor: Colors.teal,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 39, 38, 38),
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 20),
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 247, 247, 247),
                    ),
                  )),
              items: widget.options
                  .map((String option) =>
                      DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedvalue = value.toString();
                  widget.onGenreChanged(selectedvalue!);
                });
              }),
        ],
      ),
    );
  }
}

//submit button

Widget submitButton(void Function() onPressed) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                fixedSize: const Size(160, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: Text(
              'Submit',
              style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black)),
            )),
      ],
    ),
  );
}



//add theater textformfield

Widget addTheaterTextField(String hintText, TextEditingController controller,
    TextInputType keyboardtype) {
  return Container(
    width: 170,
    decoration: const BoxDecoration(),
    child: Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: null,
          keyboardType: keyboardtype,
          controller: controller,
          style: const TextStyle(fontSize: 15, color: Colors.white),
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 39, 38, 38),
              filled: true,
              contentPadding: const EdgeInsets.only(left: 20),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey, width: 2)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 247, 247, 247),
                ),
              )),
        ),
      ],
    ),
  );
}

//comment section textformfield

Widget commentSessionTextfield(void Function() onPressed,
    TextEditingController commentController, formkey, RegExp nameregx) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Form(
      key: formkey,
      child: TextFormField(
        controller: commentController,
        style: const TextStyle(color: Colors.white),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Comment is needed !';
          } else if (!nameregx.hasMatch(value)) {
            return 'Contains only Alphabets ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            hintText: 'Add Comment . . .',
            contentPadding: const EdgeInsets.only(left: 5),
            hintStyle: GoogleFonts.ubuntu(
                textStyle: const TextStyle(color: Colors.white)),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 174, 243, 236))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            suffixIcon: IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ))),
      ),
    ),
  );
}
