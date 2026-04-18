import 'package:fashion_app/features/home/domain/entity/category_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<CategoryEntity> categories;
  HomeLoaded({required this.categories});
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
