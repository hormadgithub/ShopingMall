import 'package:flutter/material.dart';

import '../utility/my_constant.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => buildProductName(constraints),
      ),
    );
  }


  Widget buildProductName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.5, //ความกว้างครึ่งนึงของจอ
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'Product Name :',
          prefixIcon: Icon(Icons.production_quantity_limits_sharp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }


  Widget buildProductPrice(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.5, //ความกว้างครึ่งนึงของจอ
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'Product Price :',
          prefixIcon: Icon(Icons.production_quantity_limits_sharp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }


  Widget buildProductDetail(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.5, //ความกว้างครึ่งนึงของจอ
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'Product Detail :',
          prefixIcon: Icon(Icons.production_quantity_limits_sharp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }



}
