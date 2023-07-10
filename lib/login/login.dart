import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.title,
    this.backgroundPath,
    this.iconPath,
    this.onLogin,
    this.titleStyle,
    this.userLabel = 'Usuario',
    this.passwordLabel = 'Contraseña',
    this.minPasswordLength = 6,
    this.maxPasswordLength = 20,
    this.backgroundButtonColor,
    this.contentFlex = 1,
  });

  final String? title;
  final String? backgroundPath;
  final String? iconPath;
  final TextStyle? titleStyle;
  final String userLabel;
  final String passwordLabel;
  final int minPasswordLength;
  final int maxPasswordLength;
  final Color? backgroundButtonColor;
  final int contentFlex;

  final void Function(String username, String password)? onLogin;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          if (widget.backgroundPath != null)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      widget.backgroundPath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: widget.contentFlex,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.title != null)
                          Text(
                            widget.title!,
                            style: widget.titleStyle ??
                                const TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 20),
                        if (widget.iconPath != null)
                          Image.asset(
                            widget.iconPath!,
                            height: 100,
                          ),
                        const SizedBox(height: 20),
                        CupertinoTextFormFieldRow(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su usuario';
                            }
                            return null;
                          },
                          decoration: const BoxDecoration(
                            color: CupertinoColors.extraLightBackgroundGray,
                          ),
                          controller: _usernameController,
                          placeholder: widget.userLabel,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        CupertinoTextFormFieldRow(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su contraseña';
                            }
                            if (value.length < widget.minPasswordLength) {
                              return 'La contraseña debe tener al menos ${widget.minPasswordLength} caracteres';
                            }
                            if (value.length > widget.maxPasswordLength) {
                              return 'La contraseña debe tener menos de ${widget.maxPasswordLength} caracteres';
                            }
                            return null;
                          },
                          decoration: const BoxDecoration(
                            color: CupertinoColors.extraLightBackgroundGray,
                          ),
                          controller: _passwordController,
                          obscureText: true,
                          placeholder: widget.passwordLabel,
                          onFieldSubmitted: (value) {
                            onSendForm();
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CupertinoButton(
                                color: widget.backgroundButtonColor,
                                onPressed: onSendForm,
                                child: const Text('Ingresar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSendForm() {
    bool validation = _formKey.currentState!.validate();
    if (!validation) {
      return;
    }
    if (widget.onLogin != null) {
      widget.onLogin!(
        _usernameController.text,
        _passwordController.text,
      );
    }
  }
}
