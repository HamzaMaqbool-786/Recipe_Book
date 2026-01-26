import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../features/authentication/controllers/auth_controller.dart';
import '../features/recipie/controllers/recipe_controller.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(RecipeController());

  }

}