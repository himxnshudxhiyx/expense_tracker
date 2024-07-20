import 'package:expense_tracker/Widgets/text_widget.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/text_field.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/elevated_button_widget.dart';
import '../../../constants/functions/validation_functions.dart';
import '../controllers/signUp_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.pinkAccent,
        body: _bodyWidget(),
      ),
    );
  }

  _bodyWidget() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple,
              Colors.pinkAccent,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  loginIcon,
                  height: 200,
                  width: 200,
                ),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.all(20),
                  color: Colors.white.withOpacity(0.7),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: controller.loginFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppTextField(
                              labelText: 'First Name',
                              controller: controller.firstNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your First Name';
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: Icon(Icons.person_2_rounded),
                            ),
                            SizedBox(height: 20),
                            AppTextField(
                              labelText: 'Last Name',
                              controller: controller.lastNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your First Name';
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: Icon(Icons.person_2_rounded),
                            ),
                            SizedBox(height: 20),
                            AppTextField(
                              labelText: 'Phone Number',
                              controller: controller.phoneNumberController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Phone Number';
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: Icon(Icons.phone),
                            ),
                            SizedBox(height: 20),
                            AppTextField(
                              labelText: 'Email',
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              prefixIcon: Icon(Icons.email),
                            ),
                            SizedBox(height: 20),
                            Obx(
                              () => AppTextField(
                                labelText: 'Password',
                                controller: controller.passwordController,
                                obscureText: controller.passwordVisible.value,
                                validator: (value) {
                                  return validateStrongPassword(value);
                                },
                                prefixIcon: Icon(Icons.password),
                                suffixWidget: GestureDetector(
                                  onTap: () {
                                    controller.passwordVisible.value =
                                        !controller.passwordVisible.value;
                                  },
                                  child: (controller.passwordVisible.value)
                                      ? Icon(Icons.visibility)
                                      : Icon(
                                          Icons.visibility_off,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButtonWidget(
                              text: 'Sign Up',
                              textColor: Colors.white,
                              onPressed: () {
                                FocusScope.of(Get.context!).unfocus();
                                if (controller.loginFormKey.currentState!
                                    .validate()) {
                                  controller.callSignUpApi();
                                }
                              },
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextView(text: "Already a user?"),
                                GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: TextView(
                                    text: " Login",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
