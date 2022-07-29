part of 'crypto_bloc.dart';

@immutable
abstract class CryptoState extends Equatable {
  const CryptoState();
}

class CryptoLoadingState extends CryptoState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CryptoLoadedState extends CryptoState {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<Result>? results;

  const CryptoLoadedState(this.count, this.next, this.previous, this.results);

  @override
  // TODO: implement props
  List<Object?> get props => [count, next, previous, results];
}
