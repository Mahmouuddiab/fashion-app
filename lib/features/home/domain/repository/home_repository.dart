import 'package:fashion_app/features/home/domain/entity/category_entity.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> categories () ;
}