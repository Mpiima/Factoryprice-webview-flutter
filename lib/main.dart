import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Factory Price",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WebViewController controller;

  late String title,url;
  bool isLoading=true;
  final _key = UniqueKey();


  @override
  Widget build(BuildContext context) {
return MaterialApp(
  home: WillPopScope(
    onWillPop: () async {
      String? url = await controller.currentUrl();
      if(url=="https://store.humuza.online"){
        return true;
      }else{
        controller.goBack();
        return false;
      }
    },
    child: Scaffold(
      body: Stack(
        children: [
        Container(
          child: SafeArea(
            child: WebView(
              key: _key,
              initialUrl: "https://store.humuza.online",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController wc){
                controller = wc;
              },
              onPageFinished: (finished){
                setState(() {
                  isLoading = false;
                });
              },
            ),

          ),
        ),
          isLoading ? Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    ),
  ),
);
  }
}

