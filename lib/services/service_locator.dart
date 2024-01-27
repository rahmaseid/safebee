import 'package:safebee/services/calls_and_messages_service.dart';
import 'package:get_it/get_it.dart';


//In order to instantiate the CallsAndMessagesService and have it available quickly anywhere in our app, we want to create a service locator using get_it.

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}