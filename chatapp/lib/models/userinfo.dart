class UsersInfo {
  UsersInfo({
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.uid,
  });
  late String displayName;
  late String email;
  late String phoneNumber;
  late String photoUrl;
  late String uid;

  UsersInfo.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'] ?? '';
    email = json['email'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    photoUrl = json['photoUrl'] ?? '';
    uid = json['uid'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['photoUrl'] = photoUrl;
    data['uid'] = uid;
    return data;
  }
}
