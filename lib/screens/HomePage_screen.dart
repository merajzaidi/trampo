import 'package:Trampo/constants/colorConstant.dart';
import 'package:Trampo/widgets/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/vehicles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../providers/auth.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var vehicle = 'All';
  String location = 'Kanpur';
  TabController controller;
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: AppBar(
          title: DropdownButton<String>(
            hint: Text('Location'),
            dropdownColor: kprimaryColor,
            value: location,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.white,
            ),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.white,
            ),
            onChanged: (String newValue) {
              setState(() {
                location = newValue;
              });
            },
            items: Provider.of<Auth>(context)
                .cities_list
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          bottom: TabBar(
            tabs: [
              new Tab(
                icon: Icon(Icons.location_city),
                text: 'City Vehicles',
              ),
              new Tab(
                icon: Icon(Icons.card_travel),
                text: 'Return Vehicles',
              ),
            ],
          ),
        ),
        drawer: HomeScreenDrawer(),
        body: TabBarView(
          children: [
            Vehicles(location, 'Home'),
            Vehicles(location, 'Return'),
          ],
        ),
      ),
    );
  }
}
