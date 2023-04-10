import 'package:eread/detail_screen/detail_screen_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_screen_model.dart';
export 'home_screen_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late HomeScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final fBookTrending = FirebaseDatabase.instance.ref().child("public").orderByChild("rating").limitToLast(4);

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeScreenModel());
    getDataUser();
  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool loading = false;

  String? username;




  Future<void> getDataUser() async {
    setState(() {
      loading = true;
    });

    var usernameSnapshot = await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('username').once();
    setState(() {
      username = usernameSnapshot.snapshot.value.toString();
    });

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SlidingUpPanel(
          panel: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [Padding(
                padding:
                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/Vector_5.png',
                    width: 56,
                    height: 2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
                Align(
                  alignment: AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        20, 20, 0, 0),
                    child: Text(
                      'Continue Reading',
                      style: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: FirebaseAnimatedList(
                        query: FirebaseDatabase.instance.ref().child("user").child(userId).child("read"),
                        itemBuilder: (context, snapshot, animation, index){

                          Map read = snapshot.value as Map;
                          read['key'] = snapshot.key;

                          return Column(
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                                child: Container(
                                  width: 335,
                                  height: 97,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 30,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 4),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: Image.network(
                                          read['images'],
                                          width: 57,
                                          height: 81,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                10, 10, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  read['title'],
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Align(
                                                  alignment:
                                                  AlignmentDirectional(-1, -1),
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(0, 2, 0, 0),
                                                    child: Text(
                                                      'by ${read['creator']}',
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme.of(
                                                          context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                                  child: RatingBar(
                                                    initialRating: double.parse(read['rating']),
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 20,
                                                    tapOnlyMode: true,
                                                    ratingWidget: RatingWidget(
                                                      full: Icon(Icons.star, color: Colors.yellow),
                                                      half: Icon(Icons.star_half, color: Colors.yellow),
                                                      empty: Icon(Icons.star_border, color: Colors.yellow),
                                                    ),
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                    onRatingUpdate: (rating) {

                                                    },
                                                    ignoreGestures: true,
                                                  )
                                                ),
                                              ],
                                            ),
                                          ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            50, 0, 10, 0),
                                        child: Container(
                                          width: 58,
                                          height: 58,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 10,
                                                color: Color(0x33000000),
                                                offset: Offset(0, 4),
                                              )
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            border: Border.all(
                                              color: Color(0xFF288AC1),
                                            ),
                                          ),
                                          child: FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 60,
                                            icon: Icon(
                                              Icons.play_arrow,
                                              color: Color(0xFF288AC1),
                                              size: 36,
                                            ),
                                            onPressed: () async {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenWidget(keys: read['key'])));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                    )
                )
              ],
            ),
          ),
          collapsed: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Color(0xCFFFFFFF),
              boxShadow: [
                BoxShadow(
                  blurRadius: 34,
                  color: Color(0x33000000),
                  offset: Offset(0, 4),
                )
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/Vector_5.png',
                      width: 56,
                      height: 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        20, 20, 0, 0),
                    child: Text(
                      'Continue Reading',
                      style: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 24,
                          buttonSize: 40,
                          icon: Icon(
                            Icons.search,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                          onPressed: () async {
                            context.pushNamed(
                              'searchScreen',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.bottomToTop,
                                ),
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 100, 0, 0),
                        child: Text(
                          'Trending Book',
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                        child: Text(
                          'Welcome, ' + username!,
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 180, 0, 240),
                          child: FirebaseAnimatedList(
                            scrollDirection: Axis.horizontal,
                            query: fBookTrending,
                            itemBuilder: (context, snapshot, animation, index) {

                              Map books = snapshot.value as Map;
                              books['key'] = snapshot.key;

                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenWidget(keys: books['key'])));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Image.network(books['images'], width: 100, height: 150,),
                                          SizedBox(height: 5,),
                                          Text("By ${books['creator']}", style: TextStyle(color: Colors.grey, fontSize: 11),),
                                          SizedBox(height: 5,),
                                          Text("${books['title']}", style: TextStyle(fontSize: 12),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      );
    }
  }
}
