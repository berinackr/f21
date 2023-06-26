// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class PostModel {
  final String id;
  final String title;
  final String content;
  final int commentCount;
  final List<String> upvotes;
  final List<String> downvotes;
  final int totalVote;
  final List<String> bookmarkedBy;
  final String username;
  final String userPhotoUrl;
  final String uid;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String category;
  final String categoryId;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.commentCount,
    required this.upvotes,
    required this.downvotes,
    required this.totalVote,
    required this.bookmarkedBy,
    required this.username,
    required this.userPhotoUrl,
    required this.uid,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.categoryId,
  });

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    int? commentCount,
    List<String>? upvotes,
    List<String>? downvotes,
    int? totalVote,
    List<String>? bookmarkedBy,
    String? username,
    String? userPhotoUrl,
    String? uid,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    String? categoryId,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      commentCount: commentCount ?? this.commentCount,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      totalVote: totalVote ?? this.totalVote,
      bookmarkedBy: bookmarkedBy ?? this.bookmarkedBy,
      username: username ?? this.username,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'commentCount': commentCount,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'totalVote': totalVote,
      'bookmarkedBy': bookmarkedBy,
      'username': username,
      'userPhotoUrl': userPhotoUrl,
      'uid': uid,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'category': category,
      'categoryId': categoryId,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      commentCount: map['commentCount'] as int,
      upvotes: List<String>.from((map['upvotes'] as List<dynamic>)),
      downvotes: List<String>.from((map['downvotes'] as List<dynamic>)),
      totalVote: map['totalVote'] as int,
      bookmarkedBy: List<String>.from((map['bookmarkedBy'] as List<dynamic>)),
      username: map['username'] as String,
      userPhotoUrl: map['userPhotoUrl'] as String,
      uid: map['uid'] as String,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      category: map['category'] as String,
      categoryId: map['categoryId'] as String,
    );
  }

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, content: $content, commentCount: $commentCount, upvotes: $upvotes, downvotes: $downvotes, totalVote: $totalVote, bookmarkedBy: $bookmarkedBy, username: $username, userPhotoUrl: $userPhotoUrl, uid: $uid, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt, category: $category, categoryId: $categoryId)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.commentCount == commentCount &&
        listEquals(other.upvotes, upvotes) &&
        listEquals(other.downvotes, downvotes) &&
        other.totalVote == totalVote &&
        listEquals(other.bookmarkedBy, bookmarkedBy) &&
        other.username == username &&
        other.userPhotoUrl == userPhotoUrl &&
        other.uid == uid &&
        other.photoUrl == photoUrl &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.category == category &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        commentCount.hashCode ^
        upvotes.hashCode ^
        downvotes.hashCode ^
        totalVote.hashCode ^
        bookmarkedBy.hashCode ^
        username.hashCode ^
        userPhotoUrl.hashCode ^
        uid.hashCode ^
        photoUrl.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        category.hashCode ^
        categoryId.hashCode;
  }
}
