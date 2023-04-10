import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'read_screen_a_i_l_w_y_model.dart';
export 'read_screen_a_i_l_w_y_model.dart';

class ReadScreenAILWYWidget extends StatefulWidget {
  const ReadScreenAILWYWidget({Key? key}) : super(key: key);

  @override
  _ReadScreenAILWYWidgetState createState() => _ReadScreenAILWYWidgetState();
}

class _ReadScreenAILWYWidgetState extends State<ReadScreenAILWYWidget> {
  late ReadScreenAILWYModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReadScreenAILWYModel());
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 400,
                  height: 80,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
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
                            context.pushNamed('detailScreenAILWY');
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 7, 0, 0),
                        child: Text(
                          'A Little in Love With You',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                  child: Text(
                    'Ligula ullamcorper suspendisse lectus nec eu netus. Pellentesque pellentesque ultrices vel pellentesque in egestas donec hac. Tellus senectus tristique dolor sed purus sit neque molestie. Imperdiet sit condimentum orci lectus amet. In nisl volutpat posuere cras. Dolor elit viverra sit cras vitae enim vulputate mi tristique. ',
                    textAlign: TextAlign.justify,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: Text(
                    'Nunc et adipiscing non vitae in. Arcu suspendisse in fusce commodo sapien commodo. Pharetra habitasse cursus consectetur cras molestie consequat euismod. Diam iaculis nisl eu orci non \n\nUt convallis eu nec rutrum nibh eleifend habitant eget. Quam nulla quis auctor placerat tincidunt erat vitae dui enim. Mattis fermentum interdum eget tempor in id justo nislin.\n',
                    textAlign: TextAlign.justify,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Text(
                    'Nunc et adipiscing non vitae in. Arcu suspendisse in fusce commodo sapien commodo. Pharetra habitasse cursus consectetur cras molestie consequat euismod. Diam iaculis nisl eu orci non at bibendum sollicitudin amit suaayapbe halo dek. \n',
                    textAlign: TextAlign.justify,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Text(
                    'Nunc et adipiscing non vitae in. Arcu suspendisse in fusce commodo sapien commodo. Pharetra habitasse cursus consectetur cras molestie consequat euismod. Diam iaculis nisl eu orci non at bibendum sollicitudin amet. \n\nUt convallis eu nec rutrum nibh eleifend habitant eget. Quam nulla quis auctor placerat tincidunt erat vitae dui enim. Mattis fermentum interdum eget tempor in id justo nisl in.\n',
                    textAlign: TextAlign.justify,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
