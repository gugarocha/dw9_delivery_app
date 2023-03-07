import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/unauthorized_exceptions.dart';
import '../../../repositories/auth/auth_repository.dart';
import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));

      final authModel = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();

      sp.setString('accessToken', authModel.accessToken);
      sp.setString('refreshToken', authModel.refreshToken);

      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedExceptions catch (e, s) {
      log('E-mail ou senha inválidos', error: e, stackTrace: s);

      emit(
        state.copyWith(
          status: LoginStatus.loginError,
          errorMessage: 'E-mail ou Senha inválidos',
        ),
      );
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);

      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: 'Erro ao realizar login',
        ),
      );
    }
  }
}
