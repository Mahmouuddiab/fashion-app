import 'package:fashion_app/features/home/domain/usecase/category_usecase.dart';
import 'package:fashion_app/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  CategoryUseCase categoryUseCase;
  HomeCubit(this.categoryUseCase):super(HomeInitialState());
  Future<void> getHome()async{
    emit(HomeLoading());
    try{
      final categories = await categoryUseCase.call();
      emit(HomeLoaded(categories: categories));
    }
    catch(e){
      emit(HomeError(e.toString()));
    }
  }
}