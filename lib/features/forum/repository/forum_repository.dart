import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f21_demo/core/failure.dart';
import 'package:f21_demo/core/providers/firebase_providers.dart';
import 'package:f21_demo/core/type_defs.dart';
import 'package:f21_demo/models/comment_model.dart';
import 'package:f21_demo/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final postRepositoryProvider = Provider((ref) {
  return ForumRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class ForumRepository {
  final FirebaseFirestore _firestore;
  ForumRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts => _firestore.collection("posts");
  CollectionReference get _comments => _firestore.collection("comments");

  FutureVoid createPost(PostModel post) async {
    try {
      return right(_posts.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Bir hata oluştu"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<List<PostModel>> fetchAllPostsByCategory(
      String categoryId, PostModel? lastPost) async {
    if (lastPost == null) {
      final documentSnapshot = await _posts
          .where("categoryId", isEqualTo: categoryId)
          .limit(20)
          .orderBy("updatedAt", descending: true)
          .get();
      return documentSnapshot.docs.map<PostModel>((data) {
        return PostModel.fromMap(data.data() as Map<String, dynamic>);
      }).toList();
    } else {
      final documentSnapshot = await _posts
          .where("categoryId", isEqualTo: categoryId)
          .orderBy("updatedAt", descending: true)
          .startAfter([lastPost.updatedAt.millisecondsSinceEpoch])
          .limit(20)
          .get();
      return documentSnapshot.docs.map<PostModel>((data) {
        return PostModel.fromMap(data.data() as Map<String, dynamic>);
      }).toList();
    }
  }

  Future<List<PostModel>> fetchAllMostLikedPostsByCategory(
      String categoryId, PostModel? lastPost) {
    if (lastPost == null) {
      return _posts
          .where("categoryId", isEqualTo: categoryId)
          .limit(20)
          .orderBy("totalVote", descending: true)
          .get()
          .then((documentSnapshot) {
        return documentSnapshot.docs.map<PostModel>((data) {
          return PostModel.fromMap(data.data() as Map<String, dynamic>);
        }).toList();
      });
    } else {
      return _posts
          .where("categoryId", isEqualTo: categoryId)
          .orderBy("totalVote", descending: true)
          .startAfter([lastPost.totalVote])
          .limit(20)
          .get()
          .then((documentSnapshot) {
            return documentSnapshot.docs.map<PostModel>((data) {
              return PostModel.fromMap(data.data() as Map<String, dynamic>);
            }).toList();
          });
    }
  }

  Future<List<PostModel>> fetchAllPostsByUser(
      String userId, PostModel? lastPost) async {
    if (lastPost == null) {
      final documentSnapshot = await _posts
          .where("userId", isEqualTo: userId)
          .limit(20)
          .orderBy("updatedAt", descending: true)
          .get();
      return documentSnapshot.docs.map<PostModel>((data) {
        return PostModel.fromMap(data.data() as Map<String, dynamic>);
      }).toList();
    } else {
      final documentSnapshot = await _posts
          .where("userId", isEqualTo: userId)
          .orderBy("updatedAt", descending: true)
          .startAfter([lastPost.updatedAt.millisecondsSinceEpoch])
          .limit(20)
          .get();
      return documentSnapshot.docs.map<PostModel>((data) {
        return PostModel.fromMap(data.data() as Map<String, dynamic>);
      }).toList();
    }
  }

  Future<List<CommentModel>> fetchAllCommentsByPost(
      String postId, CommentModel? lastComment) async {
    if (lastComment == null) {
      final documentSnapshot = await _comments
          .where("postId", isEqualTo: postId)
          .limit(20)
          .orderBy("createdAt", descending: true)
          .get();
      return documentSnapshot.docs.map<CommentModel>((data) {
        return CommentModel.fromMap(data.data() as Map<String, dynamic>);
      }).toList();
    } else {
      final documentSnapshot = await _comments
          .where("postId", isEqualTo: postId)
          .orderBy("createdAt", descending: false)
          .startAfter([lastComment.createdAt.millisecondsSinceEpoch])
          .limit(20)
          .get();
      return documentSnapshot.docs.map<CommentModel>((data) {
        return CommentModel.fromMap(data.data() as Map<String, dynamic>);
      }).toList();
    }
  }

  FutureVoid upvoteComment(CommentModel comment, String userId) async {
    try {
      if (comment.downvotes.contains(userId)) {
        _comments.doc(comment.id).update({
          "downvotes": FieldValue.arrayRemove([userId]),
        });
      }
      if (comment.upvotes.contains(userId)) {
        return right(_comments.doc(comment.id).update({
          "upvotes": FieldValue.arrayRemove([userId]),
        }));
      } else {
        return right(_comments.doc(comment.id).update({
          "upvotes": FieldValue.arrayUnion([userId]),
        }));
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Bir hata oluştu"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid downvoteComment(CommentModel comment, String userId) async {
    try {
      if (comment.upvotes.contains(userId)) {
        _comments.doc(comment.id).update({
          "upvotes": FieldValue.arrayRemove([userId]),
        });
      }
      if (comment.downvotes.contains(userId)) {
        return right(_comments.doc(comment.id).update({
          "downvotes": FieldValue.arrayRemove([userId]),
        }));
      } else {
        return right(_comments.doc(comment.id).update({
          "downvotes": FieldValue.arrayUnion([userId]),
        }));
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Bir hata oluştu"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<PostModel> fetchPostById(String postId) async {
    final documentSnapshot = await _posts.doc(postId).get();
    return PostModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

  Future<CommentModel> fetchCommentById(String commentId) async {
    final documentSnapshot = await _comments.doc(commentId).get();
    return CommentModel.fromMap(
        documentSnapshot.data() as Map<String, dynamic>);
  }

  Stream<PostModel> streamPostById(String postId) {
    return _posts.doc(postId).snapshots().map(
        (event) => PostModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<List<PostModel>> fetchBookmarkedPosts(
      String userId, PostModel? lastPost) async {
    if (lastPost == null) {
      final documentSnapshot = await _posts
          .where("bookmarkedBy", arrayContains: userId)
          .limit(20)
          .orderBy("updatedAt", descending: true)
          .get();
      return documentSnapshot.docs.map<PostModel>((data) {
        return PostModel.fromMap(data.data() as Map<String, dynamic>);
      }).toList();
    } else {
      final documentSnapshot = await _posts
          .where("bookmarkedBy", arrayContains: userId)
          .orderBy("updatedAt", descending: true)
          .startAfter([lastPost.updatedAt.millisecondsSinceEpoch])
          .limit(20)
          .get();
      return documentSnapshot.docs.map<PostModel>((data) {
        return PostModel.fromMap(data.data() as Map<String, dynamic>);
      }).toList();
    }
  }

  FutureVoid shareComment(CommentModel comment) async {
    try {
      _posts.doc(comment.postId).update({
        "commentCount": FieldValue.increment(1),
        "updatedAt": DateTime.now().millisecondsSinceEpoch,
      });

      return right(_comments.doc(comment.id).set(comment.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Bir hata oluştu"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid upvote(PostModel post, String userId) async {
    try {
      if (post.downvotes.contains(userId)) {
        _posts.doc(post.id).update({
          "downvotes": FieldValue.arrayRemove([userId]),
          "totalVote": FieldValue.increment(1),
        });
      }

      if (post.upvotes.contains(userId)) {
        return right(_posts.doc(post.id).update({
          "upvotes": FieldValue.arrayRemove([userId]),
          "totalVote": FieldValue.increment(-1),
        }));
      } else {
        return right(_posts.doc(post.id).update({
          "upvotes": FieldValue.arrayUnion([userId]),
          "totalVote": FieldValue.increment(1),
        }));
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Bir hata oluştu"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid downvote(PostModel post, String userId) async {
    try {
      if (post.upvotes.contains(userId)) {
        _posts.doc(post.id).update({
          "upvotes": FieldValue.arrayRemove([userId]),
          "totalVote": FieldValue.increment(-1),
        });
      }

      if (post.downvotes.contains(userId)) {
        return right(_posts.doc(post.id).update({
          "downvotes": FieldValue.arrayRemove([userId]),
          "totalVote": FieldValue.increment(1),
        }));
      } else {
        return right(_posts.doc(post.id).update({
          "downvotes": FieldValue.arrayUnion([userId]),
          "totalVote": FieldValue.increment(-1),
        }));
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Bir hata oluştu"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid bookmark(PostModel post, String userId) async {
    try {
      if (post.bookmarkedBy.contains(userId)) {
        return right(_posts.doc(post.id).update({
          "bookmarkedBy": FieldValue.arrayRemove([userId])
        }));
      } else {
        return right(_posts.doc(post.id).update({
          "bookmarkedBy": FieldValue.arrayUnion([userId])
        }));
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Bir hata oluştu"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
