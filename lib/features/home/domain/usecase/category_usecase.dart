import 'package:fashion_app/features/home/domain/entity/category_entity.dart';
import 'package:fashion_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryUseCase {
  HomeRepository repository;
  CategoryUseCase(this.repository);
  Future<List<CategoryEntity>> call()=> repository.categories();
}