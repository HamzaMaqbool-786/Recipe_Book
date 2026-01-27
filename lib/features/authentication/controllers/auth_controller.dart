import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../utils/popups/loader.dart';
import '../screens/login_in/login.dart';

class AuthController extends GetxController {
  static const String authBoxName = 'auth';
  static const String usersBoxName = 'users';

  late Box authBox;
  late Box usersBox;

  var isLoggedIn = false.obs;
  var hasSeenOnboarding = false.obs;
  var currentUser = ''.obs;
  var currentUserEmail = ''.obs;
  var currentUserId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initAuth();
  }

  Future<void> _initAuth() async {
    authBox = await Hive.openBox(authBoxName);
    usersBox = await Hive.openBox(usersBoxName);
    _loadAuthState();
  }

  void _loadAuthState() {
    hasSeenOnboarding.value =
        authBox.get('hasSeenOnboarding', defaultValue: false);
    isLoggedIn.value = authBox.get('isLoggedIn', defaultValue: false);
    currentUser.value = authBox.get('currentUser', defaultValue: '');
    currentUserEmail.value =
        authBox.get('currentUserEmail', defaultValue: '');
    currentUserId.value =
        authBox.get('currentUserId', defaultValue: '');
  }

  // ================= EMAIL CHECK =================
  bool emailExists(String email) {
    return usersBox.values.any(
          (user) => user['email'].toLowerCase() == email.toLowerCase(),
    );
  }


  Future<void> completeOnboarding() async {
    hasSeenOnboarding.value = true;
    await authBox.put('hasSeenOnboarding', true);
  }


  Future<bool> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      TLoaders.warningSnackBar(
        title: 'Missing Fields',
        message: 'All fields are required',
      );
      return false;
    }

    if (name.length < 2) {
      TLoaders.warningSnackBar(
        title: 'Invalid Name',
        message: 'Name must be at least 2 characters',
      );
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      TLoaders.errorSnackBar(
        title: 'Invalid Email',
        message: 'Please enter a valid email address',
      );
      return false;
    }

    if (password.length < 6) {
      TLoaders.warningSnackBar(
        title: 'Weak Password',
        message: 'Password must be at least 6 characters',
      );
      return false;
    }

    if (emailExists(email)) {
      TLoaders.errorSnackBar(
        title: 'Account Exists',
        message: 'An account with this email already exists',
      );
      return false;
    }

    final userId = DateTime.now().millisecondsSinceEpoch.toString();

    final userData = {
      'id': userId,
      'name': name,
      'email': email.toLowerCase(),
      'password': password, // <-- plain password
      'createdAt': DateTime.now().toIso8601String(),
      'profileImage': '',
    };

    await usersBox.put(userId, userData);

    currentUserId.value = userId;
    currentUser.value = name;
    currentUserEmail.value = email;
    isLoggedIn.value = true;

    await authBox.put('currentUserId', userId);
    await authBox.put('currentUser', name);
    await authBox.put('currentUserEmail', email);
    await authBox.put('isLoggedIn', true);

    TLoaders.successSnackBar(
      title: 'Success',
      message: 'Account created successfully!',
    );

    return true;
  }


  Future<bool> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      TLoaders.warningSnackBar(
        title: 'Missing Fields',
        message: 'Please enter both email and password',
      );
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      TLoaders.errorSnackBar(
        title: 'Invalid Email',
        message: 'Please enter a valid email',
      );
      return false;
    }

    Map<dynamic, dynamic>? foundUser;

    for (var user in usersBox.values) {
      if (user['email'].toLowerCase() == email.toLowerCase()) {
        foundUser = user;
        break;
      }
    }

    if (foundUser == null) {
      TLoaders.errorSnackBar(
        title: 'User Not Found',
        message: 'No account found with this email',
      );
      return false;
    }

    if (foundUser['password'] != password) {
      TLoaders.errorSnackBar(
        title: 'Wrong Password',
        message: 'Incorrect password',
      );
      return false;
    }

    currentUserId.value = foundUser['id'];
    currentUser.value = foundUser['name'];
    currentUserEmail.value = foundUser['email'];
    isLoggedIn.value = true;

    await authBox.put('currentUserId', foundUser['id']);
    await authBox.put('currentUser', foundUser['name']);
    await authBox.put('currentUserEmail', foundUser['email']);
    await authBox.put('isLoggedIn', true);

    TLoaders.successSnackBar(
      title: 'Welcome Back',
      message: 'Login successful',
    );

    return true;
  }

  Map<dynamic, dynamic>? getCurrentUserData() {
    if (currentUserId.value.isEmpty) return null;
    return usersBox.get(currentUserId.value);
  }


  Future<bool> updateProfile({
    String? name,
    String? email,
    String? profileImage,
  }) async {
    if (currentUserId.value.isEmpty) return false;

    var userData = usersBox.get(currentUserId.value);
    if (userData == null) return false;

    if (name != null && name.isNotEmpty) {
      userData['name'] = name;
      currentUser.value = name;
      await authBox.put('currentUser', name);
    }

    if (email != null && email.isNotEmpty) {
      if (email.toLowerCase() != currentUserEmail.value.toLowerCase() &&
          emailExists(email)) {
        TLoaders.errorSnackBar(
          title: 'Error',
          message: 'This email is already in use',
        );
        return false;
      }
      userData['email'] = email.toLowerCase();
      currentUserEmail.value = email;
      await authBox.put('currentUserEmail', email);
    }

    if (profileImage != null) {
      userData['profileImage'] = profileImage;
    }

    await usersBox.put(currentUserId.value, userData);

    TLoaders.successSnackBar(
      title: 'Success',
      message: 'Profile updated successfully',
    );

    return true;
  }


  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (currentUserId.value.isEmpty) return false;

    var userData = usersBox.get(currentUserId.value);
    if (userData == null) return false;

    if (userData['password'] != currentPassword) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Current password is incorrect',
      );
      return false;
    }

    if (newPassword.length < 6) {
      TLoaders.warningSnackBar(
        title: 'Weak Password',
        message: 'New password must be at least 6 characters',
      );
      return false;
    }

    userData['password'] = newPassword;
    await usersBox.put(currentUserId.value, userData);

    TLoaders.successSnackBar(
      title: 'Success',
      message: 'Password changed successfully',
    );

    return true;
  }


  Future<void> logout() async {
  isLoggedIn.value = false;
  currentUser.value = '';
  currentUserEmail.value = '';
  currentUserId.value = '';

  await authBox.put('isLoggedIn', false);
  await authBox.delete('currentUser');
  await authBox.delete('currentUserEmail');
  await authBox.delete('currentUserId');

  Get.offAll(() => const LoginScreen());

  TLoaders.customToast(message: 'Logged out successfully');
}


  Future<bool> deleteAccount(String password) async {
    if (currentUserId.value.isEmpty) return false;

    var userData = usersBox.get(currentUserId.value);
    if (userData == null) return false;

    if (userData['password'] != password) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Incorrect password',
      );
      return false;
    }

    await usersBox.delete(currentUserId.value);
    await logout();

    TLoaders.errorSnackBar(
      title: 'Account Deleted',
      message: 'Your account has been permanently deleted',
    );

    return true;
  }


  int get totalUsers => usersBox.length;

  bool shouldShowOnboarding() => !hasSeenOnboarding.value;

  bool shouldShowLogin() => hasSeenOnboarding.value && !isLoggedIn.value;
}
