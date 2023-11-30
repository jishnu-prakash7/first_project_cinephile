import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
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

//submit button

// submitButton(addmovie movie) {
//   return 
// }
