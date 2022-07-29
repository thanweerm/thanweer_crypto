import 'package:cryptonew/crypto/resources/crypto_api_services.dart';
import 'package:cryptonew/crypto/bloc/crypto_bloc.dart';

import 'package:cryptonew/views/widgets/listdetails.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoNewsWidget extends StatelessWidget {
  const CryptoNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        // to call Api with bloc
        create: (context) => CryptoBloc(
              RepositoryProvider.of<CryptoApiServices>(context),
            )..add(LoadApiEvent()),
        child: BlocBuilder<CryptoBloc, CryptoState>(
          // to get datas from api with bloc

          builder: (context, state) {
            if (state is CryptoLoadingState) {
              // if state is loading then show circular progress indicator
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CryptoLoadedState) {
              return RefreshIndicator(
                color: Colors.orange,
                onRefresh: () async {
                  // call api to refreash with bloc
                  context.read<CryptoBloc>().add(LoadApiEvent());
                },
                child: ListDetails(
                  state: state,
                ),
              );
            }
            return Container();
          },
        ));
  }
}
