import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_testing/features/home/presentation/home_screen.dart';
import 'package:supabase_testing/utils/dialog_utils.dart';

import '../../../utils/common_textfield.dart';
import '../data/auth_repository.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final pswVisible = useState(false);

    return Form(
      key: formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: 20, bottom: 30),
              child: Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            CommonTextfield(
              controller: emailController,
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email cannot be empty";
                }
                return null;
              },
            ),

            CommonTextfield(
              controller: passwordController,
              suffix: InkWell(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    pswVisible.value ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                onTap: () {
                  pswVisible.value = !pswVisible.value;
                },
              ),
              obscureText: !pswVisible.value,
              labelText: "Password",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Password cannot be empty";
                }
                return null;
              },
            ),

            Consumer(
              builder:
                  (cxt, ref, __) => ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.purple),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authRepositoryProvider)
                              .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              )
                              .then((_) {
                                if (cxt.mounted) {
                                  Navigator.of(cxt).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => HomeScreen(),
                                    ),
                                  );
                                }
                              });
                        }
                      } catch (e, st) {
                        if (cxt.mounted) {
                          showDialog(
                            context: cxt,
                            builder: (_) => DialogUtils.errorDialog(msg: "$e"),
                          );
                        }
                      }
                    },
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
