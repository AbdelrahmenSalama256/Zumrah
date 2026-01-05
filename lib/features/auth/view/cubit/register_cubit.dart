import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import 'register_state.dart';

//! RegisterCubit
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  XFile? profileImage;

  void togglePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    emit(RegisterPasswordVisibilityChanged(isObscure: isPasswordObscure));
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = pickedFile;
      emit(RegisterDataUpdated(profileImage: profileImage));
    }
  }

  Future<void> attemptAccountCreation() async {
    emit(RegisterLoading());
    await Future.delayed(const Duration(milliseconds: 600));
    emit(
      RegisterSuccess(
        message: 'auth_create_account_success',
        emailForVerification: emailController.text.trim(),
      ),
    );
  }

  void setProfileImage(XFile image) {
    final extension = path.extension(image.path).toLowerCase();
    if (['.jpeg', '.jpg', '.png', '.gif', '.svg'].contains(extension)) {
      profileImage = image;
      emit(RegisterDataUpdated(profileImage: profileImage));
    } else {
      emit(RegisterError(
          message: 'Image must be of type jpeg, jpg, png, gif, or svg'));
    }
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    nameController.dispose();
    mobileController.dispose();
    return super.close();
  }
}
