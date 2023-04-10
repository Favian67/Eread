import 'package:eread/read_screen_u_l_m/read_screen_u_l_m_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'detail_screen_model.dart';
export 'detail_screen_model.dart';

class DetailScreenWidget extends StatefulWidget {
  final keys;
  const DetailScreenWidget({Key? key, required this.keys}) : super(key: key);

  @override
  _DetailScreenWidgetState createState() => _DetailScreenWidgetState(keys);
}

class _DetailScreenWidgetState extends State<DetailScreenWidget> {
  late DetailScreenULMModel _model;
  final keys;
  _DetailScreenWidgetState(this.keys);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailScreenULMModel());
    getData();
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  bool loading = false;
  String? images;
  String? title;
  String? creator;
  String? rating;
  String? number_page;
  String? language;
  String? description;
  String? content;

  Future<void> getData() async {
    setState(() {
      loading = true;
    });

    var imagesSnapshot = await FirebaseDatabase.instance.ref().child('public').child(keys).child("images").once();
    var titleSnapshot = await FirebaseDatabase.instance.ref().child('public').child(keys).child("title").once();
    var creatorSnapshot = await FirebaseDatabase.instance.ref().child('public').child(keys).child("creator").once();
    var ratingSnapshot = await FirebaseDatabase.instance.ref().child('public').child(keys).child("rating").once();
    var number_pageSnapshot = await FirebaseDatabase.instance.ref().child('public').child(keys).child("number_page").once();
    var languageSnapshot = await FirebaseDatabase.instance.ref().child('public').child(keys).child("language").once();
    var descriptionSnapshot = await FirebaseDatabase.instance.ref().child('public').child(keys).child("description").once();
    var contentSnapshot = await FirebaseDatabase.instance.ref().child('public').child(keys).child("content").once();

    setState(() {
      images = imagesSnapshot.snapshot.value.toString();
      title = titleSnapshot.snapshot.value.toString();
      creator = creatorSnapshot.snapshot.value.toString();
      rating = ratingSnapshot.snapshot.value.toString();
      number_page = number_pageSnapshot.snapshot.value.toString();
      language = languageSnapshot.snapshot.value.toString();
      description = descriptionSnapshot.snapshot.value.toString();
      content = contentSnapshot.snapshot.value.toString();
    });

    setState(() {
      loading = false;
    });
  }

  Future<void> saveHistory() async {
    await FirebaseDatabase.instance.ref().child('user').child(userId).child("read").child(keys).set({
      "images" : images,
      "title" : title,
      "creator" : creator,
      "rating" : rating,
      "number_page" : number_page,
      "language" : language,
      "description" : description,
      "content" : content,
    });
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
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
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
                          context.pushNamed('homeScreen');
                        },
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(80, 19, 0, 0),
                        child: Text(
                          'Detail Book',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    images!,
                    width: 200,
                    height: 270,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 24, 260, 0),
                                    child: Text(
                                      'Free',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF288AC1),
                                          ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 120, 0),
                                    child: Text(
                                      title!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 2, 180, 0),
                                    child: Text(
                                      'By ${creator}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(7)
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: 15),
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 20, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.blueAccent.shade100
                                                )
                                            )
                                        ),
                                        child: Column(
                                          children: [
                                            Text("Rating", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600),),
                                            SizedBox(height: 10,),
                                            Text("$rating", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                          ),
                                          child: Column(
                                            children: [
                                              Text("Number of Page", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600),),
                                              SizedBox(height: 10,),
                                              Text("$number_page Pages", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.blueAccent.shade100
                                                )
                                            )
                                        ),
                                        child:  Column(
                                          children: [
                                            Text("Language", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600),),
                                            SizedBox(height: 10,),
                                            Text("$language", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 10, 20, 0),
                                  child: Text(
                                    '$description',
                                    textAlign: TextAlign.justify,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        await saveHistory();
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReadScreenWidget(content: content, title: title)));
                                      },
                                      child: Container(
                                        width: 334,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF46CABF),
                                              Color(0xFF288AC1)
                                            ],
                                            stops: [0, 1],
                                            begin: AlignmentDirectional(1, 0),
                                            end: AlignmentDirectional(-1, 0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'Read Now',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBtnText,
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
