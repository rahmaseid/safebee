// This class represents the workflow object and it's components.





class EmWorkflowAction {
  EmWorkflowAction({
      required this.name,
      required this.instructions,
      required this.alertContacts,
      required this.call911
  });

  final String name;
  final bool alertContacts;
  final bool call911;
  final List<String> instructions;
}

class EmergencyWorkflow {
  EmergencyWorkflow({
      required this.name,
      required this.actions
  });

  final String name;
  final List<EmWorkflowAction> actions;

}