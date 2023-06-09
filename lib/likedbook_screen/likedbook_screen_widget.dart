import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'likedbook_screen_model.dart';
export 'likedbook_screen_model.dart';

class LikedbookScreenWidget extends StatefulWidget {
  const LikedbookScreenWidget({Key? key}) : super(key: key);

  @override
  _LikedbookScreenWidgetState createState() => _LikedbookScreenWidgetState();
}

class _LikedbookScreenWidgetState extends State<LikedbookScreenWidget> {
  late LikedbookScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LikedbookScreenModel());
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
    );
  }
}
