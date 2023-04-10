import 'package:firebase_database/firebase_database.dart';

import '../detail_screen/detail_screen_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_screen_model.dart';
export 'search_screen_model.dart';

class SearchScreenWidget extends StatefulWidget {
  const SearchScreenWidget({Key? key}) : super(key: key);

  @override
  _SearchScreenWidgetState createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  late SearchScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  List<dynamic> bookList = [];
  List<dynamic> bookKeys = [];
  List<dynamic> bookListSearch = [];
  List<dynamic> bookKeysSearch = [];

  String searchQuery = "";

  final fDatabase = FirebaseDatabase.instance.ref().child('public');

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchScreenModel());
    _model.textController ??= TextEditingController();

    fDatabase.onValue.listen((event) {
      setState(() {
        bookList.clear();
        bookKeys.clear();
        List<dynamic>? _bookList = event.snapshot.value as List?;
        if (_bookList != null) {
          _bookList
              .where((book) => book != null)
              .forEach((book) {
            bookKeys.add(bookList.length.toString());
            bookList.add(book);
          });
        }
        print(bookList);
        bookListSearch = List.from(bookList);
        bookKeysSearch = List.from(bookKeys);
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: ListView(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                      child: Container(
                        width: 310,
                        height: 42,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 34,
                              color: Color(0x33000000),
                              offset: Offset(0, 4),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14, 0, 0, 6),
                                  child: TextFormField(
                                    controller: _model.textController,
                                    onChanged: (value) {
                                      setState(() {
                                        searchQuery = value.toLowerCase();
                                        bookListSearch = bookList.where((book) =>
                                            book['title'].toLowerCase().contains(searchQuery)).toList();
                                        bookKeysSearch = bookListSearch.map((book) {
                                          int originalIndex = bookList.indexOf(book);
                                          return bookKeys[originalIndex];
                                        }).toList();
                                      });
                                    },
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Search something book',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.normal,
                                          ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: _model.textControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: Icon(
                                Icons.search_sharp,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/image_31.png',
                      width: 255,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 110,
                      child: searchQuery == ""
                      ? GridView.builder(
                          itemCount: bookList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 200,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10
                          ),
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenWidget(keys: bookKeys[index])));
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
                                        Image.network(bookList[index]["images"], width: 100, height: 150,),
                                        SizedBox(height: 5,),
                                        Text("By ${bookList[index]["creator"]}", style: TextStyle(color: Colors.grey, fontSize: 11),),
                                        SizedBox(height: 5,),
                                        Text("${bookList[index]["title"]}", style: TextStyle(fontSize: 12),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      )
                          : GridView.builder(
                          itemCount: bookListSearch.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 200,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10
                          ),
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenWidget(keys: bookKeys[index])));
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
                                        Image.network(bookListSearch[index]["images"], width: 100, height: 150,),
                                        SizedBox(height: 5,),
                                        Text("By ${bookListSearch[index]["creator"]}", style: TextStyle(color: Colors.grey, fontSize: 11),),
                                        SizedBox(height: 5,),
                                        Text("${bookListSearch[index]["title"]}", style: TextStyle(fontSize: 12),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
