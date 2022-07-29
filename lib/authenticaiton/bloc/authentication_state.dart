part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationFailiure extends AuthenticationState {
  final String message;
  AuthenticationFailiure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class AuthenticationSuccess extends AuthenticationState {
  final AuthenticationModel authenticationDetail;
  AuthenticationSuccess({
    required this.authenticationDetail,
  });
  @override
  List<Object> get props => [authenticationDetail];
}
