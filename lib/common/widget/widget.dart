import 'package:flutter/material.dart';
import 'package:google_map/common/constant/colors.dart';

Widget topAppBar(context) {
  return PreferredSize(
    preferredSize: Size(double.infinity, 60),
    child: AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        'Google Map',
        style: TextStyle(letterSpacing: 1.5, color: ColorResources.LightBlue),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorResources.LightBlue),
      elevation: 0,
    ),
  );
}

Widget mapIcon(VoidCallback onPressed, IconData icons, String heroTag) {
  return FloatingActionButton(
    onPressed: onPressed,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    backgroundColor: ColorResources.Red,
    heroTag: heroTag,
    child: Icon(icons, size: 36.0),
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
    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
    height: 50,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorResources.LightBlue),
    ),
    child: TextField(
      textAlign: TextAlign.start,
      controller: controller,
      autofocus: autoFocus,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      style: TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset('assets/images/location.png'),
        ),
        border: InputBorder.none,
        hintText: hint ?? 'Search here',
        hintStyle: TextStyle(
          color: ColorResources.LightBlue,
          fontSize: 16,
          fontFamily: 'JetBrains',
        ),
      ),
    ),
  );
}

Widget commonElevatedButton({VoidCallback onPressed, String text}) {
  return Container(
    height: 40,
    width: 180,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: ColorResources.White)),
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        backgroundColor: MaterialStateProperty.all(
          ColorResources.LightBlue.withOpacity(0.8),
        ),
      ),
    ),
  );
}
