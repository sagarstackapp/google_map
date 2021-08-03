import 'package:flutter/material.dart';
import 'package:google_map/common/constant/colors.dart';
import 'package:google_map/common/widget/widget.dart';
import 'package:google_map/service/place_provider.dart';
import 'package:google_map/service/suggestion_service.dart';

class SourceScreen extends StatefulWidget {
  @override
  SourceScreenState createState() => SourceScreenState();
}

class Suggestions {
  final double lat;
  final double long;
  final String desc;
  Suggestions(this.lat, this.long, this.desc);
}

List<Suggestions> suggestionDetails = [
  Suggestions(21.1702, 72.8311, 'Surat'),
  Suggestions(28.7041, 77.1025, 'Delhi'),
  Suggestions(46.2276, 2.2137, 'France'),
  Suggestions(48.8566, 2.3522, 'Paris'),
  Suggestions(25.2048, 55.2708, 'Dubai'),
];

class SourceScreenState extends State<SourceScreen> {
  TextEditingController sourceController = TextEditingController();
  String sourceName = '';
  PlaceApiProvider placeApiProvider = PlaceApiProvider();
  Suggestion suggestion;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.White,
      body: Column(
        children: [
          searchLocationField(
              controller: sourceController,
              autoFocus: true,
              icon: Icons.arrow_back,
              onChanged: (value) {
                setState(() {
                  sourceName = value;
                });
              }),
          Expanded(
            child: ListView.builder(
                itemCount: suggestionDetails.length,
                itemBuilder: (context, index) {
                  var data = suggestionDetails[index];
                  return ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.black87,
                      ),
                    ),
                    title: Text(
                      data.desc,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data.lat}° N, ${data.long}° E',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Icon(Icons.trending_up, color: Colors.black87),
                    onTap: () {
                      Navigator.pop(context, data);
                    },
                  );
                }),
          ),
          // Expanded(
          //   child: FutureBuilder(
          //     future: sourceName == ""
          //         ? null
          //         : placeApiProvider.fetchSuggestions(sourceName),
          //     builder: (context, AsyncSnapshot<List<Suggestion>> snapshot) =>
          //         sourceName == ''
          //             ? Center(child: Text('Enter source location'))
          //             : snapshot.hasData
          //                 ? ListView.builder(
          //                     // itemCount: snapshot.data.length,
          //                     itemCount: 5,
          //                     itemBuilder: (context, index) {
          //                       var data = snapshot.data[index];
          //                       return ListTile(
          //                         leading: Container(
          //                           padding: EdgeInsets.all(6),
          //                           decoration: BoxDecoration(
          //                             shape: BoxShape.circle,
          //                             color: Colors.grey.withOpacity(0.3),
          //                           ),
          //                           child: Icon(
          //                             Icons.location_on_outlined,
          //                             color: Colors.black87,
          //                           ),
          //                         ),
          //                         title: Text(
          //                           'data.description',
          //                           style: TextStyle(
          //                             color: Colors.black,
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                         ),
          //                         subtitle: Text(
          //                           'data.placeId',
          //                           style: TextStyle(
          //                             color: Colors.grey,
          //                             fontSize: 12,
          //                           ),
          //                         ),
          //                         trailing: Icon(Icons.trending_up,
          //                             color: Colors.black87),
          //                         onTap: () {
          //                           Navigator.pop(context,
          //                               snapshot.data[index] as Suggestion);
          //                         },
          //                       );
          //                     })
          //                 : Center(
          //                     child: Text('Fetching Location $sourceName'),
          //                   ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
