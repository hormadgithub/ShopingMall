import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppingmall/utility/my_constant.dart';
import 'package:shoppingmall/utility/my_dialog.dart';
import 'package:shoppingmall/widgets/shor_progress.dart';
import 'package:shoppingmall/widgets/show_image.dart';
import 'package:shoppingmall/widgets/show_title.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class CreateAccont extends StatefulWidget {
  const CreateAccont({Key? key}) : super(key: key);

  @override
  State<CreateAccont> createState() => _CreateAccontState();
}

class _CreateAccontState extends State<CreateAccont> {
  String? typeUser; //? ยอมให้เป็น Null ได้
  File? file;
  double? lat, lng;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    CheckPermission();
  }

  //รอผลลัพธ์ในอนาคต
  Future<Null> CheckPermission() async {
    bool locationService;
    LocationPermission locationPermission;
    //ต้องทำสิ่งที่ต้องได้ผลลัพธ์
    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      //print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          //Find LatLng
          findLntLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          //find LatLng
          findLntLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(context, 'Location Servide Close',
          'กรุณาเปิด Location Service ด้วยครับ');
    }
  }

  Future<Null> findLntLng() async {
    //print('findLatLng Work');
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat = $lat, lng = $lng');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildCreateNewAccount(),
        ],
        title: Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      //EdgeInsets สำหรับกำหนดระยะห่างรอบตัว
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
         // child: ListView(
            child: SingleChildScrollView(
              child: Column(
                      //  padding: EdgeInsets.all(10),
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
                buildTitle('แสดงพิกัดที่คุณอยู่'),
                buildMap()
              ],
                      ),
            ),
        ),
      ),
    );
  }

  IconButton buildCreateNewAccount() {
    return IconButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
               if (typeUser==null){
                 //print('Non Choose Type User');
                 MyDialog().normalDialog(context, 'ยังไม่ได้เลือกประเภทของ User', 'กรุณาเลือกประเภท User ก่อนนะครับ');
               }else{
                 print('Process Insert to Database');
               }
            }
          },
          icon: Icon(Icons.cloud_upload),
        );
  }

//Set เป็นการเก็บ Object ของ Marker
  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow:
              InfoWindow(title: 'คุณอยู่ที่นี่', snippet: 'lat=$lat,Lng=$lng'),
        ),
      ].toSet();

  Widget buildMap() => Container(
        width: double.infinity,
        height: 300,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16, //เห็นโลกคือ Zoom 1 ใกล้มากขึ้น ก็ให้เพิ่ม
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      //ไม่รู้ว่า ตัวแปร Type เป็นอะไร
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //spaceBetween แบ่งช่องว่างของ children ให้ Auto
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
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
          child: file == null
              ? ShowImage(path: MyConstant.avatar)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาป้อน Name ด้วย';
            } else {}
          },
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
        child: TextFormField(keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาป้อน Phone ด้วย';
            } else {}
          },
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาป้อน User Login ด้วย';
            } else {}
          },
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาป้อน Password ด้วย';
            } else {}
          },
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาป้อน Address ด้วย';
            } else {}
          },
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
