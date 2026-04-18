import 'package:fashion_app/features/home/data/models/category_model.dart';

abstract class HomeRemoteDs {
  Future<List<CategoryModel>> categories () ;
}