import 'package:fashion_app/features/auth/domain/entity/register_entity.dart';
import 'package:fashion_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fashion_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:fashion_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:fashion_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:fashion_app/shared/app_button.dart';
import 'package:fashion_app/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool secure = true;

  /// Password validation states
  bool hasUpperCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registered Successfully")),
          );

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OtpScreen(
                email: emailController.text.trim(),
              ),));
        }

        if (state is RegisterErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo
                    Center(
                      child: SvgPicture.asset(
                        "assets/logo-bg.svg",
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 60),

                    /// Title
                    const Text(
                      "Welcome to Fashion Hub",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Subtitle
                    Text(
                      "Create your account and explore the latest trends in style.",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),

                    const SizedBox(height: 50),

                    /// First & Last Name
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: "First Name",
                            controller: firstNameController,
                            obscureText: false,
                            suffixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            label: "Last Name",
                            controller: lastNameController,
                            obscureText: false,
                            suffixIcon: const Icon(Icons.person),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// Email
                    CustomTextField(
                      label: "Email",
                      controller: emailController,
                      obscureText: false,
                      suffixIcon: const Icon(Icons.email),
                    ),

                    const SizedBox(height: 15),

                    /// Password
                    CustomTextField(
                      label: "Password",
                      controller: passwordController,
                      obscureText: secure,
                      onChanged: (value) {
                        setState(() {
                          hasUpperCase = value.contains(RegExp(r'[A-Z]'));
                          hasNumber = value.contains(RegExp(r'[0-9]'));
                          hasSpecialChar = value.contains(
                            RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
                          );
                          hasMinLength = value.length >= 8;
                        });
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            secure = !secure;
                          });
                        },
                        icon: Icon(
                          secure ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    /// Password Rules
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildPasswordRule(
                          "At least 8 characters",
                          hasMinLength,
                        ),
                        buildPasswordRule(
                          "At least one uppercase letter",
                          hasUpperCase,
                        ),
                        buildPasswordRule("At least one number", hasNumber),
                        buildPasswordRule(
                          "At least one special character",
                          hasSpecialChar,
                        ),
                      ],
                    ),

                    const SizedBox(height: 190),

                    /// Register Button
                    AppButton(
                      onPressed: () {
                        if (firstNameController.text.isEmpty ||
                            lastNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill all fields"),
                            ),
                          );
                          return;
                        }

                        if (!hasMinLength ||
                            !hasUpperCase ||
                            !hasNumber ||
                            !hasSpecialChar) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please enter a valid password",
                              ),
                            ),
                          );
                          return;
                        }

                        context.read<AuthCubit>().register(
                          RegisterEntity(
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      },
                      text: state is RegisterLoadingState? "Loading" : "Sign Up",
                    ),

                    const SizedBox(height: 12),

                    /// Login Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => SignInScreen(),));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Password rule widget
  Widget buildPasswordRule(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isValid ? Colors.green : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isValid ? Colors.green : Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
