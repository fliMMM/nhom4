class UsersInfo {
  UsersInfo({
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.uid,
  });
  late String displayName;
  late String email;
  late String phoneNumber;
  late String photoURL;
  late String uid;

  UsersInfo.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'] ?? '';
    email = json['email'] ?? '';
    phoneNumber = json['displayName'] ?? '';
    photoURL = json['photoURL'] ?? '';
    uid = json['uid'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['displayName'] = displayName;
    data['photoURL'] = photoURL;
    data['uid'] = uid;
    return data;
  }
}
