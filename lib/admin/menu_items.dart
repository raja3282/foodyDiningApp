import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foody/admin/crud.dart';
import 'package:foody/admin/home.dart';
import 'package:foody/models/food_item.dart';
import 'package:foody/user/constant/const.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/user/providers/my_provider.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/fooditemModel.dart';

import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/user/helper/screen_navigation.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class Menu_Items extends StatefulWidget {
  @override
  _Menu_ItemsState createState() => _Menu_ItemsState();
}

class _Menu_ItemsState extends State<Menu_Items> {
  List<Category> productsList;
  int pprice;
  String nname;
  String iimage;
  @override
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.getCategory();
    productsList = provider.throwcategoryList;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kcolor2, //Color(0xff213777),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            changeScreen(context, Home());
          },
        ),
        title: Center(
            child: Text(
          'FOODY',
          style: kappbarstyle,
        )),
      ),
      body: Container(
        // height: double.infinity,
        color: Colors.white,
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Food Items',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  Text(
                    'Add Item',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _popup(context);
                        });
                      })
                ],
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: productsList?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Slidable(
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Update',
                        color: Colors.grey.shade300,
                        icon: Icons.edit,
                        closeOnTap: false,
                        onTap: () {
                          Toast.show('Updata On $index', context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                          setState(() {
                            Alert(
                                context: context,
                                title: "Update This Item",
                                content: Form(
                                  key: formkey,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons
                                                .drive_file_rename_outline),
                                            labelText: 'Name',
                                          ),
                                          validator: (value) {
                                            nname = value;
                                            if (value.isEmpty) {
                                              return 'Please Enter Valid name';
                                            }
                                            return null;
                                          }),
                                      TextFormField(
                                        keyboardType: TextInputType.url,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.image),
                                          labelText: 'Image Url',
                                        ),
                                        validator: (value) {
                                          iimage = value;
                                          if (value.isEmpty) {
                                            return 'Please Enter Valid address';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.money),
                                          labelText: 'price',
                                        ),
                                        validator: (value) {
                                          pprice = int.parse(value);
                                          assert(pprice is int);
                                          if (value.isEmpty) {
                                            return 'Please Enter Valid value';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                buttons: [
                                  DialogButton(
                                    onPressed: () {
                                      if (formkey.currentState.validate()) {
                                        setState(() {
                                          Crud().update(
                                              productsList[index].name,
                                              nname,
                                              pprice,
                                              iimage);
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        return null;
                                      }
                                    },
                                    child: Text(
                                      "UPDATE",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ]).show();
                          });
                        },
                      ),
                      IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red.shade300,
                          icon: Icons.remove,
                          closeOnTap: true,
                          onTap: () {
                            Toast.show(
                                'Deleted ${productsList[index].name}', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                            setState(() {
                              Crud().delete(productsList[index].name);
                              productsList.removeAt(index);
                            });
                          }),
                    ],
                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    ),
                    child: Card(
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                        leading: Image.network(
                          productsList[index].image,
                          height: 80,
                          width: 80,
                        ),
                        title: Text(
                          productsList[index].name,
                        ),
                        subtitle:
                            Text('Rs.${productsList[index].price.toString()}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _popup(context) {
    Alert(
        context: context,
        title: "Add food Item",
        content: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.drive_file_rename_outline),
                  labelText: 'Name',
                ),
                validator: (value) {
                  nname = value;
                  if (value.isEmpty) {
                    return 'Please Enter Valid value';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  icon: Icon(Icons.image),
                  labelText: 'Image Url',
                ),
                validator: (value) {
                  iimage = value;
                  if (value.isEmpty) {
                    return 'Please Enter Valid value';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.money),
                  labelText: 'price',
                ),
                validator: (value) {
                  pprice = int.parse(value);
                  assert(pprice is int);
                  if (value.isEmpty) {
                    return 'Please Enter Valid value';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (formkey.currentState.validate()) {
                setState(() {
                  Crud().add(nname, pprice, iimage);
                  Navigator.pop(context);
                });
              } else {
                return null;
              }
            },
            child: Text(
              "Add Items",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
