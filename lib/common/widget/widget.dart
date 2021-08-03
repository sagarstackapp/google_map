import 'package:flutter/material.dart';
import 'package:google_map/common/constant/colors.dart';

Widget topAppBar() {
  return PreferredSize(
    preferredSize: Size(double.infinity, 60),
    child: AppBar(
      backgroundColor: ColorResources.Red,
      title: Text('Google Map'),
      centerTitle: true,
      elevation: 10,
      shadowColor: Color(0xFFFFE35452),
    ),
  );
}

Widget mapIcon(VoidCallback onPressed, IconData icons, String heroTag) {
  return FloatingActionButton(
    onPressed: onPressed,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    backgroundColor: ColorResources.Red,
    heroTag: heroTag,
    child: Icon(
      icons,
      size: 36.0,
    ),
  );
}

Widget searchAddressField(
    VoidCallback onPressed,
    ValueChanged<String> onChanged,
    TextEditingController controller,
    String hint,
    IconData icon) {
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 15, top: 15),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 25,
        ),
      ),
      onChanged: onChanged,
    ),
  );
}

Widget searchLocationField({
  TextEditingController controller,
  GestureTapCallback onTap,
  ValueChanged<String> onChanged,
  IconData icon,
  String hint,
  bool autoFocus = false,
  bool readOnly = false,
}) {
  return Container(
    margin: EdgeInsets.only(top: 40, left: 10, right: 10),
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.grey),
    ),
    child: TextField(
      controller: controller,
      autofocus: autoFocus,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      style: TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(icon ?? Icons.pin_drop, color: Colors.black54),
        suffixIcon: Icon(Icons.keyboard_voice, color: Colors.black54),
        border: InputBorder.none,
        hintText: hint ?? 'Search here',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    ),
  );
}
