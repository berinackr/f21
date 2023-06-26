import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CommentModel {
  final String id;
  final String text;
  final DateTime createdAt;
  final String postId;
  final String username;
  final String uid;
  final List<String> upvotes;
  final List<String> downvotes;
  final String profilePic;
  final String? photoUrl;

  CommentModel({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.postId,
    required this.username,
    required this.uid,
    required this.upvotes,
    required this.downvotes,
    required this.profilePic,
    this.photoUrl,
  });

  CommentModel copyWith({
    String? id,
    String? text,
    DateTime? createdAt,
    String? postId,
    String? username,
    String? uid,
    List<String>? upvotes,
    List<String>? downvotes,
    String? profilePic,
    String? photoUrl,
  }) {
    return CommentModel(
      id: id ?? this.id,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      postId: postId ?? this.postId,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      profilePic: profilePic ?? this.profilePic,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'postId': postId,
      'username': username,
      'uid': uid,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'profilePic': profilePic,
      'photoUrl': photoUrl,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as String,
      text: map['text'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      postId: map['postId'] as String,
      username: map['username'] as String,
      uid: map['uid'] as String,
      upvotes: List<String>.from((map['upvotes'] as List<dynamic>)),
      downvotes: List<String>.from((map['downvotes'] as List<dynamic>)),
      profilePic: map['profilePic'] as String,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
    );
  }

  @override
  String toString() {
    return 'CommentModel(id: $id, text: $text, createdAt: $createdAt, postId: $postId, username: $username, uid: $uid, upvotes: $upvotes, downvotes: $downvotes, profilePic: $profilePic, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.createdAt == createdAt &&
        other.postId == postId &&
        other.username == username &&
        other.uid == uid &&
        listEquals(other.upvotes, upvotes) &&
        listEquals(other.downvotes, downvotes) &&
        other.profilePic == profilePic &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        createdAt.hashCode ^
        postId.hashCode ^
        username.hashCode ^
        uid.hashCode ^
        upvotes.hashCode ^
        downvotes.hashCode ^
        profilePic.hashCode ^
        photoUrl.hashCode;
  }
}
