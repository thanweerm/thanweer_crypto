import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:cryptonew/authenticaiton/data/repositories/authenticaiton_repository.dart';
import 'package:cryptonew/authenticaiton/models/authentication_model.dart';

import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AuthenticationInitial());

  StreamSubscription<AuthenticationModel>? authStreamSub;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      try {
        emit(AuthenticationLoading());
        // if authentication is loading then add authenticationstatechanged
        authStreamSub = _authenticationRepository
            .getAuthDetailStream()
            .listen((authDetail) {
          add(AuthenticationStateChanged(authenticationDetail: authDetail));
        });
      } catch (error) {
        print(
            'Error occured while fetching authentication detail : ${error.toString()}');
        emit(AuthenticationFailiure(
            message: 'Error occrued while fetching auth detail'));
      }
    } else if (event is AuthenticationStateChanged) {
      // if authenticationstate changed check authentication is valid
      if (event.authenticationDetail.isValid!) {
        emit(AuthenticationSuccess(
            authenticationDetail: event.authenticationDetail));
      } else {
        emit(AuthenticationFailiure(message: 'User has logged out'));
      }
    } else if (event is AuthenticationGoogleStarted) {
      try {
        emit(AuthenticationLoading());
        AuthenticationModel authenticationDetail =
            await _authenticationRepository.authenticateWithGoogle();

        if (authenticationDetail.isValid!) {
          emit(AuthenticationSuccess(
              authenticationDetail: authenticationDetail));
        } else {
          emit(AuthenticationFailiure(message: 'User detail not found.'));
        }
      } catch (error) {
        print('Error occured while login with Google ${error.toString()}');
        emit(AuthenticationFailiure(
          message: 'Unable to login with Google. Try again.',
        ));
      }
    } else if (event is AuthenticationExited) {
      try {
        emit(AuthenticationLoading());
        await _authenticationRepository.unAuthenticate();
      } catch (error) {
        print('Error occured while logging out. : ${error.toString()}');
        emit(AuthenticationFailiure(
            message: 'Unable to logout. Please try again.'));
      }
    }
  }
}
