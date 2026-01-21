import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_practice/chat_screen/controller/chat_message_controller.dart';
import 'package:message_practice/chat_screen/model/chat_message_model.dart';

class CurrentUserBubble extends StatelessWidget {
  final ChatMessage message;

  const CurrentUserBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionTicketReportScreenController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (message.questionId != null) ...[
                  //   Text(
                  //     'Question ID: ${message.questionId}',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       color: Color(0XFF0A0A0A),
                  //       fontSize: 14,
                  //     ),
                  //   ),
                  //   const SizedBox(height: 12),
                  // ],
                  Text(
                    message.message,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF404040),
                        fontSize: 14,
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Color(0XFFE2E2E2),
              child: Icon(Icons.person),
            ),
          ],
        ),

        SizedBox(height: 4),
        Padding(
          padding: EdgeInsets.only(right: 53),
          child: Text(
            controller.formatTime(message.timestamp),
            style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF404040),
                        fontSize: 14,
                      ),
          ),
        ),
      ],
    );
  }
}

// Left-side message bubble (Other User)
class OtherUserBubble extends StatelessWidget {
  final ChatMessage message;

  const OtherUserBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionTicketReportScreenController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD6E4FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  message.avatarText ?? 'U',
                  style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF404040),
                        fontSize: 14,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 280),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF0FAFF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      message.message,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF404040),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 52),
          child: Text(
            controller.formatTime(message.timestamp),
            style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
          ),
        ),
      ],
    );
  }
}

//chat input widget
class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionTicketReportScreenController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0XFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            TextFormField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: "Type message",
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.rotate( //this rotate is used to show the link image to diagonal(as like top right corner)
                  angle: math.pi / 4,
                  child: GestureDetector(
                    onTap: controller.attachFile,
                    child: Icon(Icons.message),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      controller.sendMessage(controller.messageController.text),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1D2E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6),
                        Transform.rotate(
                          angle: -math.pi / 4,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}