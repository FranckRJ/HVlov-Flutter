import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'hvlov_config_model.dart';

class SettingsDialog extends HookWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  String? requiredFieldValidator(String? value) {
    if (value!.isEmpty) {
      return "Champ requis";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final configModel = context.watch<HvlovConfigModel>();

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final urlTextEditController =
        useMemoized(() => TextEditingController(text: configModel.url));
    final passwordTextEditController =
        useMemoized(() => TextEditingController(text: configModel.password));

    return AlertDialog(
      title: const Text("Paramètres"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: urlTextEditController,
              decoration: const InputDecoration(
                labelText: "Adresse du serveur",
              ),
              validator: requiredFieldValidator,
            ),
            TextFormField(
              controller: passwordTextEditController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mot de passe",
              ),
              validator: requiredFieldValidator,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Annuler"),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              configModel.saveConfig(
                  urlTextEditController.text, passwordTextEditController.text);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Appliquer"),
        ),
      ],
    );
  }
}
