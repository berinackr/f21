
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/auth/repository/auth_repository.dart';
import 'package:f21_demo/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/custom_styles.dart';

void showProfilePopUp(BuildContext context, BoxConstraints viewportConstraints, WidgetRef ref){
  final User? currentUser = ref.read(authRepositoryProvider).getCurrentUser(); //Burada mail bilgisi var ancak displayName boş gözüküyo o nedenle aşağıda username aldık
  final UserModel? currentUserInfo = ref.read(userProvider);
  showDialog(context: context, builder: (context) {
    return Dialog(
      alignment: Alignment.topCenter,
      backgroundColor: CustomStyles.backgroundColor,
      elevation: 10,
      insetAnimationCurve: Curves.bounceOut,
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: viewportConstraints.maxWidth * 0.5,
          maxHeight: viewportConstraints.maxHeight * 0.6,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: viewportConstraints.maxHeight * 0.5 * 0.5,
              child: const FittedBox(
                  fit: BoxFit.contain,
                  child: CircleAvatar(
                    //backgroundImage: Buraya user görseli gelecek firebase'den çekilen,
                    radius: 20,
                  )),
            ),
            Text(currentUserInfo?.username ?? "Misafir Kullanici"),
            Text(currentUser!.email ?? "misafir@biberon.app"),
            ElevatedButton(
                onPressed: () {
                  context
                    ..pop()
                    ..push('/home/profile');
                },
                child: const Text("Profilimi Görüntüle")
            ),
          ],
        ),
      ),
    );
  },
  );
}