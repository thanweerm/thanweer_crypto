part of 'crypto_bloc.dart';

@immutable
abstract class CryptoEvent extends Equatable {
  const CryptoEvent();
}

class LoadApiEvent extends CryptoEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadMoreApiEvent extends CryptoEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
