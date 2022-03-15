
import 'package:flutter/material.dart';
import 'package:shoppingmall/states/authen.dart';
import 'package:shoppingmall/states/buyer_service.dart';
import 'package:shoppingmall/states/create_account.dart';
import 'package:shoppingmall/states/rider_service.dart';
import 'package:shoppingmall/states/seller_service.dart';
import 'package:shoppingmall/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccont(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/sellerService': (BuildContext context) => SalerService(),
  '/riderService': (BuildContext context) => RiderService(),
};

String? initlalRoute;

void main() {
  initlalRoute = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}
