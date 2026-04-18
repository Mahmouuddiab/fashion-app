import 'package:dio/dio.dart';
import 'package:fashion_app/core/helper/cache_helper.dart';
import 'package:fashion_app/core/helper/dio_helper.dart';
import 'package:fashion_app/features/home/data/data%20source/home_remote_ds.dart';
import 'package:fashion_app/features/home/data/models/category_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDs)
class HomeRemoteDsImpl implements HomeRemoteDs {
  @override
  Future<List<CategoryModel>> categories() async{
    final token = await CacheHelper.getToken();
    final response = await DioHelper.getData(
        url: "https://accessories-eshop.runasp.net/api/categories",
        options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }
      )
    );
    if(response.statusCode == 200){
      final List data = response.data['categories'];
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    }
    else{
      throw Exception(response.data);
    }
  }
  
}