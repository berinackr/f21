// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String? username;
  final String? profilePic;
  final String uid;
  final bool? isPregnant;
  final String? gender;
  final DateTime? birthDate;
  final DateTime? babyBirthDate;
  final double? months;

  UserModel({
    this.username,
    this.profilePic,
    required this.uid,
    this.isPregnant,
    this.gender,
    this.birthDate,
    this.babyBirthDate,
    this.months,
  });

  UserModel copyWith({
    String? username,
    String? profilePic,
    String? uid,
    bool? isPregnant,
    String? gender,
    DateTime? birthDate,
    DateTime? babyBirthDate,
    double? months,
  }) {
    return UserModel(
      username: username ?? this.username,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      isPregnant: isPregnant ?? this.isPregnant,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      babyBirthDate: babyBirthDate ?? this.babyBirthDate,
      months: months ?? this.months,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'profilePic': profilePic,
      'uid': uid,
      'isPregnant': isPregnant,
      'gender': gender,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'babyBirthDate': babyBirthDate?.millisecondsSinceEpoch,
      'months': months,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] != null ? map['username'] as String : null,
      profilePic: map['profilePic'] != null ? map['profilePic'] as String : null,
      uid: map['uid'] as String,
      isPregnant: map['isPregnant'] != null ? map['isPregnant'] as bool : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      birthDate: map['birthDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['birthDate'] as int) : null,
      babyBirthDate:
          map['babyBirthDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['babyBirthDate'] as int) : null,
      months: map['months'] != null ? map['months'] as double : null,
    );
  }

  @override
  String toString() {
    return 'UserModel(username: $username, profilePic: $profilePic, uid: $uid, isPregnant: $isPregnant, gender: $gender, birthDate: $birthDate, babyBirthDate: $babyBirthDate, months: $months)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.isPregnant == isPregnant &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.babyBirthDate == babyBirthDate &&
        other.months == months;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        isPregnant.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        babyBirthDate.hashCode ^
        months.hashCode;
  }
}
