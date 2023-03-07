import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/unauthorized_exceptions.dart';
import '../../models/auth_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar usuário');
    }
  }

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if(e.response?.statusCode == 403) {
        log('Permissão Negada', error: e, stackTrace: s);
        throw UnauthorizedExceptions();
      }

      log('Erro ao realizar Login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar Login');
    }
  }
}
