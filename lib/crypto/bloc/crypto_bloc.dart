import 'package:bloc/bloc.dart';
import 'package:cryptonew/crypto/resources/crypto_api_services.dart';
import 'package:cryptonew/crypto/models/crypto_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoApiServices _cryptoApiProvider;

  CryptoBloc(this._cryptoApiProvider) : super(CryptoLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      final crypto = await _cryptoApiProvider.getCryptoNews(1);
      emit(CryptoLoadedState(
          crypto.count, crypto.next, crypto.previous, crypto.results));
    });
    on<LoadMoreApiEvent>((event, emit) async {
      final crypto = await _cryptoApiProvider.getCryptoNews(2);
      emit(CryptoLoadedState(
          crypto.count, crypto.next, crypto.previous, crypto.results));
    });
  }
}
