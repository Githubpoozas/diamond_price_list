import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diamondspricelist/price_list.dart';

class GetPrice extends StatelessWidget {
  final String list;
  final String jewelry;

  GetPrice(this.list, this.jewelry);

  var forMat = new NumberFormat("###,000", "en_US");

  Text textWithStyle(String input) {
    return Text(
      input,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
    );
  }

  Text diamondTotalWeight(List quantity) {
    double weightTemp = 0;
    quantity.forEach((item) {
      weightTemp = weightTemp + double.parse(item.split('=')[1]);
    });
    return textWithStyle(weightTemp.toStringAsFixed(2));
  }

  Text diamondQuantity(List quantity) {
    double quantityTemp = 0;
    quantity.forEach((item) {
      quantityTemp =
          quantityTemp + double.parse(item.split('=')[0].substring(1));
    });
    return textWithStyle(quantityTemp.toStringAsFixed(0));
  }

  List<Text> getGoldWeight(item) {
    if (item.containsKey('goldWeight')) {
      return [
        textWithStyle("น้ำหนักทอง"),
        textWithStyle(item['goldWeight'].toString())
      ];
    } else {
      return [
        textWithStyle("น้ำหนักทองขาว"),
        textWithStyle(item['whiteGoldWeight'].toString())
      ];
    }
  }

  List<Widget> getNote(item) {
    if (item.containsKey('note')) {
      return [
        textWithStyle("หมายเหตุ"),
        textWithStyle(item['note'].toString())
      ];
    } else {
      return [Text(''), Text('')];
    }
  }

  Widget getList(list, item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/$list/${item['code']}.jpeg',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 15,
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    textWithStyle("รหัส"),
//                    textWithStyle(item['code'].toString()),
                    Text(
                      item['code'].toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                TableRow(
                  children: getGoldWeight(item),
                ),
                TableRow(
                  children: [
                    textWithStyle("น้ำหนักเพชร"),
                    TableCell(
                        child: Column(
                      children: <Widget>[
                        ...(item['diamondWeight'] as List<String>)
                            .map((weight) {
                          return textWithStyle(weight);
                        }).toList()
                      ],
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    textWithStyle("เพชรรวม"),
                    diamondQuantity(item['diamondWeight']),
                  ],
                ),
                TableRow(
                  children: [
                    textWithStyle("น้ำหนักเพชรรวม"),
                    diamondTotalWeight(item['diamondWeight']),
                  ],
                ),
                TableRow(
                  children: [
                    textWithStyle("Yellow Gold"),
                    textWithStyle(
                      forMat.format(item['yellowGoldPrice']).toString(),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    textWithStyle("White Gold"),
                    textWithStyle(
                      forMat.format(item['whiteGoldPrice']).toString(),
                    )
                  ],
                ),
                TableRow(
                  children: getNote(item),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...(priceList[list][jewelry]).map((item) {
          return getList(list, item);
        })
      ],
    );
  }
}
