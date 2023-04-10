import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'changeprofil_screen_model.dart';
export 'changeprofil_screen_model.dart';
import 'dart:io';
import 'package:path/path.dart';

class ChangeprofilScreenWidget extends StatefulWidget {
  const ChangeprofilScreenWidget({Key? key}) : super(key: key);

  @override
  _ChangeprofilScreenWidgetState createState() =>
      _ChangeprofilScreenWidgetState();
}

class _ChangeprofilScreenWidgetState extends State<ChangeprofilScreenWidget> {
  late ChangeprofilScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final fDatabase = FirebaseDatabase.instance;
  final fAuth = FirebaseAuth.instance;
  final fStorage = FirebaseStorage.instance;
  File? image;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future openCamera() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    image = File(pickedImage!.path);
    setState(() {
      image = File(pickedImage!.path);
    });
    uploadFotoProfile();
  }

  Future openGaleri() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
    uploadFotoProfile();
  }

  Future uploadFotoProfile() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String fileName = basename(image!.path);
    await FirebaseStorage.instance.ref()
        .child('profile/$userId/$fileName')
        .putFile(image!);
    var url = await FirebaseStorage.instance.ref().child(
        'profile/$userId/$fileName').getDownloadURL();
    setState(() {
      images = url.toString();
    });

    await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('images').set(images);
  }

  String? username;
  String? images;
  bool loading = false;

  Future<void> getDataUser() async {
    setState(() {
      loading = true;
    });

    var usernameSnapshot = await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('username').once();
    var imagesSnapshot = await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('images').once();

    setState(() {
      username = usernameSnapshot.snapshot.value.toString();
      images = imagesSnapshot.snapshot.value.toString();
    });

    setState(() {
      loading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(loading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30,
                  ),
                  onPressed: () async {
                    context.pushNamed('profilScreen');
                  },
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.2),
                child: Container(
                  width: 350,
                  height: 462,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 34,
                        color: Color(0x33000000),
                        offset: Offset(0, 4),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(147, 0, 0, 0),
                              child: Text(
                                username!,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                              child: InkWell(
                                onTap: (){
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => Container(
                                        height: 150,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Color(0xedededed),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Foto Profil",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      openCamera();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black,
                                                    ),
                                                    style:
                                                    ElevatedButton.styleFrom(
                                                        shape: CircleBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                        fixedSize:
                                                        Size(60, 60),
                                                        primary: Colors
                                                            .transparent,
                                                        elevation: 0)),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      openGaleri();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.photo_album_sharp,
                                                      color: Colors.black,
                                                    ),
                                                    style:
                                                    ElevatedButton.styleFrom(
                                                        shape: CircleBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                        fixedSize:
                                                        Size(60, 60),
                                                        primary: Colors
                                                            .transparent,
                                                        elevation: 0))
                                              ],
                                            )
                                          ],
                                        ),
                                      )));

                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40, 0, 0, 0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Username',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF636363),
                                            ),
                                      ),
                                      Text(
                                        username!,
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 11,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 10, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/images/image_37.png',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Gender',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF636363),
                                              ),
                                        ),
                                        Text(
                                          'Male',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 11,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 10, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.mail_outlined,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF636363),
                                              ),
                                        ),
                                        Text(
                                          fAuth.currentUser!.email.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed('profilScreen');
                          },
                          text: 'Save',
                          options: FFButtonOptions(
                            width: 330,
                            height: 46,
                            color: Color(0xFF288AC1),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.7),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: image != null
                          ? Image.file(
                        image!,
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      ).image as ImageProvider<Object>
                          : Image.network(
                        images!,
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      ).image as ImageProvider<Object>
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
