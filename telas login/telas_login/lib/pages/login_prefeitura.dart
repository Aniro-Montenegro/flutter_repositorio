import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:telas_login/config/config_colors.dart';
import 'package:video_player/video_player.dart';

class LoginPrefeitura extends StatefulWidget {
  const LoginPrefeitura({super.key});

  @override
  State<LoginPrefeitura> createState() => _LoginPrefeituraState();
}

class _LoginPrefeituraState extends State<LoginPrefeitura> {
  late VideoPlayerController _controller;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _moved = false;

  bool _obscurePassword = true;
  var cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Formulário válido ✅")),
      );
      print("CPF: ${_cpfController.text}");
      print("Senha: ${_passwordController.text}");
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      "assets/paraibuna.mp4",
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);

        _controller.play();
        setState(() {});
      });

    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _moved = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
          else
            Container(color: Colors.black),
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeInOut,
                            left: _moved ? 120 : 100,
                            child: Image.asset("assets/logo-1.png")),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Bem-vindo!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          bottom: _moved ? 0 : 30,
                          left: 16,
                          right: 16,
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "CPF",
                              hintText: "000.000.000-00",
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            inputFormatters: [cpfFormatter],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite o CPF";
                              }
                              if (value.length != 14) {
                                return "CPF incompleto";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Campo Senha
                  SizedBox(
                    height: 120,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          top: _moved ? 0 : 30, // posição inicial e final
                          left: 16,
                          right: 16,
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: _inputDecoration(
                              label: "Senha",
                              hint: "Digite sua senha",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite a senha";
                              }
                              if (value.length < 6) {
                                return "Senha muito curta (mínimo 6)";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botão enviar
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                      backgroundColor: ConfigColors.corAzulPetroleo,
                      fixedSize: WidgetStateProperty.all(const Size(250, 50)),
                    ),
                    child: Text(
                      "Enviar",
                      style: TextStyle(color: ConfigColors.corTextoBotao),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Colors.white),
      hintStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
