

import 'package:wts/constant/constantColor.dart';
import 'package:wts/dashboard/HomeDirectory/home.dart';
import 'package:wts/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UpiWebView extends StatelessWidget {
  final String url;

  const UpiWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: lightBlue,
        title: const Text('UPI Payment'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: SizedBox(
          width: 80,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: lightBlue,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 20,
                ),
                // SizedBox(
                //   width: 10,
                // ),
                Text(
                  "Back",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('upi://')) {
            launch(request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}