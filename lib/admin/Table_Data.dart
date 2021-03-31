import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/user/constant/const.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/data.dart';

import 'package:foody/user/helper/orderData.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/orderModel.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/paymentmodel.dart';

class TableData extends StatefulWidget {
  OrderModel orderModel;
  TableData(this.orderModel);
  @override
  _TableDataState createState() => _TableDataState(orderModel);
}

class _TableDataState extends State<TableData> {
  OrderModel orderModel;
  PaymentModel payment;

  ///if rhis use then write widget where this use
  _TableDataState(this.orderModel);
  List<Data> productsList = List();
  //List<OrderModel> orderList;

  @override
  void initState() {
    getCat();
    // getprod();

    super.initState();
  }

  getCat() async {
    productsList = await OrderData()
        .getListOfProductsByIDS(idslist: orderModel.productsId);

    setState(() {});
  }

  getPay() async {
    payment =
        await OrderData().getpaymentByIDS(idslist: orderModel.reference.id);
    setState(() {});
  }

  // getprod() async {
  //   orderList = await OrderData().getAllDoc();
  //
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foody"),
        backgroundColor: kcolor2,
      ),
      body: Column(
        children: [
          Container(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Order",
                  textScaleFactor: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Table(
                  textDirection: TextDirection.ltr,
                  defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  border: TableBorder.all(width: 2.0, color: Colors.black54),
                  children: [
                    TableRow(children: [
                      Text(
                        'Food Item',
                        textScaleFactor: 1.5,
                      ),
                      Text('quantity', textScaleFactor: 1.5),
                      Text('price', textScaleFactor: 1.5),
                    ]),
                  ]),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: productsList.length,
                  itemBuilder: (_, index) {
                    return Table(
                      textDirection: TextDirection.ltr,
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border:
                          TableBorder.all(width: 2.0, color: Colors.black54),
                      children: [
                        TableRow(children: [
                          Text(
                            '${productsList[index].name}',
                            textScaleFactor: 1.5,
                          ),
                          Text("${widget.orderModel.quantity[index]}",
                              textScaleFactor: 1.5),
                          Text("${productsList[index].price}",
                              textScaleFactor: 1.5),
                        ]),
                      ],
                    );
                  }),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        'Total Price: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        orderModel.total.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Container(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Payment",
                  textScaleFactor: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Table(
                  textDirection: TextDirection.ltr,
                  defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  border: TableBorder.all(width: 2.0, color: Colors.black54),
                  children: [
                    TableRow(children: [
                      Text(
                        'Name',
                        textScaleFactor: 1.5,
                      ),
                      Text('Method', textScaleFactor: 1.5),
                      Text('Number', textScaleFactor: 1.5),
                    ]),
                  ]),
              Table(
                textDirection: TextDirection.ltr,
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(width: 2.0, color: Colors.black54),
                children: [
                  TableRow(children: [
                    Text(
                      '${payment.name}',
                      textScaleFactor: 1.5,
                    ),
                    Text("${payment.method}", textScaleFactor: 1.5),
                    Text("${payment.number}", textScaleFactor: 1.5),
                  ]),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        'Total Price: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        orderModel.total.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
