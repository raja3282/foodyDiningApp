import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foody/models/fooditemModel.dart';
import 'package:foody/user/helper/screen_navigation.dart';
import 'package:foody/user/providers/app.dart';
import 'package:foody/user/screens/details.dart';
import 'package:provider/provider.dart';

class Featured extends StatelessWidget {
  List<Category> productsList;
  Featured(this.productsList);

  @override
  Widget build(BuildContext context) {
    // final AppProvider app = Provider.of<AppProvider>(context);
    // if (productsList.length > 0) {
    //   app.changeLoading();
    // }

    return
        //app.isLoading
        // ? Container(
        //     color: Colors.white,
        //     child: SpinKitFadingCircle(
        //       color: Colors.black,
        //       size: 30,
        //     ))
        ListView.builder(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: productsList?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            leading: Image.network(
              productsList[index].image,
              height: 80,
              width: 80,
            ),
            title: Text(
              productsList[index].name,
            ),
            subtitle: Text('Rs.${productsList[index].price.toString()}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              changeScreenReplacement(
                  context,
                  DetailPage(
                    name: productsList[index].name,
                    image: productsList[index].image,
                    price: productsList[index].price,
                    productid: productsList[index].id,
                    rating: productsList[index].rating,
                    description: productsList[index].description,
                  ));
            },
          ),
        );
      },
    );
  }
}
