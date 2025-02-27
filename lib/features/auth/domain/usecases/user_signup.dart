import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignupParameter {
  final String name;
  final String email;
  final String password;
  UserSignupParameter({
    required this.name,
    required this.email,
    required this.password,
  });
}

class UserSignup implements UseCase<String, UserSignupParameter> {
  final AuthRepository authRepository;
  UserSignup({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(UserSignupParameter parameter) async {
    return await authRepository.signupWithEmailPassword(
      name: parameter.name,
      email: parameter.email,
      password: parameter.password,
    );
  }
}
