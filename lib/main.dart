import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diamondspricelist/getPrice.dart';
import 'package:diamondspricelist/price_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _priceBankIndex = 0;

  String selectedList = 'list61';
  String selectedJewelry = 'RING';

  List<Widget> getDropDownList() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    priceList.forEach((key, value) {
      var newItem = DropdownMenuItem(
        child: Text(key.toString()),
        value: key.toString(),
      );
      dropDownItems.add(newItem);
    });
    return dropDownItems;
  }

  List<Widget> getDropDownJew() {
    List<DropdownMenuItem<String>> dropDownJews = [];
    priceList[selectedList].forEach((key, value) {
      var newJew = DropdownMenuItem(
        child: Text(key.toString()),
        value: key.toString(),
      );
      dropDownJews.add(newJew);
    });
    return dropDownJews;
  }

  String getItem(input) {
    String code = input.toUpperCase();
    if (code[0] == '9' || code[0] == 'N') {
      return priceList['list${code[0]}R'].toString();
    } else if (code[0] == '6') {
      return priceList['list${code[0] + code[1]}'].toString();
    } else {
      return 'false';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
//      appBar: AppBar(
//        title: Text('Home'),
//      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Code",
              ),
              onChanged: (value) {
                if (value != null) {
                  print(getItem(value));
                }
              },
            ),
            ExpansionTile(
              title: Text(
                'Filter',
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton<String>(
                    value: selectedList,
                    isExpanded: true,
                    items: getDropDownList(),
                    onChanged: (value) {
                      setState(() {
                        if (selectedList != value) {
                          selectedList = value;
                          selectedJewelry = 'RING';
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton<String>(
                    value: selectedJewelry,
                    isExpanded: true,
                    items: getDropDownJew(),
                    onChanged: (value) {
                      setState(() {
                        if (selectedJewelry != value) {
                          selectedJewelry = value;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: GetPrice(selectedList, selectedJewelry),
            ),
          ],
        ),
      ),
    ));
  }
}
