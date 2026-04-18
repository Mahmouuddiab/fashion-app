import 'package:fashion_app/features/home/data/data%20source/home_remote_ds.dart';
import 'package:fashion_app/features/home/domain/entity/category_entity.dart';
import 'package:fashion_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRemoteDs remote;
  HomeRepositoryImpl(this.remote);

  @override
  Future<List<CategoryEntity>> categories() async{
    final dto = await remote.categories();
    return dto ;
  }
}