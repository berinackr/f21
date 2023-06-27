import 'dart:async';
import 'dart:io';

import 'package:f21_demo/features/forum/controller/pagination_state/pagination_state.dart';
import 'package:f21_demo/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:f21_demo/core/providers/storage_repository_provider.dart';
import 'package:f21_demo/core/utils.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/forum/repository/forum_repository.dart';
import 'package:f21_demo/models/post_model.dart';

final forumControllerProvider = StateNotifierProvider<ForumController, bool>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ForumController(
    forumRepository: postRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final postsProvider = StateNotifierProvider.autoDispose
    .family<PaginationNotifier<PostModel>, PaginationState<PostModel>, String>((ref, String categoryId) {
  return PaginationNotifier(
      fetchNextPosts: (item) {
        return ref.read(forumControllerProvider.notifier).getPostsByCategory(
              categoryId,
              item,
            );
      },
      itemsPerBatch: 20)
    ..init();
});

final mostLikedPostProvider = StateNotifierProvider.autoDispose
    .family<PaginationNotifier<PostModel>, PaginationState<PostModel>, String>((ref, String categoryId) {
  return PaginationNotifier(
      fetchNextPosts: (item) {
        return ref.read(forumControllerProvider.notifier).getMostLikedPostsByCategory(categoryId, item);
      },
      itemsPerBatch: 20)
    ..init();
});

final commentsProvider = StateNotifierProvider.autoDispose
    .family<PaginationNotifier<CommentModel>, PaginationState<CommentModel>, String>((ref, String postId) {
  return PaginationNotifier(
      fetchNextPosts: (item) {
        return ref.read(forumControllerProvider.notifier).getCommentsByPost(postId, item);
      },
      itemsPerBatch: 20)
    ..init();
});

final getPostByIdProvider = StreamProvider.autoDispose.family((ref, String postId) {
  return ref.watch(forumControllerProvider.notifier).streamPostById(postId);
});

final bookmarkedPostsProvider = StateNotifierProvider.autoDispose
    .family<PaginationNotifier<PostModel>, PaginationState<PostModel>, String>((ref, String userId) {
  return PaginationNotifier(
      fetchNextPosts: (item) {
        return ref.read(forumControllerProvider.notifier).getBookmarkedPosts(userId, item);
      },
      itemsPerBatch: 20)
    ..init();
});

class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  final Future<List<T>> Function(T? item) fetchNextPosts;
  final int itemsPerBatch;

  PaginationNotifier({required this.fetchNextPosts, required this.itemsPerBatch})
      : super(const PaginationState.loading());

  final List<T> _items = [];
  Timer _timer = Timer(const Duration(microseconds: 0), () {});
  bool noMoreItems = false;

  void init() {
    _items.clear();
    fetchFirstBatch();
  }

  void updateOnePost(T post, int index) {
    _items[index] = post;
    state = PaginationState.data(_items);
  }

  void updateData(List<T> result) {
    if (result.length < itemsPerBatch) {
      noMoreItems = true;
    }
    if (result.isEmpty) {
      state = PaginationState.data(_items);
    } else {
      state = PaginationState.data(_items..addAll(result));
    }
  }

  void reset() {
    _items.clear();
    fetchFirstBatch();
  }

  Future<void> fetchFirstBatch() async {
    try {
      state = const PaginationState.loading();
      final List<T> result = _items.isEmpty ? await fetchNextPosts(null) : await fetchNextPosts(_items.last);
      updateData(result);
    } catch (e, stk) {
      state = PaginationState.error(e, stk);
    }
  }

  Future<void> fetchNextBatch() async {
    if (noMoreItems) {
      return;
    }
    if (_timer.isActive) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 1000), () {});

    if (state == PaginationState<T>.onGoingLoading(_items)) {
      return;
    }
    state = PaginationState.onGoingLoading(_items);
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await fetchNextPosts(_items.last);
      updateData(result);
    } catch (e, stk) {
      state = PaginationState.onGoingError(_items, e, stk);
    }
  }
}

class ForumController extends StateNotifier<bool> {
  final ForumRepository _forumRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  ForumController({
    required ForumRepository forumRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _forumRepository = forumRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void sharePost(
      {required String title,
      required String content,
      required String category,
      required String categoryId,
      File? photo,
      required BuildContext context}) async {
    state = true;
    final user = _ref.read(userProvider)!;
    String postId = const Uuid().v4();
    String? photoUrl;
    if (photo != null) {
      final res = await _storageRepository.uploadImage(path: "posts/$category", id: postId, file: photo);
      res.fold((l) => showSnackBar(context, l.message), (r) => photoUrl = r);
    }

    final PostModel post = PostModel(
      id: postId,
      title: title.trim(),
      content: content.trim(),
      commentCount: 0,
      upvotes: [],
      downvotes: [],
      totalVote: 0,
      bookmarkedBy: [],
      username: user.username!,
      userPhotoUrl: user.profilePic!,
      uid: user.uid,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      category: category,
      categoryId: categoryId,
      photoUrl: photoUrl,
    );
    final res = await _forumRepository.createPost(post);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      context.pop();
    });
  }

  Future<List<PostModel>> getPostsByCategory(String categoryId, PostModel? lastPost) {
    return _forumRepository.fetchAllPostsByCategory(categoryId, lastPost);
  }

  Future<List<PostModel>> getMostLikedPostsByCategory(String categoryId, PostModel? lastPost) {
    return _forumRepository.fetchAllMostLikedPostsByCategory(categoryId, lastPost);
  }

  Future<List<PostModel>> getPostsByUser(String uid, PostModel? lastPost) {
    return _forumRepository.fetchAllPostsByUser(uid, lastPost);
  }

  Future<List<CommentModel>> getCommentsByPost(String postId, CommentModel? lastComment) {
    return _forumRepository.fetchAllCommentsByPost(postId, lastComment);
  }

  Future<List<PostModel>> getBookmarkedPosts(String uid, PostModel? lastPost) {
    return _forumRepository.fetchBookmarkedPosts(uid, lastPost);
  }

  Future<PostModel> getPostById(String postId) {
    return _forumRepository.fetchPostById(postId);
  }

  Future<CommentModel> getCommentById(String commentId) {
    return _forumRepository.fetchCommentById(commentId);
  }

  Stream<PostModel> streamPostById(String postId) {
    return _forumRepository.streamPostById(postId);
  }

  void upvotePost(PostModel post, BuildContext context, int? index, bool isMostLiked) async {
    if (state) return;
    state = true;
    final user = _ref.read(userProvider)!;
    final res = await _forumRepository.upvote(post, user.uid);
    res.fold((l) => showSnackBar(context, l.message), (r) {
      index == null
          ? null
          : getPostById(post.id).then((r) => isMostLiked
              ? _ref.read(mostLikedPostProvider(post.categoryId).notifier).updateOnePost(r, index)
              : _ref.read(postsProvider(post.categoryId).notifier).updateOnePost(r, index));
    });
    state = false;
  }

  void upvoteComment(CommentModel comment, BuildContext context, int? index) async {
    if (state) return;
    state = true;
    final user = _ref.read(userProvider)!;
    final res = await _forumRepository.upvoteComment(comment, user.uid);
    res.fold((l) => showSnackBar(context, l.message), (r) {
      index == null
          ? null
          : getCommentById(comment.id)
              .then((r) => _ref.read(commentsProvider(r.postId).notifier).updateOnePost(r, index));
    });
    state = false;
  }

  void downvoteComment(CommentModel comment, BuildContext context, int? index) async {
    if (state) return;
    state = true;
    final user = _ref.read(userProvider)!;
    final res = await _forumRepository.downvoteComment(comment, user.uid);
    res.fold((l) => showSnackBar(context, l.message), (r) {
      index == null
          ? null
          : getCommentById(comment.id)
              .then((r) => _ref.read(commentsProvider(r.postId).notifier).updateOnePost(r, index));
    });
    state = false;
  }

  void downvotePost(PostModel post, BuildContext context, int? index, bool isMostLiked) async {
    if (state) return;
    state = true;
    final user = _ref.read(userProvider)!;
    final res = await _forumRepository.downvote(post, user.uid);
    res.fold((l) => showSnackBar(context, l.message), (r) {
      index == null
          ? null
          : getPostById(post.id).then((r) => isMostLiked
              ? _ref.read(mostLikedPostProvider(post.categoryId).notifier).updateOnePost(r, index)
              : _ref.read(postsProvider(post.categoryId).notifier).updateOnePost(r, index));
    });
    state = false;
  }

  void bookmarkPost(PostModel post, BuildContext context, int? index, bool isMostLiked) async {
    if (state) return;
    state = true;
    final user = _ref.read(userProvider)!;
    final res = await _forumRepository.bookmark(post, user.uid);
    res.fold((l) => showSnackBar(context, l.message), (r) {
      index == null
          ? null
          : getPostById(post.id).then((r) => isMostLiked
              ? _ref.read(mostLikedPostProvider(post.categoryId).notifier).updateOnePost(r, index)
              : _ref.read(postsProvider(post.categoryId).notifier).updateOnePost(r, index));
    });
    state = false;
  }

  void shareComment(String postId, String comment, BuildContext context, File? photo) async {
    if (state) return;
    state = true;

    final user = _ref.read(userProvider)!;
    String? photoUrl;
    if (photo != null) {
      final res = await _storageRepository.uploadImage(path: "comments/", id: const Uuid().v4(), file: photo);
      res.fold((l) => showSnackBar(context, l.message), (r) => photoUrl = r);
    }
    final CommentModel newComment = CommentModel(
      id: const Uuid().v4(),
      text: comment.trim(),
      createdAt: DateTime.now(),
      postId: postId,
      downvotes: [],
      upvotes: [],
      profilePic: user.profilePic!,
      username: user.username!,
      uid: user.uid,
      photoUrl: photoUrl,
    );
    final res = await _forumRepository.shareComment(
      newComment,
    );
    res.fold((l) => showSnackBar(context, l.message), (r) {});
    state = false;
  }
}
