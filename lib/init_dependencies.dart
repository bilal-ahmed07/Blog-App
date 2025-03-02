import 'package:blog_app/core/Creds/creds.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_implement.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: Creds.supabaseUrl,
    anonKey: Creds.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDatasourceImplement(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImplement(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignup(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerSingleton(
    () => AuthBloc(
      userSignup: serviceLocator(),
    )
  );
}