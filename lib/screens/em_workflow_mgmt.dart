
import 'package:flutter/cupertino.dart';
import 'package:safebee/data/workflow_state.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safebee/data/em_workflow.dart';
import 'package:safebee/widgets/em_workflow_card.dart';
import 'package:safebee/styles.dart';


class EmergencyWorkflowListScreen extends StatelessWidget { 
  const EmergencyWorkflowListScreen({this.restorationId, super.key});

  final String? restorationId;
  Widget _generateWorkflowRow(EmergencyWorkflow workflow) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: FutureBuilder<Set<EmergencyWorkflow>>(
          future: null,
          builder: (context, snapshot) {
            final data = snapshot.data ?? <EmergencyWorkflow>{};
            return EmergencyWorkflowCard(workflow);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      restorationScopeId: restorationId,
      builder: (context) {
        final themeData = CupertinoTheme.of(context);
        final appState = Provider.of<WorkflowState>(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarBrightness: MediaQuery.platformBrightnessOf(context)),
          child: SafeArea(
            bottom: false,
            child: ListView.builder(
              restorationId: 'list',
              itemCount: appState.allWorkflows.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('dateString'.toUpperCase(),
                            style: Styles.minorText(themeData)),
                        Text('In season today',
                            style: Styles.headlineText(themeData)),
                      ],
                    ),
                  );
                } else if (index <= appState.allWorkflows.length) {
                  return _generateWorkflowRow(
                    appState.allWorkflows[index - 1],
                  );
                } else if (index <= appState.allWorkflows.length + 1) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    child: Text('Not in season',
                        style: Styles.headlineText(themeData)),
                  );
                } else {
                  var relativeIndex =
                      index - (appState.allWorkflows.length + 2);
                  return _generateWorkflowRow(
                      appState.allWorkflows[relativeIndex]);
                }
              },
            ),
          ),
        );
      },
    );
  }
}