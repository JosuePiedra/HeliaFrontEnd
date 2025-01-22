import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/chatBot/chatBot_controller.dart';
import 'package:helia_frontend/app/presentation/chatBot/widgets/buttons.dart';
import 'package:helia_frontend/app/themes/custom_margin.dart';
import 'package:helia_frontend/app/themes/font_size.dart';
import 'package:helia_frontend/app/themes/responsive.dart';

class ButtonsFunction extends GetView<ChatbotController> {
  final Responsive responsive = Responsive();
  ButtonsFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ActionButton(
            text: 'Agregar un recordatorio',
            icon: Icons.notifications_on_sharp,
            color: Color(0xff1E90FF),
            onPressed: () => {
              print('gola'),
              controller.seleccionadoValor.value = 1,

              controller.showTypingIndicator(),

              // Add activation logic here
            },
          ),
          customYMargin(responsive.hp(2)),
          ActionButton(
            text: 'Agendar una cita',
            icon: Icons.calendar_month,
            color: Color(0xffFF8C00),
            onPressed: () {
              controller.seleccionadoValor.value = 2;

              controller.showTypingIndicator();
              // Add bookmark logic here
            },
          ),
          customYMargin(responsive.hp(2)),
          ActionButton(
            text: 'Realizar consultas',
            icon: Icons.chat,
            color: Color(0xff800080), // Orange color
            onPressed: () {
              controller.seleccionadoValor.value = 3;

              controller.showTypingIndicator();
              // Add bookmark logic here
            },
          ),
        ],
      ),
      // SizedBox(
    ]);
  }
}
