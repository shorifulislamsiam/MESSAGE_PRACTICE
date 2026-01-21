import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_practice/chat_screen/controller/chat_message_controller.dart';
import 'package:message_practice/chat_screen/widget/chat_helper_widget.dart';

class ChatScreen extends StatelessWidget {
  final QuestionTicketReportScreenController controller = Get.put(
    QuestionTicketReportScreenController(),
  );
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat list screen")),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child:
                        message.isCurrentUser!
                            ? Align(
                              alignment: Alignment.centerRight,
                              child: CurrentUserBubble(message: message),
                            )
                            : Align(
                              alignment: Alignment.centerLeft,
                              child: OtherUserBubble(message: message),
                            ),
                  );
                },
              ),
            ),
          ),

          // Chat Input Section
          const ChatInput(),
        ],
      ),
    );
  }
}
