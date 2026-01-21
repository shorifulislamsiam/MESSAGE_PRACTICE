class ChatMessage {
  final String id;
  final String message;
  final String sender;
  final String? senderName;
  final String? avatarText;
  final DateTime timestamp;
   bool? isCurrentUser;
  

  ChatMessage({
    required this.id,
    required this.message,
    required this.sender,
    this.senderName,
    this.avatarText,
    required this.timestamp,
     this.isCurrentUser,
    
  });

  // Factory for creating from WebSocket JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      message: json['message'],
      sender: json['sender'],
      senderName: json['senderName'],
      avatarText: json['avatarText'],
      timestamp: DateTime.parse(json['timestamp']),
      isCurrentUser: json['isCurrentUser'],
      
    );
  }

  // Convert to JSON for WebSocket
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'sender': sender,
      'senderName': senderName,
      'avatarText': avatarText,
      'timestamp': timestamp.toIso8601String(),
      'isCurrentUser': isCurrentUser,
      
    };
  }
}