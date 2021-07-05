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

Widget mapIcon(VoidCallback onPressed, IconData icons,String heroTag) {
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
