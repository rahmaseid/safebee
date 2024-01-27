// This class keeps and manages emergency workflow data


import 'package:safebee/data/em_workflow.dart';

class EmWorkflowActionProvider {
  EmWorkflowActionProvider();
  List<EmWorkflowAction> actions = [
    EmWorkflowAction(
      name: 'Move Away',
      instructions: [
        'Move away from the stranger. Do not run.',
        'Stay in open areas that have lots of light and people.'
      ], 
      alertContacts: false,
      call911: false),
    EmWorkflowAction(
      name: 'Stay In Place',
      instructions: [
        'Stay where you are until help arrives.'
      ], 
      alertContacts: true,
      call911: false),
    EmWorkflowAction(
      name: 'Find Help', 
      instructions: [
        'Look at the map to find a safe person or place.',
        'If you cannot find a safe person or place, shout for help!',
        'Your contacts will be alerted, stay calm. Help is coming.'
      ], 
      alertContacts: true,
      call911: false),
    EmWorkflowAction(
      name: 'Call 911', 
      instructions: [
        'Stay calm. Get ready to tell the 911 operator about what is happening.',
        '9-1-1 is being called now.'
      ], 
      alertContacts: true,
      call911: true),
    EmWorkflowAction(
      name: 'Hide', 
      instructions: [
        'Quietly and quickly find a place to hide.',
        'Stay quiet until the danger passes or help arrives.'
      ], 
      alertContacts: true, 
      call911: false)
  ];

  List<EmWorkflowAction> getActions(List<int> indices){
    List<EmWorkflowAction> result = List.empty();
    for (var index in indices) {
      result.add(actions[index]);
    }
    return result;
  }
}

class EmWorkflowProvider {

  //EmWorkflowActionProvider _actionProvider = EmWorkflowActionProvider();
  List<EmergencyWorkflow> workflows = [
      EmergencyWorkflow(
        name: 'Stranger Danger', 
        actions: [
          EmWorkflowAction(
            name: 'Move Away',
            instructions: [
              'Move away from the stranger. Do not run.',
              'Stay in open areas that have lots of light and people.'
            ], 
          alertContacts: false,
          call911: false),
          EmWorkflowAction(
            name: 'Find Help', 
            instructions: [
              'Look at the map to find a safe person or place.',
              'If you cannot find a safe person or place, shout for help!',
              'Your contacts will be alerted, stay calm. Help is coming.'
            ], 
        alertContacts: true,
        call911: false)
        ]
      ),
      EmergencyWorkflow(
        name: 'I\'m Lost',
        actions: [
          EmWorkflowAction(
            name: 'Stay In Place',
            instructions: [
              'Stay where you are until help arrives.'
            ], 
            alertContacts: true,
            call911: false)
        ]
      ),
      EmergencyWorkflow(
        name: 'I\'m Hurt', 
        actions: [
          EmWorkflowAction(
            name: 'Stay In Place',
            instructions: [
              'Stay where you are until help arrives.'
            ], 
            alertContacts: true,
            call911: false)
        ]
      ),
      EmergencyWorkflow(
        name: 'Someone Hurting People', 
        actions: [
          EmWorkflowAction(
            name: 'Hide', 
            instructions: [
              'Quietly and quickly find a place to hide.',
              'Stay quiet until the danger passes or help arrives.'
            ], 
            alertContacts: true, 
            call911: false)
        ]
      ),
      EmergencyWorkflow(
        name: 'Fire', 
        actions: [
          EmWorkflowAction(
            name: 'Move Away',
            instructions: [
              'Move away from the stranger. Do not run.',
              'Stay in open areas that have lots of light and people.'
            ], 
            alertContacts: false,
            call911: false)
        ]
      ) 
  ];

  void addWorkflow(EmergencyWorkflow workflow){
    workflows.add(workflow);
  }
  
  List<EmergencyWorkflow> getWorkflows(){
    return workflows;
  }

}