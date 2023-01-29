import 'dart:ui';

import 'package:admin/controllers/Application.dart';
import 'package:admin/controllers/UserManager.dart';
import 'package:admin/router/AppRouter.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  final void Function(bool isLoggedIn)? onLoginResult;
  final bool? showBackButton;
  LoginScreen(
      {Key? key, required this.onLoginResult, this.showBackButton = false})
      : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        key: scaffoldKey,
        // backgroundColor: Style.primaryColor[200],
        body: Center(child: getForm(context)));
  }

  Widget getForm(BuildContext context) {
    return Center(
      child: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showBackButton ?? false)
                  const InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
                else
                  const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'SP-Apps Admin',
                  ),
                ),
                // const SizedBox(
                //   height: 100,
                // ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white),
                          color: Colors.grey.shade200.withOpacity(0.3)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: "UserName",
                              decoration: InputDecoration(
                                  labelText: 'User Name',
                                  prefixIcon: const SizedBox(
                                    width: 16,
                                  ),
                                  prefixIconConstraints:
                                      const BoxConstraints(maxWidth: 16)),
                              // initialValue: Session.mUser?.emailAddress,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              // style: Style.viatoTextTheme.subtitle1
                              //     .copyWith(color: Colors.white),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                // FormBuilderValidators.email(context),
                              ]),
                            ),
                            FormBuilderTextField(
                              name: "Password",
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const SizedBox(
                                  width: 16,
                                ),
                                prefixIconConstraints:
                                    const BoxConstraints(maxWidth: 16),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                              // style: Style.viatoTextTheme.subtitle1
                              //     .copyWith(color: Colors.white),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.minLength(context, 6),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        print('Valid');
                        FocusScope.of(context).requestFocus(FocusNode());
                        FirebaseAuth auth = FirebaseAuth.instance;
                        Map<String, dynamic>? map =
                            _formKey.currentState?.value;

                        var user = await auth
                            .signInWithEmailAndPassword(
                                email: map!['UserName'],
                                password: map['Password'])
                            .onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Something Went Wrong\n ${error.toString()}',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          // ignore: null_argument_to_non_null_type
                          return Future.value(null);
                        });
                        if (user.user != null) {
                          UserManager().setisLogedIn(true);
                          postDelayed(
                            callbak: () {
                              application.replace(
                                MainRoute(),
                              );
                            },
                          );
                        }

                        // ref.read(accountServiceProvider).userLogin(
                        //       input: _formKey.currentState.value,
                        //       start: () {
                        //         ProgressDialog.showLoading(context);
                        //       },
                        //       success: (res) {
                        //         CommonUi.commonMsgs(
                        //             scaffoldKey: scaffoldKey,
                        //             status: true,
                        //             context: context,
                        //             msg: application.translate('Done'));
                        //         ProgressDialog.dismiss(done: () {
                        //           postDelayed(
                        //             callbak: () {
                        //               application.replace(
                        //                 MainRoute(),
                        //               );
                        //             },
                        //           );
                        //         });

                        //         print("UserLogin success");
                        //       },
                        //       error: (msg) {
                        //         ProgressDialog.dismiss();
                        //         CommonUi.commonMsgs(
                        //             scaffoldKey: scaffoldKey,
                        //             context: context,
                        //             msg: msg);
                        //       },
                        //     );
                      } else {
                        print('Invalid');
                      }
                      print(_formKey.currentState?.value);
                    },
                    // colors: [Style.primaryColor, Style.primaryColor.shade400],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
