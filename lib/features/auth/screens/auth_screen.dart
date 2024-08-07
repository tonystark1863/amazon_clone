import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth{
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {

  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  Auth _auth = Auth.signup;

  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signupUser(){
    authService.signupUser(
      context: context, 
      email: _emailController.text, 
      name: _nameController.text, 
      password: _passwordController.text);
  }

  void signinUser(){
    authService.signinUser(
      context: context, 
      email: _emailController.text, 
      password: _passwordController.text,
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Container(
        
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              tileColor: _auth == Auth.signup ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor ,
              title: const Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value:Auth.signup , 
                groupValue: _auth, 
                onChanged:(Auth? val){
                  setState(() {
                    _auth = val!;
                  });
                }
                ),
            ),
            if(_auth == Auth.signup)
              Form(
                key: _signupFormKey,
                child: Container(
                  decoration : const BoxDecoration(
                    color: GlobalVariables.backgroundColor,
                    shape: BoxShape.rectangle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0 ,right: 10,bottom: 5),
                    child: Column(
                      children: [
                        CustomTextfield(controller: _emailController ,hintText: "email",),
                        CustomTextfield(controller: _nameController ,hintText: "Name",) ,
                        CustomTextfield(controller: _passwordController ,hintText: "Password",),
                         CustomButton(
                          buttonText: "Sign Up" ,
                          onTap : (){
                            if(_signupFormKey.currentState!.validate()){
                              signupUser();
                            }
                          }
                        )
                      ],
                    ),
                  ),
                ),
              ),
        
            ListTile(
              tileColor: _auth == Auth.signin ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor ,
              title: const Text(
                "Sign in",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value:Auth.signin , 
                groupValue: _auth, 
                onChanged:(Auth? val){
                  setState(() {
                    _auth = val!;
                  });
                }
                ),
            ),
            if(_auth == Auth.signin)
              Form(
                key: _signinFormKey,
                child: Container(
                  decoration : const BoxDecoration(
                    color: GlobalVariables.backgroundColor,
                    shape: BoxShape.rectangle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                    child: Column(
                      children: [
                        CustomTextfield(controller: _emailController ,hintText: "email",),
                        CustomTextfield(controller: _passwordController ,hintText: "Password",),
                         CustomButton(
                          buttonText: "Sign In" ,
                          onTap: (){
                            if(_signinFormKey.currentState!.validate()){
                              signinUser();
                            }
                          },)
                            
                            
                      ],
                    ),
                  ),
                ),
        
              ),
          ],
        ),
      ),
    );
  }
}