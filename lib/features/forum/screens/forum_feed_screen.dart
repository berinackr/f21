import 'package:f21_demo/core/categories.dart';
import 'package:f21_demo/core/common/loader.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/core/utils.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/forum/controller/forum_controller.dart';
import 'package:f21_demo/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumFeedScreen extends ConsumerStatefulWidget {
  const ForumFeedScreen({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForumFeedScreenState();
}

class _ForumFeedScreenState extends ConsumerState<ForumFeedScreen> {
  final ScrollController scrollController = ScrollController();
  bool isMostLiked = false;

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
    final categoryName = Categories.getCategoryNameById(int.parse(
        widget.id)); //TODO Burada name etkinilkler ise share butonu gözükemsin
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        if (isMostLiked) {
          ref.read(mostLikedPostProvider(widget.id).notifier).fetchNextBatch();
        } else {
          ref.read(postsProvider(widget.id).notifier).fetchNextBatch();
        }
      }
    });
    return Scaffold(
      floatingActionButton:
          ScrollToTopButton(scrollController: scrollController),
      appBar: AppBar(
        backgroundColor: CustomStyles.primaryColor,
        title: Text("$categoryName - Forum"),
        actions: [
          Transform.rotate(
            angle: isMostLiked ? 0 : 180 * 3.14 / 180,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isMostLiked = !isMostLiked;
                });
              },
              icon: const Icon(Icons.sort),
            ),
          ),
          categoryName == "Etkinlik" ? Container() : IconButton(
            onPressed: () {
              context.push(
                  '/forum/${widget.id}/share'); //TODO Önce forum bilgileirni ekle Bu da kategori etkinikler ise paylaşma false invisible
            },
            icon: const Icon(Icons.add_circle_outline_sharp),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          if (isMostLiked) {
            return ref.read(mostLikedPostProvider(widget.id).notifier).reset();
          } else {
            return ref.read(postsProvider(widget.id).notifier).reset();
          }
        },
        child: CustomScrollView(
          controller: scrollController,
          restorationId: "forum_feed_screen",
          slivers: [
            Consumer(builder: (context, ref, child) {
              final state = isMostLiked
                  ? ref.watch(mostLikedPostProvider(widget.id))
                  : ref.watch(postsProvider(widget.id));
              return state.when(
                data: (posts) {
                  return posts.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Column(children: [
                            SizedBox(height: 20),
                            Text("Bu kategoride henüz bir paylaşım yok!"),
                          ]),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Post(
                                post: posts[index],
                                index: index,
                                isMostLiked: isMostLiked,
                              );
                            },
                            childCount: posts.length,
                          ),
                        );
                },
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
                loading: () => const SliverToBoxAdapter(
                  child: Loader(),
                ),
                onGoingError: (posts, e, stk) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Post(
                          post: posts[index],
                          index: index,
                          isMostLiked: isMostLiked,
                        );
                      },
                      childCount: posts.length,
                    ),
                  );
                },
                onGoingLoading: (posts) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Post(
                          post: posts[index],
                          index: index,
                          isMostLiked: isMostLiked,
                        );
                      },
                      childCount: posts.length,
                    ),
                  );
                },
              );
            }),
            NoMoreItems(id: widget.id, isMostLiked: isMostLiked),
            OnGoingBottomWidget(id: widget.id, isMostLiked: isMostLiked),
          ],
        ),
      ),
    );
  }
}

class Post extends ConsumerWidget {
  const Post(
      {super.key,
      required this.post,
      required this.index,
      required this.isMostLiked});
  final PostModel post;
  final int index;
  final bool isMostLiked;

  void upvotePost(BuildContext context, WidgetRef ref) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref
          .read(forumControllerProvider.notifier)
          .upvotePost(post, context, index, isMostLiked, false);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  void downvotePost(BuildContext context, WidgetRef ref) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref
          .read(forumControllerProvider.notifier)
          .downvotePost(post, context, index, isMostLiked, false);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  void bookmarkPost(BuildContext context, WidgetRef ref) {
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    if (user != null) {
      ref
          .read(forumControllerProvider.notifier)
          .bookmarkPost(post, context, index, isMostLiked, false);
    } else {
      showSnackBar(context, "Önce giriş yapmalısınız!");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    final user = ref.read(authControllerProvider.notifier).getCurrentUser();
    final liked = user != null ? post.upvotes.contains(user.uid) : false;
    final downvoted = user != null ? post.downvotes.contains(user.uid) : false;
    final bookmarked =
        user != null ? post.bookmarkedBy.contains(user.uid) : false;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      backgroundImage: NetworkImage(post.userPhotoUrl),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: CustomStyles.titleColor),
                      ),
                      Text(timeago.format(post.createdAt),
                          style: TextStyle(
                              fontSize: 12,
                              color: CustomStyles.forumTextColor)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(post.photoUrl!)),
                            ],
                          )
                  ],
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => upvotePost(context, ref),
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
                          (post.upvotes.length - post.downvotes.length)
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
                          onTap: () => downvotePost(context, ref),
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
                    InkWell(
                      onTap: () {
                        context.push("/forum/post/${post.id}");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            const Icon(Icons.mode_comment_outlined, size: 20),
                            const SizedBox(width: 8),
                            Text(post.commentCount.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => bookmarkPost(context, ref),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: bookmarked
                              ? CustomStyles.titleColor.withOpacity(0.2)
                              : null,
                        ),
                        child: Icon(
                          bookmarked ? Icons.bookmark : Icons.bookmark_border,
                          size: 20,
                          color: bookmarked ? CustomStyles.titleColor : null,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class OnGoingBottomWidget extends ConsumerWidget {
  const OnGoingBottomWidget(
      {super.key, required this.id, required this.isMostLiked});
  final String id;
  final bool isMostLiked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Consumer(builder: (context, ref, child) {
              final state = isMostLiked
                  ? ref.watch(mostLikedPostProvider(id))
                  : ref.watch(postsProvider(id));
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
  const NoMoreItems({super.key, required this.id, required this.isMostLiked});
  final String id;
  final bool isMostLiked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    final state = isMostLiked
        ? ref.watch(mostLikedPostProvider(id))
        : ref.watch(postsProvider(id));
    return SliverToBoxAdapter(
      child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (items) {
            final noMoreItems = isMostLiked
                ? ref.read(mostLikedPostProvider(id).notifier).noMoreItems
                : ref.read(postsProvider(id).notifier).noMoreItems;
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

class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    return AnimatedBuilder(
        animation: scrollController,
        builder: (context, child) {
          double scrollOffset = scrollController.offset;
          return scrollOffset > MediaQuery.of(context).size.height * 0.8
              ? FloatingActionButton(
                  onPressed: () async {
                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  backgroundColor: CustomStyles.titleColor,
                  tooltip: "En başa dön",
                  child: Icon(
                    Icons.arrow_upward_sharp,
                    color: CustomStyles.fillColor,
                  ),
                )
              : const SizedBox.shrink();
        });
  }
}
