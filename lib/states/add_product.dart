import 'package:flutter/material.dart';

import '../utility/my_constant.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildProductName(constraints),
                    buildProductPrice(constraints),
                    buildProductDetail(constraints),
                    buildImage(constraints),
                    addProductButton(constraints)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container addProductButton(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * .75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          if (formKey.currentState!.validate()) {}
        },
        child: Text('Add Product'),
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          height: constraints.maxWidth * 0.70,
          width: constraints.maxWidth * 0.70,
          child: Image.asset(MyConstant.image5),
        ),
        Container(
          width: constraints.maxWidth * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 48,
                width: 48,
                child: Image.asset(MyConstant.image5),
              ),
              Container(
                height: 48,
                width: 48,
                child: Image.asset(MyConstant.image5),
              ),
              Container(
                height: 48,
                width: 48,
                child: Image.asset(MyConstant.image5),
              ),
              Container(
                height: 48,
                width: 48,
                child: Image.asset(MyConstant.image5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProductName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.5, //ความกว้างครึ่งนึงของจอ
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Product Name in Blank';
          } else {
            return null;
          }
        },
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
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Product Price in Blank';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'Product Price :',
          prefixIcon: Icon(Icons.money_sharp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Product Detail in Blank';
          } else {
            return null;
          }
        },
        maxLines: 4,
        decoration: InputDecoration(
          hintStyle: MyConstant().h3Style(),
          hintText: 'Product Detail :',
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: Icon(Icons.details_outlined),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30),
          ),          
        ),
      ),
    );
  }
}
