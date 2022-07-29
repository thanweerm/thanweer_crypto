import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsDetails extends StatelessWidget {
  const NewsDetails({Key? key, required this.state, required this.index})
      : super(key: key);
  final state;
  final index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${state.results![index].title!}    ',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextSpan(
                    text: timeago.format(
                        state.results![index].publishedAt!
                            .subtract(Duration(minutes: 1)),
                        locale: 'en'),
                  ),
                  TextSpan(
                      text: '  ${state.results![index].source?.domain}',
                      style: TextStyle(color: Colors.orange),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(
                              'https://${state.results![index].source?.domain}'));
                        }),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
