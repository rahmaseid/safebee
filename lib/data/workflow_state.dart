

import 'package:flutter/foundation.dart';
import 'package:safebee/data/workflow_provider.dart';
import 'package:safebee/data/em_workflow.dart';

class WorkflowState extends ChangeNotifier {
  final List<EmergencyWorkflow> _workflows;

  WorkflowState() : _workflows = EmWorkflowProvider().getWorkflows();

  List<EmergencyWorkflow> get allWorkflows => List<EmergencyWorkflow>.from(_workflows);

  EmergencyWorkflow getWorkflow(String name) => _workflows.singleWhere((v) => v.name == name);

  List<EmergencyWorkflow> searchWorkflows(String? terms) => _workflows
      .where((v) => v.name.toLowerCase().contains(terms!.toLowerCase()))
      .toList();

}