// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data%20source/auth_remote_ds.dart' as _i6;
import '../../features/auth/data/data%20source/auth_remote_ds_impl.dart'
    as _i624;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/domain/usecase/verify_email_usecase.dart' as _i913;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../helper/dio_helper.dart' as _i408;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i408.DioHelper>(() => _i408.DioHelper());
    gh.factory<_i6.AuthRemoteDs>(() => _i624.AuthRemoteDsImpl());
    gh.factory<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(gh<_i6.AuthRemoteDs>()),
    );
    gh.factory<_i911.LoginUseCase>(
      () => _i911.LoginUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i769.RegisterUseCase>(
      () => _i769.RegisterUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i913.VerifyEmailUseCase>(
      () => _i913.VerifyEmailUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        gh<_i769.RegisterUseCase>(),
        gh<_i913.VerifyEmailUseCase>(),
        gh<_i911.LoginUseCase>(),
      ),
    );
    return this;
  }
}
