import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shoppingmall/utility/my_constant.dart';
import 'package:shoppingmall/widgets/show_image.dart';
import 'package:shoppingmall/widgets/show_title.dart';

class CreateAccont extends StatefulWidget {
  const CreateAccont({Key? key}) : super(key: key);

  @override
  State<CreateAccont> createState() => _CreateAccontState();
}

class _CreateAccontState extends State<CreateAccont> {
  String? typeUser; //? ยอมให้เป็น Null ได้
  File? file;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      //EdgeInsets สำหรับกำหนดระยะห่างรอบตัว
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            buildTitle('ข้อมูลทั่วไป'),
            buildName(size),
            buildTitle('ชนิดของ User :'),
            buildRadioBuyer(size),
            buildRadioSeller(size),
            buildRadioRider(size),
            buildTitle('ข้อมูลพื้นฐาน'),
            buildAddress(size),
            buildPhone(size),
            buildUser(size),
            buildPassword(size),
            buildTitle('รูปภาพ'),
            buildSubTitle(),
            buildAvatar(size),
          ],
        ),
      ),
    );
  }

  Row buildAvatar(double size) {
    return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //spaceBetween แบ่งช่องว่างของ children ให้ Auto
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_a_photo,
                  size: 36,
                  color: MyConstant.dark,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size * .5,
                //? ถ้าเป็นจริงทอันแรก ถ้าไม่จริงทำหลัง :  
                child: file == null ? ShowImage(path: MyConstant.avatar) : Image.file(file!),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_photo_alternate,
                  size: 36,
                  color: MyConstant.dark,
                ),
              ),
            ],
          );
  }

  ShowTitle buildSubTitle() {
    return ShowTitle(
      title:
          'เป็นรูปภาพที่แสดงความเป็นตัวตนของ User(แต่ถ้าไม่สะดวกแชร์ เราจะแสดงค่า Default แทน)',
      textStyle: MyConstant().h3Style(),
    );
  }

  Row buildRadioBuyer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: 'ผู้ซื้อ(Buyer)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioSeller(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'seller',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: 'ผู้ขาย(Seller)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioRider(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: 'ผู้ส่ง(Rider)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    //ต้องการให้ห่างบนล่าง
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}

Row buildName(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10),
        width: size * 0.6,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: MyConstant().h3Style(),
            labelText: 'Name :',
            prefixIcon: Icon(Icons.fingerprint),
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
      ),
    ],
  );
}

Row buildPhone(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10),
        width: size * 0.6,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: MyConstant().h3Style(),
            labelText: 'Phone :',
            prefixIcon: Icon(Icons.phone),
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
      ),
    ],
  );
}

Row buildUser(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10),
        width: size * 0.6,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: MyConstant().h3Style(),
            labelText: 'User :',
            prefixIcon: Icon(Icons.perm_identity),
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
      ),
    ],
  );
}

Row buildPassword(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10),
        width: size * 0.6,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: MyConstant().h3Style(),
            labelText: 'Password :',
            prefixIcon: Icon(Icons.lock_open_outlined),
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
      ),
    ],
  );
}

Row buildAddress(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10),
        width: size * 0.6,
        child: TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Address :',
            hintStyle: MyConstant().h3Style(),
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Icon(
                Icons.home,
                color: MyConstant.dark,
              ),
            ),
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
      ),
    ],
  );
}
