import 'package:flutter/material.dart';
import 'package:shoppingmall/bodys/show_manage_seller.dart';
import 'package:shoppingmall/bodys/show_order_seller.dart';
import 'package:shoppingmall/bodys/show_product_seller.dart';
import 'package:shoppingmall/utility/my_constant.dart';
import 'package:shoppingmall/widgets/show_title.dart';

import '../widgets/show_signout.dart';

class SellerService extends StatefulWidget {
  const SellerService({Key? key}) : super(key: key);

  @override
  State<SellerService> createState() => _SellerServiceState();
}

class _SellerServiceState extends State<SellerService> {
  List<Widget> widgets = [
    ShowOrderSeller(),
    ShopManageSeller(),
    ShowProductSeller(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSingOut(),
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                menuShowOrder(),
                menuShopManage(),
                menuShowProduct()
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1_outlined),
      title: ShowTitle(
        title: 'Show Order',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: "แสดงรายละเอียดของ order ที่สั่ง",
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShopManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2_outlined),
      title: ShowTitle(
        title: 'Shop Manage',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: "แสดงรายละเอียดของหน้าร้าน ที่ให้ลูกค้าเห็น",
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3_outlined),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: "แสดงรายละเอียดของสินค้าที่เราขาย",
        textStyle: MyConstant().h3Style(),
      ),
    );
  }
}
