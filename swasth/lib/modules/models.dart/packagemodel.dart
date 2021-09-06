import 'dart:convert';

import 'package:flutter/foundation.dart';

class Package {
  final String category;
  final String contactName;
  final String contactNumber;
  final String contactEmail;
  final String description;
  final String packageId;
  final String packageTitle;
  final String price;
  final String rating;
  final String travelAgencyId;
  final String duration;
  Package(
      {@required this.category,
      @required this.contactName,
      @required this.contactNumber,
      @required this.contactEmail,
      @required this.description,
      @required this.packageId,
      @required this.packageTitle,
      @required this.price,
      @required this.rating,
      @required this.travelAgencyId,
      @required this.duration});

  //  copyWith({
  //   String userUuid,
  //   String incidentUuid,
  //   String userName,
  //   List<double> location,
  //   String incidentSummary,
  //   String conversationId,
  //   DateTime reportedOn,
  // }) {
  //   return Incident(
  //     userUuid: userUuid ?? this.userUuid,
  //     incidentUuid: incidentUuid ?? this.incidentUuid,
  //     userName: userName ?? this.userName,
  //     location: location ?? this.location,
  //     incidentSummary: incidentSummary ?? this.incidentSummary,
  //     conversationId: conversationId ?? this.conversationId,
  //     reportedOn: reportedOn ?? this.reportedOn,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'userUuid': userUuid,
  //     'incidentUuid': incidentUuid,
  //     'userName': userName,
  //     'location': location,
  //     'incidentSummary': incidentSummary,
  //     'conversationId': conversationId,
  //     'reportedOn': reportedOn.toString(),
  //   };
  // }

  // factory Incident.fromMap(Map<String, dynamic> map) {
  //   return Incident(
  //     userUuid: map['userUuid'],
  //     incidentUuid: map['incidentUuid'],
  //     userName: map['userName'],
  //     location: List<double>.from(map['location']),
  //     incidentSummary: map['incidentSummary'],
  //     conversationId: map['conversationId'],
  //     reportedOn: DateTime.tryParse(map['reportedOn']),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Incident.fromJson(String source) =>
  //     Incident.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'Incident(userUuid: $userUuid, incidentUuid: $incidentUuid, userName: $userName, location: $location, incidentSummary: $incidentSummary, conversationId: $conversationId, reportedOn: $reportedOn)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Incident &&
  //       other.userUuid == userUuid &&
  //       other.incidentUuid == incidentUuid &&
  //       other.userName == userName &&
  //       listEquals(other.location, location) &&
  //       other.incidentSummary == incidentSummary &&
  //       other.conversationId == conversationId &&
  //       other.reportedOn == reportedOn;
  // }

  // @override
  // int get hashCode {
  //   return userUuid.hashCode ^
  //       incidentUuid.hashCode ^
  //       userName.hashCode ^
  //       location.hashCode ^
  //       incidentSummary.hashCode ^
  //       conversationId.hashCode ^
  //       reportedOn.hashCode;
  // }
}
