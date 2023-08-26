import 'package:app_marketing_version_2/helpers/validation.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/pick_image.dart';
import 'package:app_marketing_version_2/widgets/button_custom.dart';
import 'package:app_marketing_version_2/widgets/loading_spinkit.dart';
import 'package:app_marketing_version_2/widgets/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double _aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          AspectRatio(
            aspectRatio: _aspectRatio * 2.5,
            child: Container(
                width: double.infinity,
                color: Colors.red[800],
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        context.watch<PickImage>().pathImage != null
                            ? CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.redAccent,
                                backgroundImage: FileImage(
                                    context.watch<PickImage>().pathImage!),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.redAccent,
                                backgroundImage:
                                    AssetImage('assets/images/icon_person.png'),
                              ),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        ListTile(
                          onTap: () => editText(context, _height),
                          title: Text(
                            '${context.read<Authenicator>().firebaseAuth.currentUser!.displayName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Positioned(
                        bottom: _height * 0.15,
                        right: _width * 0.3,
                        child: MaterialButton(
                          onPressed: () => bottomSheet(_height, _width),
                          height: _height * 0.06,
                          minWidth: _width * 0.1,
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide.none),
                          child: Icon(
                            Icons.add_a_photo,
                            size: 20,
                            color: Colors.white,
                          ),
                        )),
                    // Positioned(
                    //   bottom: _height * 0.06,
                    //   right: _width * 0.1,
                    //   child: IconButton(
                    //     onPressed: () => editText(context, _height),
                    //     icon: Icon(
                    //       Icons.edit,
                    //       size: 25,
                    //     ),
                    //   ),
                    // ),
                  ],
                )),
          ),
          Text(
            context
                .read<Authenicator>()
                .firebaseAuth
                .currentUser!
                .email
                .toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          ButtonCustom(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.green,
            height: _height * 0.05,
            radius: 30,
            sideColor: Colors.green,
            textButton: 'Back',
            textColor: Colors.white,
          ),
        ],
      )),
    );
  }

  editText(BuildContext context, double height) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldCustom(
              chooseStyle: false,
              textAlign: TextAlign.center,
              onChanged: Validation.saveName,
              hintText: context
                  .read<Authenicator>()
                  .firebaseAuth
                  .currentUser!
                  .displayName
                  .toString(),
            ),
            ButtonCustom(
              onPressed: () async {
                LoadingSpinkit.loadingSpinkit(context);
                await context
                    .read<Authenicator>()
                    .firebaseAuth
                    .currentUser!
                    .updateProfile(displayName: Validation.name!.trim());
                setState(() {
                  context
                      .read<Authenicator>()
                      .firebaseAuth
                      .currentUser!
                      .displayName;
                });
                Navigator.of(context).pop();
                return Navigator.of(context).pop();
              },
              color: Colors.green,
              height: height * 0.05,
              radius: 30,
              sideColor: Colors.green,
              textButton: 'Ok',
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  bottomSheet(double height, double width) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: Colors.black,
              height: height * 0.03,
              endIndent: width * 0.4,
              indent: width * 0.4,
              thickness: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.01,
                right: width * 0.01,
                bottom: height * 0.02,
              ),
              child: Column(
                children: [
                  Card(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    child: ListTile(
                      onTap: () async {
                        await context.read<PickImage>().pickImageFromGallery();
                        return Navigator.of(context).pop();
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Select image from gallery',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Card(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    child: ListTile(
                      onTap: () async {
                        await context.read<PickImage>().pickImageFromCamera();
                        return Navigator.of(context).pop();
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Select image from camera',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
