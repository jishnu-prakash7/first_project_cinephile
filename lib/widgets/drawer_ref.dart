import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;
  final Color? iconColor;
  const DrawerListTile(
      {super.key, required this.icon, required this.text, required this.onTap,this.iconColor});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color:iconColor?? Colors.white,
      ),
      title: Text(text,
          style: GoogleFonts.ubuntu(
              textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 201, 200, 200)))),
    );
  }
}
