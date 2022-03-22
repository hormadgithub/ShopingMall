import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingmall/states/add_product.dart';
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
  '/sellerService': (BuildContext context) => SellerService(),
  '/riderService': (BuildContext context) => RiderService(),
  '/addProduct': (BuildContext context) => AddProduct(),


};

String? initlalRoute;
// ทำงานใน Thead ให้เสร็จก่อน
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance(); //อ่านค่าที่เก็บไว้มาเพื่อตรวจสอบ
  String? type = preferences.getString('type');
  print('### type ==>> $type');
  if (type?.isEmpty ?? true) {
    initlalRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'buyer':
        initlalRoute = MyConstant.routeBuyerService;
        runApp(MyApp());
        break;
      case 'seller':
        initlalRoute = MyConstant.routeSellerService;
        runApp(MyApp());
        break;
      case 'rider':
        initlalRoute = MyConstant.routeRiderService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

/*
void main() {
  initlalRoute = MyConstant.routeAuthen;
  runApp(MyApp());
}
*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor = MaterialColor(0xffbc5100, MyConstant.mapMaterialColor);
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
      theme: ThemeData(primarySwatch:materialColor),
    );
  }
}
