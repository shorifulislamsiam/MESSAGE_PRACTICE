import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_practice/chat_screen/model/chat_message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class QuestionTicketReportScreenController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    loadInitialMessages();
    //  Initialize WebSocket connection here
    initSocket();
  }

  void initSocket() {
    socket = IO.io(
      "https://YOUR_SOCKET_URL",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    // Connection success
    socket.onConnect((_) {
      print("🔌 Socket connected");
    });

    // Message received from server
    socket.on("receive_message", (data) {
      print("📩 Received: $data");

      handleWebSocketMessage(data);
    });

    // On disconnect
    socket.onDisconnect((_) {
      print("❌ Socket disconnected");
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    messageController.dispose();
    //  Close WebSocket connection here
    // closeWebSocket();
    socket.dispose();
    super.onClose();
  }

  // Load initial demo messages
  void loadInitialMessages() {
    messages.addAll([
      ChatMessage(
        id: '1',
        message:
            'Hello,\nThis Question does not contain the correct answer. The answer is:',
        sender: 'system',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isCurrentUser: true,
      ),
      ChatMessage(
        id: '2',
        message:
            'Hi Alex,\n\nThanks for your feedback. We will check it and let you know',
        sender: 'user123',
        senderName: 'John Doe',
        avatarText: 'JD',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isCurrentUser: false,
      ),
    ]);
  }

  // Send message
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: text.trim(),
      sender: "currentUser",
      timestamp: DateTime.now(),
      isCurrentUser: true,
    );

    // Add to UI
    messages.add(newMessage);

    messageController.clear();
    _scrollToBottom();

    // Send to backend
    socket.emit("send_message", newMessage.toJson());
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void handleWebSocketMessage(dynamic data) {
    try {
      final msg = ChatMessage.fromJson(data);
      msg.isCurrentUser = false; // <-- important
      receiveMessage(msg);
    } catch (e) {
      debugPrint("❌ Error parsing message: $e");
    }
  }

  // Receive message from WebSocket
  void receiveMessage(ChatMessage message) {
    messages.add(message);

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
  // Handle WebSocket message (parse and add)

  // Attach file
  void attachFile() {
    debugPrint('Attach file clicked');
  }

  // Format timestamp
  String formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final isToday =
        dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;

    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    if (isToday) {
      return 'Today, $hour:$minute $period';
    } else {
      return '${dateTime.day}/${dateTime.month}, $hour:$minute $period';
    }
  }
}
