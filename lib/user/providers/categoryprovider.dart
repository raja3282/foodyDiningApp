import 'package:flutter/cupertino.dart';
import 'package:foody/models/fooditemModel.dart';
import 'package:foody/user/providers/my_provider.dart';

class CategoryProvider with ChangeNotifier {
  MyProvider _categoryServices = MyProvider();
  List<Category> categories = [];

  CategoryProvider.initialize() {
    loadCategories();
  }

  loadCategories() async {
    categories = await _categoryServices.getCategory();
    notifyListeners();
  }
}
