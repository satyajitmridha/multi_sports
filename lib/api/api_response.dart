class ApiResponse {
  final String processStatus;
  final String processMessage;
  final List<EventDetails> eventDetails;

  ApiResponse({
    required this.processStatus,
    required this.processMessage,
    required this.eventDetails,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      processStatus: json['process_status'],
      processMessage: json['process_message'],
      eventDetails: (json['event_details'] as List)
          .map((e) => EventDetails.fromJson(e))
          .toList(),
    );
  }
}

class EventDetails {
  final String eventId;
  final String eventName;
  final String description;
  final String eventMobile;
  final String eventEmail;
  final String eventStartDate;
  final String eventStartTime;
  final String eventImage;
  final String venue;
  final String date;
  final String time;
  final String dateForHeading;
  final List<dynamic> eventButtonArray;
  final String guest;
  final String entryFee;
  final String locationId;
  final String locationName;
  final String locationOnMap;
  final String link;

  EventDetails({
    required this.eventId,
    required this.eventName,
    required this.description,
    required this.eventMobile,
    required this.eventEmail,
    required this.eventStartDate,
    required this.eventStartTime,
    required this.eventImage,
    required this.venue,
    required this.date,
    required this.time,
    required this.dateForHeading,
    required this.eventButtonArray,
    required this.guest,
    required this.entryFee,
    required this.locationId,
    required this.locationName,
    required this.locationOnMap,
    required this.link,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    return EventDetails(
      eventId: json['eventid'],
      eventName: json['eventname'],
      description: json['description'],
      eventMobile: json['eventmobile'],
      eventEmail: json['eventemail'],
      eventStartDate: json['eventstartdate'],
      eventStartTime: json['eventstarttime'],
      eventImage: json['eventimage'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      dateForHeading: json['date_for_heading'],
      eventButtonArray: json['event_button_array'] ?? [],
      guest: json['guest'],
      entryFee: json['entry_fee'] ?? '',
      locationId: json['location_id'],
      locationName: json['location_name'],
      locationOnMap: json['location_on_map'],
      link: json['link'] ?? '',
    );
  }
}