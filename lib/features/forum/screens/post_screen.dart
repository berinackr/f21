import 'dart:io';
import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/core/utils.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/forum/controller/forum_controller.dart';
import 'package:f21_demo/features/forum/screens/forum_feed_screen.dart';
import 'package:f21_demo/models/comment_model.dart';
import 'package:f21_demo/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final ScrollController scrollController = ScrollController();
  final commentController = TextEditingController();
  File? commentFile;

  void selectCommentImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        commentFile = File(res.files.first.path!);
      });
    }
  }

  void upvotePost(BuildContext context, WidgetRef ref, PostModel post) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref
          .read(forumControllerProvider.notifier)
          .upvotePost(post, context, null, true, false);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  void downvotePost(BuildContext context, WidgetRef ref, PostModel post) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref
          .read(forumControllerProvider.notifier)
          .downvotePost(post, context, null, true, false);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  void bookmarkPost(BuildContext context, WidgetRef ref, PostModel post) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref
          .read(forumControllerProvider.notifier)
          .bookmarkPost(post, context, null, true, false);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  void shareComment(BuildContext context, WidgetRef ref, String postId) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref.read(forumControllerProvider.notifier).shareComment(
            postId,
            commentController.text,
            context,
            commentFile,
          );
      ref.invalidate(commentsProvider);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages("tr", timeago.TrMessages());
    timeago.setDefaultLocale("tr");
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    final isLoading = ref.watch(forumControllerProvider);

    return Scaffold(
      floatingActionButton:
          ScrollToTopButton(scrollController: scrollController),
      appBar: AppBar(
        backgroundColor: CustomStyles.primaryColor,
        title: const Text('Forum - Detay'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.invalidate(postsProvider);
            context.pop();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(commentsProvider(widget.id).notifier).reset();
        },
        child: CustomScrollView(
          controller: scrollController,
          restorationId: widget.id,
          slivers: [
            Consumer(builder: (context, ref, child) {
              final state = ref.watch(getPostByIdProvider(widget.id));
              return state.when(
                data: (post) {
                  final liked =
                      user != null ? post.upvotes.contains(user.uid) : false;
                  final downvoted =
                      user != null ? post.downvotes.contains(user.uid) : false;
                  final bookmarked = user != null
                      ? post.bookmarkedBy.contains(user.uid)
                      : false;
                  return SliverToBoxAdapter(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: CustomStyles.titleColor,
                                    backgroundImage:
                                        NetworkImage(post.userPhotoUrl),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(post.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: CustomStyles.titleColor)),
                                    Text(
                                      timeago.format(post.createdAt),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: CustomStyles.forumTextColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                post.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: CustomStyles.titleColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 7),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.content,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  post.photoUrl == null
                                      ? const SizedBox()
                                      : Column(
                                          children: [
                                            const SizedBox(height: 7),
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                    post.photoUrl!)),
                                          ],
                                        )
                                ],
                              ),
                            ),
                            const SizedBox(height: 7),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Flex(
                                direction: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            upvotePost(context, ref, post),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: liked
                                                ? CustomStyles.titleColor
                                                    .withOpacity(0.1)
                                                : null,
                                          ),
                                          child: Icon(
                                            Icons.arrow_upward_rounded,
                                            size: 20,
                                            color: liked
                                                ? CustomStyles.titleColor
                                                : null,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        (post.upvotes.length -
                                                post.downvotes.length)
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: liked
                                              ? CustomStyles.titleColor
                                              : downvoted
                                                  ? CustomStyles.titleColor
                                                  : null,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      InkWell(
                                        onTap: () =>
                                            downvotePost(context, ref, post),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: downvoted
                                                ? CustomStyles.titleColor
                                                    .withOpacity(0.2)
                                                : null,
                                          ),
                                          child: Icon(Icons.arrow_downward,
                                              size: 20,
                                              color: downvoted
                                                  ? CustomStyles.titleColor
                                                  : null),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.mode_comment_outlined,
                                              size: 20),
                                          const SizedBox(width: 8),
                                          Text(post.commentCount.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        bookmarkPost(context, ref, post),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: bookmarked
                                            ? CustomStyles.titleColor
                                                .withOpacity(0.2)
                                            : null,
                                      ),
                                      child: Icon(
                                        bookmarked
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        size: 20,
                                        color: bookmarked
                                            ? CustomStyles.titleColor
                                            : null,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                error: (e, stk) => const SliverToBoxAdapter(
                  child: Text('Error'),
                ),
                loading: () => SliverToBoxAdapter(
                    child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 2,
                  child: const SizedBox(height: 150, child: Loader()),
                )),
              );
            }),
            SliverToBoxAdapter(
                child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 2,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 0),
                  child: user == null
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Yorum yapabilmek için önce giriş yapmalısınız.",
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      : isLoading
                          ? const Loader()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextField(
                                  controller: commentController,
                                  maxLines: 2,
                                  onTapOutside: (b) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Fikirlerini paylaş...',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CustomStyles.forumTextColor,
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                ),
                                commentFile != null
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(commentFile!)),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                    : const SizedBox(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: selectCommentImage,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: CustomStyles.titleColor,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        commentFile != null
                                            ? InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    commentFile = null;
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 2,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color:
                                                        CustomStyles.titleColor,
                                                    size: 24,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (commentController.text.isEmpty) {
                                          showSnackBar(
                                              context, "Yorum boş olamaz");
                                          return;
                                        }
                                        shareComment(context, ref, widget.id);
                                        commentController.clear();
                                        setState(() {
                                          commentFile = null;
                                        });
                                      },
                                      child: Text(
                                        'Gönder',
                                        style: TextStyle(
                                            color: CustomStyles.titleColor),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
            )),
            Consumer(builder: (context, ref, child) {
              final state = ref.watch(commentsProvider(widget.id));
              return state.when(
                  data: (comments) {
                    return comments.isEmpty
                        ? const SliverToBoxAdapter(
                            child: Column(children: [
                              SizedBox(height: 20),
                              Text("Bu soru daha önce cevaplanmamış."),
                            ]),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Comment(
                                  comment: comments[index],
                                  index: index,
                                );
                              },
                              childCount: comments.length,
                            ),
                          );
                  },
                  loading: () => const SliverToBoxAdapter(
                        child: Loader(),
                      ),
                  error: (e, stk) => SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            children: [
                              const Icon(Icons.error),
                              const SizedBox(height: 20),
                              Text(e.toString()),
                              Text(stk.toString()),
                            ],
                          ),
                        ),
                      ),
                  onGoingLoading: (posts) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Comment(
                            comment: posts[index],
                            index: index,
                          );
                        },
                        childCount: posts.length,
                      ),
                    );
                  },
                  onGoingError: (posts, e, stk) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Comment(
                            comment: posts[index],
                            index: index,
                          );
                        },
                        childCount: posts.length,
                      ),
                    );
                  });
            }),
            NoMoreItems(id: widget.id),
            OnGoingBottomWidget(id: widget.id),
          ],
        ),
      ),
    );
  }
}

class Comment extends ConsumerWidget {
  const Comment({super.key, required this.comment, required this.index});
  final CommentModel comment;
  final int index;

  void upvoteComment(BuildContext context, WidgetRef ref) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref
          .read(forumControllerProvider.notifier)
          .upvoteComment(comment, context, index);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  void downvoteComment(BuildContext context, WidgetRef ref) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref
          .read(forumControllerProvider.notifier)
          .downvoteComment(comment, context, index);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    final liked = user != null ? comment.upvotes.contains(user.uid) : false;
    final downvoted =
        user != null ? comment.downvotes.contains(user.uid) : false;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomStyles.titleColor,
                    backgroundImage: NetworkImage(comment.profilePic),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.username,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: CustomStyles.titleColor),
                    ),
                    Text(timeago.format(comment.createdAt),
                        style: TextStyle(
                            fontSize: 12, color: CustomStyles.forumTextColor)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  comment.photoUrl == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            const SizedBox(height: 7),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(comment.photoUrl!)),
                          ],
                        )
                ],
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => upvoteComment(context, ref),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: liked
                                ? CustomStyles.titleColor.withOpacity(0.1)
                                : null,
                          ),
                          child: Icon(
                            Icons.arrow_upward_rounded,
                            size: 20,
                            color: liked ? CustomStyles.titleColor : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        (comment.upvotes.length - comment.downvotes.length)
                            .toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: liked
                              ? CustomStyles.titleColor
                              : downvoted
                                  ? CustomStyles.titleColor
                                  : null,
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () => downvoteComment(context, ref),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: downvoted
                                ? CustomStyles.titleColor.withOpacity(0.2)
                                : null,
                          ),
                          child: Icon(Icons.arrow_downward,
                              size: 20,
                              color:
                                  downvoted ? CustomStyles.titleColor : null),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnGoingBottomWidget extends ConsumerWidget {
  const OnGoingBottomWidget({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Consumer(builder: (context, ref, child) {
              final state = ref.watch(commentsProvider(id));
              return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  onGoingLoading: (items) {
                    return const Loader();
                  },
                  onGoingError: (posts, e, stk) {
                    return Column(
                      children: [
                        const Icon(Icons.error),
                        const SizedBox(height: 20),
                        Text(e.toString()),
                        Text(stk.toString()),
                      ],
                    );
                  });
            })));
  }
}

class NoMoreItems extends ConsumerWidget {
  const NoMoreItems({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentsProvider(id));
    return SliverToBoxAdapter(
      child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (items) {
            final noMoreItems =
                ref.read(commentsProvider(id).notifier).noMoreItems;
            return noMoreItems
                ? items.isEmpty
                    ? const SizedBox.shrink()
                    : const Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 5),
                        child: Text(
                          "Daha fazla paylaşım yok!",
                          textAlign: TextAlign.center,
                        ),
                      )
                : const SizedBox.shrink();
          }),
    );
  }
}
