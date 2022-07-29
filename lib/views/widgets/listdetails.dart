import 'package:cryptonew/views/news_details.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class ListDetails extends StatelessWidget {
  const ListDetails({Key? key, required this.state}) : super(key: key);
  final state;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: state.results!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // go to newsdetails page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetails(
                            // giving the value of index and state to NewsDetails page
                            index: index,
                            state: state,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                      tileColor: Colors.black,
                      leading: Text(
                        timeago.format(
                            state.results![index].publishedAt!
                                .subtract(Duration(minutes: 1)),
                            locale: 'en_short'),
                        style: TextStyle(color: Colors.white60),
                      ),
                      title: Text.rich(
                        TextSpan(children: [
                          TextSpan(text: state.results![index].title!),
                          TextSpan(
                              text: state.results![index].source?.path == null
                                  ? '  🔗${state.results![index].source?.domain}'
                                  : '🔗${state.results![index].source?.path}',
                              style: TextStyle(color: Colors.white60),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // go to this url
                                  launchUrl(Uri.parse(
                                      'https://${state.results![index].source?.domain}'));
                                }),
                        ]),
                      ),
                      trailing: Text(
                        state.results![index].currencies == null
                            ? ''
                            : state.results![index].currencies![0].code
                                .toString(),
                        style: TextStyle(color: Colors.lightBlueAccent),
                      )),
                  Divider(
                    color: Colors.white,
                    thickness: 0.8,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
