import 'package:Trampo/constants/colorConstant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Vehicles extends StatefulWidget {
  var city, type;
  Vehicles(this.city, this.type);

  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  var vehicle_type = 'All';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: 15,
            top: 25,
          ),
          padding: EdgeInsets.symmetric(horizontal: 40),
          width: width * 0.60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text('Vehicle Category '),
            value: vehicle_type,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            icon: Icon(
              Icons.search,
            ),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.white,
            ),
            onChanged: (String newValue) {
              setState(() {
                vehicle_type = newValue;
              });
            },
            items: [
              'Tata Ace',
              '3 Wheeler',
              'Tata 407',
              'Pickup 8FT',
              'All',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        StreamBuilder(
          stream: vehicle_type != 'All'
              ? FirebaseFirestore.instance
                  .collection('City')
                  .doc(widget.city)
                  .collection(widget.type)
                  .where('Vehicle Category', isEqualTo: vehicle_type)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('City')
                  .doc(widget.city)
                  .collection(widget.type)
                  .snapshots(),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Column(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(document.data()['Vehicle Photo']),
                  ),
                  title: Text(document.data()['Vehicle No']),
                  subtitle: Text(
                      '${document.data()['Vehicle Category']} Capacity ${document.data()['Vehicle Upload']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () async {
                      await launch('tel:+91//${document.data()['Phone']}');
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
